import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sireenshaban/core/services/network_caller.dart';
import 'package:sireenshaban/core/services/storage_service.dart';
import 'package:sireenshaban/core/utils/constants/api_constants.dart';
import 'package:sireenshaban/core/utils/constants/colors.dart';
import 'package:sireenshaban/core/utils/constants/snackbar_constant.dart';
import 'package:sireenshaban/core/utils/logging/logger.dart';
import 'package:sireenshaban/features/authentication/models/loginModel.dart';

import '../../../routes/app_routes.dart';

class LoginController extends GetxController {
  final NetworkCaller _networkCaller = NetworkCaller();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  RxBool isObscure = true.obs;

  RxBool isLogInLoading = false.obs;

  Rx<LoginModel?> loginModel = Rx<LoginModel?>(null);

  void togglePasswordVisibility() {
    isObscure.value = !isObscure.value;
  }

  Future<void> login() async {
    if (emailController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty) {
      SnackBarConstant.warning('Please fill all the fields');
      return;
    }

    isLogInLoading.value = true;

    final response = await _networkCaller.postRequest(
      ApiConstants.login,
      body: {
        "email": emailController.text,
        "password": passwordController.text,
      },
    );

    if (!response.isSuccess) {
      SnackBarConstant.error(response.errorMessage);
      isLogInLoading.value = false;
      return;
    }

    loginModel.value = LoginModel.fromJson(response.responseData);

    isLogInLoading.value = false;

    StorageService.saveToken(loginModel.value!.data.token, loginModel.value!.data.user.role);

    SnackBarConstant.success("Login successful");

    if (loginModel.value!.data.user.role == 'Vendor') {
      if (loginModel.value!.data.user.isFirstTime) {
        Get.offAllNamed(AppRoute.vendorSetupScreen);
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
