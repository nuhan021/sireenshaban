import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:sireenshaban/core/services/storage_service.dart';
import 'package:sireenshaban/core/utils/logging/logger.dart';

class FirebaseFCMService {
  static FirebaseMessaging? _firebaseMessaging;

  static FirebaseMessaging get instance {
    _firebaseMessaging ??= FirebaseMessaging.instance;
    return _firebaseMessaging!;
  }

  static Future<void> initialize() async {
    try {
      // Initialize Firebase first
      await Firebase.initializeApp();
      AppLoggerHelper.info('Firebase initialized successfully');

      // Request user permission for notifications (iOS)
      await instance.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      // Get FCM Token
      String? token = await instance.getToken();
      if (token != null) {
        AppLoggerHelper.info('FCM Token: $token');
        // Store token in local storage
        await StorageService.setFCMToken(token);
      }

      // Listen for token refresh
      instance.onTokenRefresh.listen((newToken) {
        AppLoggerHelper.info('FCM Token Refreshed: $newToken');
        StorageService.setFCMToken(newToken);
      });

      AppLoggerHelper.info('Firebase FCM initialized successfully');
    } catch (e) {
      AppLoggerHelper.error('Error initializing Firebase FCM: $e');
    }
  }

  static String? getFCMToken() {
    return StorageService.fcmToken;
  }

  static Future<void> unsubscribeFromTopic(String topic) async {
    try {
      await instance.unsubscribeFromTopic(topic);
      AppLoggerHelper.info('Unsubscribed from topic: $topic');
    } catch (e) {
      AppLoggerHelper.error('Error unsubscribing from topic: $e');
    }
  }

  static Future<void> subscribeToTopic(String topic) async {
    try {
      await instance.subscribeToTopic(topic);
      AppLoggerHelper.info('Subscribed to topic: $topic');
    } catch (e) {
      AppLoggerHelper.error('Error subscribing to topic: $e');
    }
  }
}
