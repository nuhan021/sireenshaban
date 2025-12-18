import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sireenshaban/features/select_role/controller/select_role_controller.dart';

import '../../../../core/common/styles/global_text_style.dart';
import '../../../../core/common/widgets/IField.dart';
import '../../../../core/common/widgets/custom_loading.dart';
import '../../../../core/common/widgets/custom_primary_button.dart';
import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/helpers/app_helper.dart';
import '../../../../routes/app_routes.dart';
import '../../controllers/sign_up_screen_controller.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({super.key});

  final controller = Get.put(SignUpScreenController());
  final SelectRoleController selectRoleController =
      Get.find<SelectRoleController>();

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    widget.controller.emailController.dispose();
    widget.controller.passwordController.dispose();
    widget.controller.retypePasswordController.dispose();
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back),
        ),
        title: Text(
          'Sign Up',
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
                    controller: widget.controller.emailController,
                    hintText: "Enter your email",
                    keyboardType: TextInputType.emailAddress,
                    filled: true,
                    hintTextStyle: getTextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.secondaryInfoMediumGray,
                    ),
                    fillColour: AppColors.primaryDeepBlueLight,
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
                      controller: widget.controller.passwordController,
                      hintText: "Enter your password",
                      keyboardType: TextInputType.emailAddress,
                      filled: true,
                      hintTextStyle: getTextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.secondaryInfoMediumGray,
                      ),
                      fillColour: AppColors.primaryDeepBlueLight,
                      obscureText: widget.controller.isObscurePassword.value,
                      suffixIcon: InkWell(
                        onTap: widget.controller.togglePasswordVisibility,
                        child: Icon(
                          widget.controller.isObscurePassword.value
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          size: 18.w,
                        ),
                      ),
                    );
                  }),

                  SizedBox(height: 20.h),

                  Text(
                    'Re-type Password',
                    style: getTextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.bodyDarkGray,
                    ),
                  ),

                  SizedBox(height: 5.h),

                  Obx(() {
                    return IField(
                      controller: widget.controller.retypePasswordController,
                      hintText: "Re-type password",
                      keyboardType: TextInputType.emailAddress,
                      filled: true,
                      hintTextStyle: getTextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.secondaryInfoMediumGray,
                      ),
                      fillColour: AppColors.primaryDeepBlueLight,
                      obscureText:
                          widget.controller.isObscureRetypePassword.value,
                      suffixIcon: InkWell(
                        onTap: widget.controller.toggleRetypePasswordVisibility,
                        child: Icon(
                          widget.controller.isObscureRetypePassword.value
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          size: 18.w,
                        ),
                      ),
                    );
                  }),

                  SizedBox(height: 40.h),

                  Obx(() {
                    if (widget.controller.isSignUpLoading.value) {
                      return CustomLoading();
                    }
                    return CustomPrimaryButton(
                      text: 'Sign Up',
                      color: AppColors.primaryDeepBlueNormal,
                      onPressed: () => widget.controller.signUp(
                        widget.selectRoleController.role.value.toString(),
                      ),
                    );
                  }),

                  SizedBox(height: 16.h),

                  SizedBox(height: AppHelperFunctions.screenHeight() * 0.05),

                  GestureDetector(
                    onTap: () => Get.toNamed(AppRoute.loginScreen),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Have an account?',
                          style: getTextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.bodyDarkGray,
                          ),
                        ),

                        Text(
                          '  Sign In',
                          style: getTextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.primaryDeepBlueNormal,
                          ),
                        ),
                      ],
                    ),
                  ),

                  20.verticalSpace,
                ],
              ),
            ),
          ],
        ).paddingSymmetric(horizontal: 20.w),
      ),
    );
  }
}
