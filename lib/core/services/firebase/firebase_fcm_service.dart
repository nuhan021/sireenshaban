import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
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
      await Firebase.initializeApp();
      AppLoggerHelper.info('Firebase initialized successfully');

      // Permission
      await instance.requestPermission(
        alert: true,
        badge: true,
        sound: true,
        provisional: false,
      );

      String? fcmToken;

      // iOS/Mac এর জন্য APNS handling
      if (defaultTargetPlatform == TargetPlatform.iOS ||
          defaultTargetPlatform == TargetPlatform.macOS) {
        AppLoggerHelper.info('iOS detected - handling APNS token...');

        String? apnsToken;
        const int maxRetries = 5; // আরও বেশি retry
        for (int i = 0; i < maxRetries; i++) {
          apnsToken = await instance.getAPNSToken();
          if (apnsToken != null) {
            AppLoggerHelper.info(
              '✅ APNS Token received on attempt ${i + 1}: $apnsToken',
            );
            break;
          }
          AppLoggerHelper.info(
            'APNS token null on attempt ${i + 1}, waiting...',
          );
          await Future.delayed(
            const Duration(seconds: 1),
          ); // 1 সেকেন্ড করে অপেক্ষা
        }

        if (apnsToken == null) {
          AppLoggerHelper.warning(
            '⚠️ APNS token still null after retries. Continuing anyway...',
          );
          // এখানে crash করবেন না, শুধু warning দিন
        }
      }

      // FCM Token নেওয়ার চেষ্টা (APNS null হলেও চালিয়ে যান)
      try {
        fcmToken = await instance.getToken();
        AppLoggerHelper.info('FCM Token: ${fcmToken ?? "null"}');
      } catch (tokenError) {
        AppLoggerHelper.error('FCM getToken failed: $tokenError');
        // Simulator-এ error হলে ignore করুন
      }

      if (fcmToken != null) {
        await StorageService.setFCMToken(fcmToken);
      }

      // Token refresh listener
      instance.onTokenRefresh.listen((newToken) {
        AppLoggerHelper.info('FCM Token Refreshed: $newToken');
        StorageService.setFCMToken(newToken);
      });

      AppLoggerHelper.info(
        'Firebase FCM initialized (with possible APNS warning)',
      );
    } catch (e, stack) {
      AppLoggerHelper.error('Error initializing Firebase FCM: $e\n$stack');
      // কখনোই main() crash করাবেন না — শুধু log করুন
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
