import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:sireenshaban/core/utils/logging/logger.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  AppLoggerHelper.info('Handling background message: ${message.messageId}');
  _handleMessage(message);
}

void _handleMessage(RemoteMessage message) {
  AppLoggerHelper.info('=== Notification Received ===');
  AppLoggerHelper.info('Title: ${message.notification?.title}');
  AppLoggerHelper.info('Body: ${message.notification?.body}');
  AppLoggerHelper.info('Data: ${message.data}');
}

class PushNotificationHandler {
  static void configure() {
    // Handle background messages
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Handle foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      AppLoggerHelper.info('Foreground notification received');
      _handleMessage(message);
      _showForegroundNotification(message);
    });

    // Handle notification tap when app is in background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      AppLoggerHelper.info(
        'Notification tapped - navigating to: ${message.data['screen']}',
      );
      _navigateToScreen(message.data['screen']);
    });
  }

  static void _showForegroundNotification(RemoteMessage message) {
    // You can use local notifications plugin here if needed
    // For now, just logging
    AppLoggerHelper.info(
      'Foreground notification - Title: ${message.notification?.title}',
    );
  }

  static void _navigateToScreen(String? screen) {
    if (screen != null && screen.isNotEmpty) {
      // Handle navigation based on screen parameter from backend
      // Example: Navigator.pushNamed(context, screen);
      AppLoggerHelper.info('Navigate to screen: $screen');
    }
  }
}
