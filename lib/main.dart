import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:sireenshaban/app.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';

import 'core/services/storage_service.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  // await initializeDateFormatting('en_US', "");
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

