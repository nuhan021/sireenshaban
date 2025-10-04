import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sireenshaban/core/common/styles/global_text_style.dart';
import 'package:sireenshaban/core/common/widgets/custom_primary_button.dart';
import 'package:sireenshaban/core/utils/constants/colors.dart';
import 'package:sireenshaban/core/utils/constants/icon_path.dart';
import 'package:sireenshaban/core/utils/helpers/app_helper.dart';
import 'package:sireenshaban/core/utils/logging/logger.dart';
import 'package:sireenshaban/features/authentication/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sireenshaban/features/select_role/controller/select_role_controller.dart';
import 'package:sireenshaban/routes/app_routes.dart';

import '../../../../core/common/widgets/IField.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  final controller = Get.put(LoginController());
  final selectRoleController = Get.find<SelectRoleController>();

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(onPressed: () => Get.back(), icon: Icon(Icons.arrow_back)),
        centerTitle: false,
        title: Text(
          'Log In',
          style: getTextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.secondaryInfoMediumGray,
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 35.h),

            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Email',
                    style: getTextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.bodyDarkGray,
                    ),
                  ),

                  SizedBox(height: 5.h),

                  IField(
                    controller: emailController,
                    hintText: "Enter your email",
                    keyboardType: TextInputType.emailAddress,
                    filled: true,
                    hintTextStyle: getTextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.secondaryInfoMediumGray,
                    ),
                    fillColour: AppColors.primaryDeepBlueLight,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Email is required";
                      }
                      if (!value.contains("@")) {
                        return "Enter a valid email";
                      }
                      return null;
                    },
                    overrideValidator: true, // use custom validator
                  ),

                  SizedBox(height: 20.h),

                  Text(
                    'Password',
                    style: getTextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.bodyDarkGray,
                    ),
                  ),

                  SizedBox(height: 5.h),

                  Obx(() {
                    return IField(
                      controller: passwordController,
                      hintText: "Enter your password",
                      keyboardType: TextInputType.emailAddress,
                      filled: true,
                      hintTextStyle: getTextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.secondaryInfoMediumGray,
                      ),
                      fillColour: AppColors.primaryDeepBlueLight,
                      obscureText: widget.controller.isObscure.value,
                      suffixIcon: InkWell(
                        onTap: widget.controller.togglePasswordVisibility,
                        child: Icon(
                          widget.controller.isObscure.value
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          size: 18.w,
                        ),
                      ),
                    );
                  }),

                  SizedBox(height: 40.h),

                  CustomPrimaryButton(
                    text: 'Log In',
                    color: AppColors.primaryDeepBlueNormal,
                    onPressed: () {
                      if(widget.selectRoleController.role.value == "customer") {
                        Get.offAllNamed(AppRoute.customerHomeScreen);
                      }
                    },
                  ),

                  SizedBox(height: 16.h),

                  Align(
                    alignment: Alignment.center,
                    child: TextButton(
                      onPressed: () => Get.toNamed(AppRoute.forgetPasswordScreen),
                      child: Text(
                        'Forgot Password?',
                        style: getTextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryDeepBlueNormal,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: AppHelperFunctions.screenHeight() * 0.24),

                  GestureDetector(
                    onTap: () => Get.toNamed(AppRoute.signUpScreen),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Do not have an account?',
                          style: getTextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.bodyDarkGray,
                          ),
                        ),

                        Text(
                          '  Sign Up',
                          style: getTextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.primaryDeepBlueNormal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ).paddingSymmetric(horizontal: 20.w),
            ),
          ],
        ),
      ),
    );
  }
}
