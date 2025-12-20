import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:sireenshaban/app.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';

import 'core/services/storage_service.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  // await initializeDateFormatting('en_US', "");
  Stripe.publishableKey = "pk_test_51RTEbLFT92q9uNcDVhh5ojhH4AaEanWSPbbTgWCOKjBUnsmhccT5bYt3nKWcm3etcmKrZ6kSP4cjFGMqSoFRHRzP00WCjN0XbD";
  await dotenv.load(fileName: ".env");
  await StorageService.init();

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

