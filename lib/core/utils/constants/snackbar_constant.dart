import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'colors.dart';

class SnackBarConstant {
  SnackBarConstant._();

  static SnackbarController warning(String message) => Get.snackbar(
    'Warning',
    message,
    snackPosition: SnackPosition.TOP,
    backgroundColor: AppColors.warning,
    colorText: Colors.black,
    margin: EdgeInsets.all(15),
    icon: const Icon(Icons.warning_amber_rounded, color: Colors.black),
  );

  static SnackbarController error(String message) => Get.snackbar(
    'Error',
    message,
    snackPosition: SnackPosition.TOP,
    backgroundColor: AppColors.error,
    colorText: Colors.black,
    margin: EdgeInsets.all(15),
    icon: const Icon(Icons.error_outline_outlined, color: Colors.black),
  );

  static SnackbarController success(String message) => Get.snackbar(
    'Success',
    message,
    snackPosition: SnackPosition.TOP,
    backgroundColor: AppColors.success,
    colorText: Colors.black,
    margin: EdgeInsets.all(15),
    icon: const Icon(Icons.check_circle_outline_rounded, color: Colors.black),
  );
}
