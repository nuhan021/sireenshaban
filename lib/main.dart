import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:sireenshaban/app.dart';
import 'package:sireenshaban/core/utils/logging/logger.dart';
import 'package:sireenshaban/features/authentication/services/user_info_services.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';

import 'core/services/storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await initializeDateFormatting('en_US', "");
  Stripe.publishableKey =
      "pk_test_51RoJIeDhobi5OiZ3oHj8zXbGeudmmLNnQeDAb12cWe5wkQmDTGRMeoEMyzEUc7qlYbjdhf3nv4G3zJIsPMfjs6vE00tggZfHek";
  await dotenv.load(fileName: ".env");
  await StorageService.init();

  // If a token exists from previous session, fetch the latest profile
  try {
    if (StorageService.hasToken()) {
      final profileFetched = await UserInfoService.fetchAndStoreProfile();
      print('Startup profile fetch result: $profileFetched');
      AppLoggerHelper.info('Startup profile fetch result: $profileFetched');
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
