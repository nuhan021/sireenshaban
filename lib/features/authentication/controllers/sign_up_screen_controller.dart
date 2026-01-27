import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sireenshaban/core/utils/constants/snackbar_constant.dart';
import 'package:sireenshaban/core/utils/logging/logger.dart';
import 'package:sireenshaban/routes/app_routes.dart';

import '../../../core/services/network_caller.dart';
import '../../../core/utils/constants/api_constants.dart';

class SignUpScreenController extends GetxController {
  final NetworkCaller _networkCaller;

  SignUpScreenController({NetworkCaller? networkCaller})
    : _networkCaller = networkCaller ?? NetworkCaller();
  RxBool isObscurePassword = true.obs;
  RxBool isObscureRetypePassword = true.obs;
  RxBool isSignUpLoading = false.obs;
  RxBool isOtpLoading = false.obs;
  RxBool isResendOtpLoading = false.obs;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController retypePasswordController =
      TextEditingController();
  String otp = '';

  void togglePasswordVisibility() {
    isObscurePassword.value = !isObscurePassword.value;
  }

  void toggleRetypePasswordVisibility() {
    isObscureRetypePassword.value = !isObscureRetypePassword.value;
  }

  Future<void> signUp(String role) async {
    if (emailController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty ||
        retypePasswordController.text.trim().isEmpty) {
      SnackBarConstant.warning('Please fill all credentials');
      return;
    }

    if (passwordController.text != retypePasswordController.text) {
      SnackBarConstant.warning('Passwords do not match');
      return;
    }

    late String userRole = role.toString().split('.')[1];
    userRole = userRole[0].toUpperCase() + userRole.substring(1);
    AppLoggerHelper.info(userRole);

    isSignUpLoading.value = true;

    final response = await _networkCaller.postRequest(
      ApiConstants.register,
      body: {
        "email": emailController.text.trim(),
        "password": passwordController.text,
        "password_confirmation": retypePasswordController.text,
        "role": userRole,
      },
    );

    if (!response.isSuccess) {
      SnackBarConstant.error(response.errorMessage);
      isSignUpLoading.value = false;
      return;
    }

    isSignUpLoading.value = false;
    SnackBarConstant.success('OTP sent to your email.');

    Get.toNamed(AppRoute.verificationCodeSendSuccessScreen);
  }

  Future<void> verifyOtp(bool isFromSignUpScreen) async {
    AppLoggerHelper.debug(otp);
    if (otp.isEmpty) {
      SnackBarConstant.warning('Please enter the OTP');
      return;
    }

    isOtpLoading.value = true;

    final response = await _networkCaller.postRequest(
      ApiConstants.verifyOtp,
      body: {"email": emailController.text.trim(), "otp": otp},
    );

    if (!response.isSuccess) {
      SnackBarConstant.error(response.errorMessage);
      isOtpLoading.value = false;
      return;
    }

    isOtpLoading.value = false;
    SnackBarConstant.success('OTP verified successfully');

    isFromSignUpScreen
        ? Get.offAllNamed(AppRoute.loginScreen)
        : Get.offAllNamed(AppRoute.changePasswordScreen);
  }

  Future<void> resendOtp() async {
    isResendOtpLoading.value = true;

    final response = await _networkCaller.postRequest(
      ApiConstants.resendOtp,
      body: {"email": emailController.text.trim()},
    );

    if (!response.isSuccess) {
      SnackBarConstant.error(response.errorMessage);
      isResendOtpLoading.value = false;
      return;
    }

    isResendOtpLoading.value = false;
    SnackBarConstant.success('OTP Send successfully');
  }
}
