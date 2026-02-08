import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/consts/theme_manager.dart';
import 'core/providers/theme_provider.dart';
import 'core/services/firebase_notification_service.dart';
import 'features/onboarding/presentation/pages/onboarding_screen.dart';
import 'injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize dependency injection
  setupLocator();

  // Initialize Firebase
  await Firebase.initializeApp();

  // Initialize Firebase Notification Service
  await FirebaseNotificationService().initialize();

  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    _setupNotificationHandlers();
  }

  void _setupNotificationHandlers() {
    // Listen to notification taps
    FirebaseNotificationService().onNotificationTap.listen((data) {
      _handleNotificationTap(data);
    });

    // Listen to FCM token updates
    FirebaseNotificationService().onTokenRefresh.listen((token) {
      debugPrint('New FCM Token: $token');
      // TODO: Send token to your backend server
    });
  }

  void _handleNotificationTap(Map<String, dynamic> data) {
    // Handle navigation based on notification data
    debugPrint('Notification tapped with data: $data');

    // Example: Navigate to specific screen based on data
    // if (data.containsKey('screen')) {
    //   String screen = data['screen'];
    //   if (screen == 'job_detail' && data.containsKey('job_id')) {
    //     navigatorKey.currentState?.push(
    //       MaterialPageRoute(
    //         builder: (context) => JobDetailScreen(jobId: data['job_id']),
    //       ),
    //     );
    //   }
    // }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return Consumer<ThemeProvider>(
          builder: (context, themeProvider, child) {
            return MaterialApp(
              navigatorKey: navigatorKey,
              title: 'DO - Your Gig Work Companion',
              debugShowCheckedModeBanner: false,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: themeProvider.themeMode,
              home: const OnboardingScreen(),
            );
          },
        );
      },
    );
  }
}
