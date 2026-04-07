import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sireenshaban/core/utils/constants/snackbar_constant.dart';
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
  RxBool termsAccepted = false.obs;

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

  bool _isValidEmail(String email) {
    final trimmed = email.trim();
    if (trimmed.isEmpty) return false;
    return RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(trimmed);
  }

  bool _isStrongPassword(String password) {
    if (password.length < 8) return false;
    final hasUpper = RegExp(r'[A-Z]').hasMatch(password);
    final hasLower = RegExp(r'[a-z]').hasMatch(password);
    final hasDigit = RegExp(r'\d').hasMatch(password);
    final hasSpecial = RegExp(r'[!@#$%^&*(),.?":{}|<>_\-+=/\\\[\]]')
        .hasMatch(password);
    return hasUpper && hasLower && hasDigit && hasSpecial;
  }

  bool _isValidOtp(String value) {
    final trimmed = value.trim();
    return trimmed.length == 6 && RegExp(r'^\d{6}$').hasMatch(trimmed);
  }

  Future<void> signUp(String role) async {
    final email = emailController.text.trim();
    final password = passwordController.text;
    final retypePassword = retypePasswordController.text;

    if (email.isEmpty ||
        password.trim().isEmpty ||
        retypePassword.trim().isEmpty) {
      SnackBarConstant.warning('Please fill all credentials');
      return;
    }

    if (!_isValidEmail(email)) {
      SnackBarConstant.warning('Please enter a valid email address');
      return;
    }

    if (!_isStrongPassword(password)) {
      SnackBarConstant.warning(
        'Password must be at least 8 characters and include upper, lower, number, and special character',
      );
      return;
    }

    if (password != retypePassword) {
      SnackBarConstant.warning('Passwords do not match');
      return;
    }

    if (!termsAccepted.value) {
      SnackBarConstant.warning('Please agree to the Terms of Use');
      return;
    }

    late String userRole = role.toString().split('.')[1];
    userRole = userRole[0].toUpperCase() + userRole.substring(1);
    isSignUpLoading.value = true;

    final response = await _networkCaller.postRequest(
      ApiConstants.register,
      body: {
        "email": email,
        "password": password,
        "password_confirmation": retypePassword,
        "role": userRole,
      },
    );

    if (!response.isSuccess) {
      if (response.statusCode == 408) {
        SnackBarConstant.error('Network timeout. Please try again.');
      } else {
        SnackBarConstant.error(response.errorMessage);
      }
      isSignUpLoading.value = false;
      return;
    }

    isSignUpLoading.value = false;
    SnackBarConstant.success('OTP sent to your email.');

    Get.toNamed(AppRoute.verificationCodeSendSuccessScreen);
  }

  Future<void> verifyOtp(bool isFromSignUpScreen) async {
    final email = emailController.text.trim();
    final trimmedOtp = otp.trim();
    if (email.isEmpty || !_isValidEmail(email)) {
      SnackBarConstant.warning('Please enter a valid email address');
      return;
    }
    if (trimmedOtp.isEmpty) {
      SnackBarConstant.warning('Please enter the OTP');
      return;
    }
    if (!_isValidOtp(trimmedOtp)) {
      SnackBarConstant.warning('OTP must be 6 digits');
      return;
    }

    isOtpLoading.value = true;

    final response = await _networkCaller.postRequest(
      ApiConstants.verifyOtp,
      body: {"email": email, "otp": trimmedOtp},
    );

    if (!response.isSuccess) {
      if (response.statusCode == 408) {
        SnackBarConstant.error('Network timeout. Please try again.');
      } else {
        SnackBarConstant.error(response.errorMessage);
      }
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
    final email = emailController.text.trim();
    if (email.isEmpty || !_isValidEmail(email)) {
      SnackBarConstant.warning('Please enter a valid email address');
      return;
    }

    isResendOtpLoading.value = true;

    final response = await _networkCaller.postRequest(
      ApiConstants.resendOtp,
      body: {"email": email},
    );

    if (!response.isSuccess) {
      if (response.statusCode == 408) {
        SnackBarConstant.error('Network timeout. Please try again.');
      } else {
        SnackBarConstant.error(response.errorMessage);
      }
      isResendOtpLoading.value = false;
      return;
    }

    isResendOtpLoading.value = false;
    SnackBarConstant.success('OTP Send successfully');
  }
}
