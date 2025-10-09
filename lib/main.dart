import 'package:flutter/services.dart';
import 'package:sireenshaban/app.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';

void main() {

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
    ),
  );



  runApp(
    DevicePreview(
      // enabled: !kReleaseMode,
      enabled: true,
      builder: (context) => MyApp(),
    ),
  );
}

