import 'dart:async';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/foundation.dart';

/// Top-level function to handle background messages
/// This runs in a separate isolate and must be top-level
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (kDebugMode) {
    print('Handling background message: ${message.messageId}');
    print('Title: ${message.notification?.title}');
    print('Body: ${message.notification?.body}');
    print('Data: ${message.data}');
  }
}

class FirebaseNotificationService {
  static final FirebaseNotificationService _instance =
      FirebaseNotificationService._internal();
  factory FirebaseNotificationService() => _instance;
  FirebaseNotificationService._internal();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  // Stream controller for notification taps
  final StreamController<Map<String, dynamic>> _notificationTapController =
      StreamController<Map<String, dynamic>>.broadcast();

  Stream<Map<String, dynamic>> get onNotificationTap =>
      _notificationTapController.stream;

  // FCM Token stream
  final StreamController<String> _tokenController =
      StreamController<String>.broadcast();

  Stream<String> get onTokenRefresh => _tokenController.stream;

  String? _fcmToken;
  String? get fcmToken => _fcmToken;

  /// Initialize Firebase Messaging and Local Notifications
  Future<void> initialize() async {
    try {
      // Request notification permissions
      await _requestPermissions();

      // Initialize local notifications
      await _initializeLocalNotifications();

      // Get FCM token
      await _getFCMToken();

      // Setup message handlers
      _setupMessageHandlers();

      // Listen to token refresh
      _firebaseMessaging.onTokenRefresh.listen((newToken) {
        _fcmToken = newToken;
        _tokenController.add(newToken);
        if (kDebugMode) {
          print('FCM Token refreshed: $newToken');
        }
      });

      if (kDebugMode) {
        print('Firebase Notification Service initialized successfully');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error initializing Firebase Notification Service: $e');
      }
    }
  }

  /// Request notification permissions
  Future<void> _requestPermissions() async {
    if (Platform.isIOS) {
      // Request iOS permissions
      NotificationSettings settings = await _firebaseMessaging.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        carPlay: false,
        criticalAlert: true,
        provisional: false,
        sound: true,
      );

      if (kDebugMode) {
        print('iOS Notification Permission Status: ${settings.authorizationStatus}');
      }
    } else if (Platform.isAndroid) {
      // Request Android 13+ notification permission
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
          _localNotifications.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();

      if (androidImplementation != null) {
        await androidImplementation.requestNotificationsPermission();
        await androidImplementation.requestExactAlarmsPermission();
      }
    }
  }

  /// Initialize Flutter Local Notifications
  Future<void> _initializeLocalNotifications() async {
    // Android initialization settings
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // iOS initialization settings
    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      requestCriticalPermission: true,
    );

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await _localNotifications.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
      onDidReceiveBackgroundNotificationResponse: _onNotificationTapped,
    );

    // Create Android notification channels
    await _createNotificationChannels();
  }

  /// Create Android notification channels with different importance levels
  Future<void> _createNotificationChannels() async {
    if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
          _localNotifications.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();

      if (androidImplementation != null) {
        // High importance channel (shows on lock screen, makes sound, heads-up)
        const AndroidNotificationChannel highImportanceChannel =
            AndroidNotificationChannel(
          'high_importance_channel',
          'High Importance Notifications',
          description: 'This channel is used for important notifications',
          importance: Importance.high,
          enableVibration: true,
          enableLights: true,
          showBadge: true,
          playSound: true,
        );

        // Default channel
        const AndroidNotificationChannel defaultChannel =
            AndroidNotificationChannel(
          'default_channel',
          'Default Notifications',
          description: 'This channel is used for general notifications',
          importance: Importance.defaultImportance,
          enableVibration: true,
          showBadge: true,
        );

        // Low importance channel
        const AndroidNotificationChannel lowImportanceChannel =
            AndroidNotificationChannel(
          'low_importance_channel',
          'Low Importance Notifications',
          description: 'This channel is used for less important notifications',
          importance: Importance.low,
          showBadge: false,
        );

        // Create channels
        await androidImplementation.createNotificationChannel(highImportanceChannel);
        await androidImplementation.createNotificationChannel(defaultChannel);
        await androidImplementation.createNotificationChannel(lowImportanceChannel);

        if (kDebugMode) {
          print('Android notification channels created');
        }
      }
    }
  }

  /// Get FCM Token
  Future<void> _getFCMToken() async {
    try {
      _fcmToken = await _firebaseMessaging.getToken();
      if (_fcmToken != null) {
        _tokenController.add(_fcmToken!);
        if (kDebugMode) {
          print('FCM Token: $_fcmToken');
        }
        // TODO: Send token to your backend server
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error getting FCM token: $e');
      }
    }
  }

  /// Setup message handlers for different app states
  void _setupMessageHandlers() {
    // Handle messages when app is in foreground
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

    // Handle messages when app is opened from terminated state
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessageOpenedApp);

    // Check if app was opened from a terminated state by tapping notification
    _checkInitialMessage();

    // Register background message handler
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }

  /// Handle foreground messages (app is open and visible)
  Future<void> _handleForegroundMessage(RemoteMessage message) async {
    if (kDebugMode) {
      print('Foreground message received: ${message.messageId}');
      print('Title: ${message.notification?.title}');
      print('Body: ${message.notification?.body}');
      print('Data: ${message.data}');
    }

    // Show local notification when app is in foreground
    await _showLocalNotification(message);
  }

  /// Handle messages when app is opened from background
  void _handleMessageOpenedApp(RemoteMessage message) {
    if (kDebugMode) {
      print('Message opened app: ${message.messageId}');
      print('Data: ${message.data}');
    }

    // Handle navigation or action based on notification data
    _notificationTapController.add(message.data);
  }

  /// Check if app was opened from terminated state by notification
  Future<void> _checkInitialMessage() async {
    RemoteMessage? initialMessage =
        await _firebaseMessaging.getInitialMessage();

    if (initialMessage != null) {
      if (kDebugMode) {
        print('App opened from terminated state by notification');
        print('Data: ${initialMessage.data}');
      }

      // Handle navigation or action
      _notificationTapController.add(initialMessage.data);
    }
  }

  /// Show local notification (for foreground messages)
  Future<void> _showLocalNotification(RemoteMessage message) async {
    final RemoteNotification? notification = message.notification;
    final Map<String, dynamic> data = message.data;

    if (notification != null) {
      // Determine channel ID based on priority or custom data
      String channelId = data['channel_id'] ?? 'high_importance_channel';

      // Check if notification has an image
      final String? imageUrl = notification.android?.imageUrl ??
                               notification.apple?.imageUrl ??
                               data['image'];

      // Prepare style information with image support
      StyleInformation? styleInformation;
      if (imageUrl != null && imageUrl.isNotEmpty) {
        // Use BigPictureStyleInformation for images from URL
        styleInformation = BigPictureStyleInformation(
          DrawableResourceAndroidBitmap('@mipmap/ic_launcher'), // Placeholder while loading
          largeIcon: DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
          contentTitle: notification.title,
          htmlFormatContentTitle: true,
          summaryText: notification.body,
          htmlFormatSummaryText: true,
        );

        if (kDebugMode) {
          print('Notification image URL: $imageUrl');
        }
      } else if (notification.body != null) {
        // Use BigTextStyleInformation for long text
        styleInformation = BigTextStyleInformation(
          notification.body!,
          htmlFormatBigText: true,
          contentTitle: notification.title,
          htmlFormatContentTitle: true,
        );
      }

      // Android notification details
      AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
        channelId,
        channelId == 'high_importance_channel'
            ? 'High Importance Notifications'
            : channelId == 'default_channel'
                ? 'Default Notifications'
                : 'Low Importance Notifications',
        channelDescription: 'Notification channel for ${notification.title}',
        importance: channelId == 'high_importance_channel'
            ? Importance.high
            : channelId == 'low_importance_channel'
                ? Importance.low
                : Importance.defaultImportance,
        priority: channelId == 'high_importance_channel'
            ? Priority.high
            : channelId == 'low_importance_channel'
                ? Priority.low
                : Priority.defaultPriority,
        ticker: notification.title,
        enableVibration: true,
        enableLights: true,
        showWhen: true,
        when: DateTime.now().millisecondsSinceEpoch,
        usesChronometer: false,
        playSound: true,
        // Show on lock screen
        visibility: NotificationVisibility.public,
        // Show as heads-up notification
        fullScreenIntent: channelId == 'high_importance_channel',
        // Add action buttons if provided
        actions: _buildNotificationActions(data),
        // Custom style with image or text support
        styleInformation: styleInformation,
      );

      // iOS notification details
      const DarwinNotificationDetails iOSDetails = DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
        sound: 'notification.aiff',
        interruptionLevel: InterruptionLevel.timeSensitive,
      );

      NotificationDetails platformDetails = NotificationDetails(
        android: androidDetails,
        iOS: iOSDetails,
      );

      // Show notification
      await _localNotifications.show(
        message.hashCode,
        notification.title,
        notification.body,
        platformDetails,
        payload: message.data.toString(),
      );
    }
  }

  /// Build notification action buttons based on data
  List<AndroidNotificationAction>? _buildNotificationActions(
      Map<String, dynamic> data) {
    if (data.containsKey('actions')) {
      // Parse and create action buttons
      // Example: data['actions'] = ['View', 'Dismiss']
      return null; // Implement based on your requirements
    }
    return null;
  }

  /// Handle notification tap (local notifications)
  @pragma('vm:entry-point')
  static void _onNotificationTapped(NotificationResponse response) {
    if (kDebugMode) {
      print('Notification tapped: ${response.payload}');
    }

    // Parse payload and handle navigation
    if (response.payload != null) {
      // Add to stream for handling in app
      FirebaseNotificationService()
          ._notificationTapController
          .add({'payload': response.payload});
    }
  }

  /// Subscribe to a topic
  Future<void> subscribeToTopic(String topic) async {
    try {
      await _firebaseMessaging.subscribeToTopic(topic);
      if (kDebugMode) {
        print('Subscribed to topic: $topic');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error subscribing to topic: $e');
      }
    }
  }

  /// Unsubscribe from a topic
  Future<void> unsubscribeFromTopic(String topic) async {
    try {
      await _firebaseMessaging.unsubscribeFromTopic(topic);
      if (kDebugMode) {
        print('Unsubscribed from topic: $topic');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error unsubscribing from topic: $e');
      }
    }
  }

  /// Update badge count (iOS)
  Future<void> setBadgeCount(int count) async {
    if (Platform.isIOS) {
      // iOS badge handling
      // You may need additional plugin for badge management
    }
  }

  /// Clear all notifications
  Future<void> clearAllNotifications() async {
    await _localNotifications.cancelAll();
  }

  /// Clear specific notification
  Future<void> clearNotification(int id) async {
    await _localNotifications.cancel(id);
  }

  /// Dispose resources
  void dispose() {
    _notificationTapController.close();
    _tokenController.close();
  }
}
