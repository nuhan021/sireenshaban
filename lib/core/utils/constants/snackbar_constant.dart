import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'colors.dart';

class SnackBarConstant {
  SnackBarConstant._();

  static warning(String message) => Get.snackbar(
    'Warning',
    message,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: AppColors.warning,
    colorText: Colors.black,
    margin: EdgeInsets.all(15.w),
    icon: const Icon(Icons.warning_amber_rounded, color: Colors.black),
  );

  static error(String message) => Get.snackbar(
    'Error',
    message,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: AppColors.error,
    colorText: Colors.black,
    margin: EdgeInsets.all(15.w),
    icon: const Icon(Icons.error_outline_outlined, color: Colors.black),
  );

  static success(String message) => Get.snackbar(
    'Success',
    message,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: AppColors.success,
    colorText: Colors.black,
    margin: EdgeInsets.all(15.w),
    icon: const Icon(Icons.check_circle_outline_rounded, color: Colors.black),
  );
}
