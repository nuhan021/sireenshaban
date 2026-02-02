import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:sireenshaban/app.dart';
import 'package:sireenshaban/core/services/firebase/firebase_fcm_service.dart';
import 'package:sireenshaban/core/services/firebase/push_notification_handler.dart';
import 'package:sireenshaban/core/utils/logging/logger.dart';
import 'package:sireenshaban/features/authentication/services/user_info_services.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';

import 'core/services/storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await initializeDateFormatting('en_US', "");
  await dotenv.load(fileName: ".env");
  final stripeKey = dotenv.env['STRIPE_PUBLISHABLE_KEY'];
  if (stripeKey != null && stripeKey.isNotEmpty) {
    Stripe.publishableKey = stripeKey;
  } else {
    AppLoggerHelper.error('Stripe publishable key not found in .env file');
  }
  await StorageService.init();
  
  // Load stored token and userId into cache for quick access
  try {
    final cachedToken = await StorageService.getTokenAsync();
    if (cachedToken != null) {
      await StorageService.cacheToken(cachedToken);
    }
    final cachedUserId = await StorageService.getUserId();
    if (cachedUserId != null) {
      await StorageService.cacheUserId(cachedUserId);
    }
  } catch (e) {
    AppLoggerHelper.error('Failed to cache credentials: $e');
  }

  // Initialize Firebase FCM
  await FirebaseFCMService.initialize();
  await PushNotificationHandler.initialize();
  PushNotificationHandler.configure();

  // If a token exists from previous session, fetch the latest profile
  try {
    if (StorageService.hasToken()) {
      await UserInfoService.fetchAndStoreProfile();
    }
  } catch (e) {
    AppLoggerHelper.error('Startup profile fetch failed: $e');
  }

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
    ),
  );

  runApp(
    DevicePreview(
      // enabled: !kReleaseMode,
      enabled: false,
      builder: (context) => MyApp(),
    ),
  );
}
