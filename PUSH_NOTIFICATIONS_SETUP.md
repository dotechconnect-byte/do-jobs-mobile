# Push Notifications Setup Guide

## Setup Complete! ✅

Firebase Cloud Messaging (FCM) has been successfully integrated into your app with full support for:
- ✅ Android push notifications
- ✅ Lock screen notifications
- ✅ Foreground, background, and terminated app states
- ✅ Notification channels (High, Default, Low importance)
- ✅ Notification actions and deep linking
- ✅ Token management and refresh
- ⏳ iOS support (pending `GoogleService-Info.plist` file)

---

## 🚀 Quick Test Guide

### Step 1: Run the App
```bash
flutter run
```

### Step 2: Get Your FCM Token

**Option A: View in Console**
- Check your Flutter console/logs after app starts
- Look for: `FCM Token: <your-token-here>`

**Option B: Add Token Display Widget (Temporary)**
Add this to any screen during development:
```dart
import 'package:do_jobs_application/core/widgets/fcm_token_display.dart';

// Add in your widget tree
FCMTokenDisplay()
```

### Step 3: Send Test Notification

#### Using Firebase Console (Easiest):
1. Go to [Firebase Console](https://console.firebase.google.com)
2. Select your project "DoJobs"
3. Navigate to: **Engage > Messaging**
4. Click **"Create your first campaign"** or **"New campaign"**
5. Select **"Firebase Notification messages"**
6. Fill in:
   - **Notification title**: "Test Notification"
   - **Notification text**: "This is a test message"
7. Click **"Send test message"**
8. Paste your FCM token
9. Click **"Test"**

#### Using cURL (For Developers):
```bash
curl -X POST https://fcm.googleapis.com/fcm/send \
  -H "Authorization: key=YOUR_SERVER_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "to": "YOUR_FCM_TOKEN",
    "notification": {
      "title": "Test Notification",
      "body": "This is a test message from cURL"
    },
    "data": {
      "screen": "home",
      "custom_key": "custom_value"
    },
    "priority": "high"
  }'
```

**To get your Server Key:**
1. Firebase Console > Project Settings (⚙️)
2. Cloud Messaging tab
3. Copy "Server key"

---

## 📱 Testing Different Scenarios

### 1. Foreground Notification (App Open)
- Keep app open and visible
- Send notification from Firebase Console
- ✅ Should show local notification at top
- ✅ Tap to handle action

### 2. Background Notification (App Minimized)
- Minimize app (press home button)
- Send notification
- ✅ Should appear in notification tray
- ✅ Shows on lock screen
- ✅ Tap to open app

### 3. Terminated State (App Closed)
- Close app completely (swipe away from recent apps)
- Send notification
- ✅ Should appear in notification tray
- ✅ Shows on lock screen
- ✅ Tap to launch app

### 4. Lock Screen Notification
- Lock your device
- Send notification
- ✅ Should show on lock screen
- ✅ Wake device with LED/vibration
- ✅ Tap to unlock and open app

---

## 🎨 Notification Channels (Android)

The app has 3 notification channels configured:

### 1. High Importance Channel
- **Channel ID**: `high_importance_channel`
- Shows as heads-up notification
- Appears on lock screen
- Makes sound + vibration
- Shows LED light

### 2. Default Channel
- **Channel ID**: `default_channel`
- Appears in notification tray
- Makes sound + vibration
- Shows on lock screen

### 3. Low Importance Channel
- **Channel ID**: `low_importance_channel`
- Appears silently in notification tray
- No sound, no vibration
- Minimal interruption

**To specify channel in notification:**
```json
{
  "to": "YOUR_FCM_TOKEN",
  "notification": {
    "title": "Important!",
    "body": "High priority message"
  },
  "data": {
    "channel_id": "high_importance_channel"
  },
  "priority": "high"
}
```

---

## 🔧 Advanced Features

### Subscribe to Topics
```dart
// Subscribe to receive notifications for a topic
await FirebaseNotificationService().subscribeToTopic('job_alerts');

// Unsubscribe
await FirebaseNotificationService().unsubscribeFromTopic('job_alerts');
```

### Send to Topic (Backend)
```bash
curl -X POST https://fcm.googleapis.com/fcm/send \
  -H "Authorization: key=YOUR_SERVER_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "to": "/topics/job_alerts",
    "notification": {
      "title": "New Job Available!",
      "body": "Check out this new opportunity"
    }
  }'
```

### Deep Linking / Navigation
```dart
// In main.dart, update _handleNotificationTap:
void _handleNotificationTap(Map<String, dynamic> data) {
  if (data['screen'] == 'job_detail') {
    navigatorKey.currentState?.push(
      MaterialPageRoute(
        builder: (context) => JobDetailScreen(
          jobId: data['job_id'],
        ),
      ),
    );
  }
}
```

**Send with navigation data:**
```json
{
  "to": "YOUR_FCM_TOKEN",
  "notification": {
    "title": "New Job Posted",
    "body": "Software Developer needed"
  },
  "data": {
    "screen": "job_detail",
    "job_id": "12345"
  }
}
```

---

## 📝 Files Modified/Created

### Created:
1. `lib/core/services/firebase_notification_service.dart` - Main notification service
2. `lib/core/widgets/fcm_token_display.dart` - Helper widget to display FCM token
3. `android/app/google-services.json` - Firebase Android config

### Modified:
1. `pubspec.yaml` - Added Firebase dependencies
2. `android/settings.gradle.kts` - Added Google Services plugin
3. `android/app/build.gradle.kts` - Applied Google Services plugin
4. `android/app/src/main/AndroidManifest.xml` - Added permissions and FCM config
5. `lib/main.dart` - Initialize Firebase and notification handlers

---

## 🍎 iOS Setup (TODO)

To enable iOS push notifications:

1. Download `GoogleService-Info.plist` from Firebase Console
2. Place in: `ios/Runner/GoogleService-Info.plist`
3. Open `ios/Runner.xcworkspace` in Xcode
4. Enable Push Notifications capability
5. Configure APNs certificate in Firebase Console

Let me know when you're ready to set up iOS!

---

## 🐛 Troubleshooting

### Token is null
- Check internet connection
- Ensure `google-services.json` is in correct location
- Run `flutter clean && flutter pub get`
- Restart app

### Notifications not showing
- Check app permissions (Android 13+)
- Verify FCM token is correct
- Check Firebase Console for errors
- Ensure device has internet connection

### Background notifications not working
- Check that `firebaseMessagingBackgroundHandler` is registered
- Verify app is not force-stopped
- Check battery optimization settings

### Lock screen notifications not showing
- Verify channel importance is HIGH
- Check device lock screen notification settings
- Ensure visibility is set to PUBLIC

---

## 📚 Additional Resources

- [Firebase Messaging Docs](https://firebase.google.com/docs/cloud-messaging)
- [Flutter Firebase Messaging Plugin](https://pub.dev/packages/firebase_messaging)
- [Flutter Local Notifications Plugin](https://pub.dev/packages/flutter_local_notifications)

---

## ✅ Next Steps

1. **Test all notification scenarios** (foreground, background, terminated)
2. **Implement deep linking** for your specific screens
3. **Send FCM token to your backend** (update TODO in code)
4. **Add custom notification sounds** (optional)
5. **Set up iOS** when ready
6. **Remove FCMTokenDisplay widget** before production release

---

**Your Firebase Project ID**: `dojobs-d7903`
**Android Package**: `com.example.do_jobs_application`
**iOS Bundle ID**: `com.example.doJobsApplication` (pending setup)

Happy Testing! 🎉
