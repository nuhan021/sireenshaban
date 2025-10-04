import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/utils/constants/image_path.dart';
import '../../../../routes/app_routes.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {

    Timer(const Duration(seconds: 2), () {
      Get.offNamed(AppRoute.onboardingScreen);
    });


    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Image.asset(ImagePath.splashImg, height: 200.h,)
      ),
    );
  }
}
