import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../services/firebase_notification_service.dart';

/// Widget to display and copy FCM token for testing
/// Use this widget temporarily during development to get the FCM token
class FCMTokenDisplay extends StatefulWidget {
  const FCMTokenDisplay({super.key});

  @override
  State<FCMTokenDisplay> createState() => _FCMTokenDisplayState();
}

class _FCMTokenDisplayState extends State<FCMTokenDisplay> {
  String? _token;

  @override
  void initState() {
    super.initState();
    _loadToken();
  }

  void _loadToken() {
    setState(() {
      _token = FirebaseNotificationService().fcmToken;
    });

    // Listen for token updates
    FirebaseNotificationService().onTokenRefresh.listen((token) {
      setState(() {
        _token = token;
      });
    });
  }

  void _copyToken() {
    if (_token != null) {
      Clipboard.setData(ClipboardData(text: _token!));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('FCM Token copied to clipboard!'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'FCM Token (For Testing)',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            if (_token != null) ...[
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: SelectableText(
                  _token!,
                  style: const TextStyle(
                    fontSize: 12,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
              const SizedBox(height: 8),
              ElevatedButton.icon(
                onPressed: _copyToken,
                icon: const Icon(Icons.copy),
                label: const Text('Copy Token'),
              ),
            ] else ...[
              const CircularProgressIndicator(),
              const SizedBox(height: 8),
              const Text('Loading token...'),
            ],
          ],
        ),
      ),
    );
  }
}
