import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sireenshaban/core/services/firebase/fcm_token_service.dart';
import 'package:sireenshaban/core/services/network_caller.dart';
import 'package:sireenshaban/core/services/storage_service.dart';
import 'package:sireenshaban/core/utils/constants/api_constants.dart';
import 'package:sireenshaban/core/utils/constants/snackbar_constant.dart';
import 'package:sireenshaban/core/utils/logging/logger.dart';
import 'package:sireenshaban/features/authentication/services/user_info_services.dart';
import 'package:sireenshaban/features/authentication/models/loginModel.dart';

import '../../../routes/app_routes.dart';

class LoginController extends GetxController {
  final NetworkCaller _networkCaller;

  LoginController({NetworkCaller? networkCaller})
    : _networkCaller = networkCaller ?? NetworkCaller();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  RxBool isObscure = true.obs;

  RxBool isLogInLoading = false.obs;

  Rx<LoginModel?> loginModel = Rx<LoginModel?>(null);

  void togglePasswordVisibility() {
    isObscure.value = !isObscure.value;
  }

  bool _isValidEmail(String email) {
    final trimmed = email.trim();
    if (trimmed.isEmpty) return false;
    return RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(trimmed);
  }

  Future<void> _handleAuthExpired() async {
    await StorageService.logoutUser();
    SnackBarConstant.error('Session expired. Please log in again.');
  }

  Future<void> login() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      SnackBarConstant.warning('Please fill all the fields');
      return;
    }

    if (!_isValidEmail(email)) {
      SnackBarConstant.warning('Please enter a valid email address');
      return;
    }

    isLogInLoading.value = true;

    final response = await _networkCaller.postRequest(
      ApiConstants.login,
      body: {
        "email": email,
        "password": password,
      },
    );

    if (!response.isSuccess) {
      if (response.statusCode == 401 ||
          response.errorMessage.toLowerCase().contains('token expired')) {
        await _handleAuthExpired();
        isLogInLoading.value = false;
        return;
      }
      if (response.statusCode == 408) {
        SnackBarConstant.error('Network timeout. Please try again.');
        isLogInLoading.value = false;
        return;
      }
      SnackBarConstant.error(response.errorMessage);
      isLogInLoading.value = false;
      return;
    }

    loginModel.value = LoginModel.fromJson(response.responseData);

    isLogInLoading.value = false;

    // Save token and role
    await StorageService.saveToken(
      loginModel.value!.data.token,
      loginModel.value!.data.user.id.toString(),
    );
    await StorageService.saveRole(loginModel.value!.data.user.role);
    if (loginModel.value!.data.user.role == 'Vendor' &&
        loginModel.value!.data.vendor.id > 0) {
      await StorageService.saveVendorId(loginModel.value!.data.vendor.id);
    }

    // Fetch user profile immediately and store it for app-wide access
    try {
      final profileFetched = await UserInfoService.fetchAndStoreProfile();

      AppLoggerHelper.info('Profile fetch result: $profileFetched');
    } catch (e) {
      AppLoggerHelper.error('Profile fetch exception: $e');
    }

    // Send FCM token to backend
    try {
      final fcmService = FCMTokenService();
      await fcmService.sendFCMTokenToBackend();
    } catch (e) {
      AppLoggerHelper.error('Error sending FCM token: $e');
    }

    SnackBarConstant.success("Login successful");

    if (loginModel.value!.data.user.role == 'Vendor') {
      if (loginModel.value!.data.user.isFirstTime) {
        Get.offAllNamed(AppRoute.vendorSetupScreen);
        // Get.offAllNamed(AppRoute.subscriptionScreen);
      } else {
        Get.offAllNamed(AppRoute.vendorBottomNavBar);
      }
    } else {
      if (loginModel.value!.data.user.isFirstTime) {
        Get.offAllNamed(AppRoute.customerInterestScreen);
      } else {
        Get.offAllNamed(AppRoute.customerBottomNavBar);
      }
    }
  }
}
