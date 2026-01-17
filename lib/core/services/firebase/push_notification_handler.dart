import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
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
  static final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    // Initialize local notifications
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings iosInitializationSettings =
        DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
        );

    const InitializationSettings initializationSettings =
        InitializationSettings(
          android: androidInitializationSettings,
          iOS: iosInitializationSettings,
        );

    await _localNotificationsPlugin.initialize(initializationSettings);
  }

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

  static Future<void> _showForegroundNotification(RemoteMessage message) async {
    try {
      final String title = message.notification?.title ?? 'Notification';
      final String body = message.notification?.body ?? '';

      AppLoggerHelper.info('Showing foreground notification - Title: $title');

      const AndroidNotificationDetails androidNotificationDetails =
          AndroidNotificationDetails(
            'sireenshaban_notifications',
            'Default Notifications',
            channelDescription: 'Default notification channel',
            importance: Importance.max,
            priority: Priority.high,
            showWhen: true,
          );

      const DarwinNotificationDetails iosNotificationDetails =
          DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          );

      const NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails,
        iOS: iosNotificationDetails,
      );

      await _localNotificationsPlugin.show(
        message.messageId.hashCode,
        title,
        body,
        notificationDetails,
      );
    } catch (e) {
      AppLoggerHelper.error('Error showing foreground notification: $e');
    }
  }

  static void _navigateToScreen(String? screen) {
    if (screen != null && screen.isNotEmpty) {
      // Handle navigation based on screen parameter from backend
      // Example: Navigator.pushNamed(context, screen);
      AppLoggerHelper.info('Navigate to screen: $screen');
    }
  }
}
