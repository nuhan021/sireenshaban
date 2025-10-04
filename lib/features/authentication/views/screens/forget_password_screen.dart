import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sireenshaban/features/authentication/controllers/forget_password_controller.dart';
import 'package:sireenshaban/features/authentication/views/screens/verification_code_send_success_screen.dart';

import '../../../../core/common/styles/global_text_style.dart';
import '../../../../core/common/widgets/IField.dart';
import '../../../../core/common/widgets/custom_primary_button.dart';
import '../../../../core/utils/constants/colors.dart';
import '../../../../routes/app_routes.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final controller = Get.put(ForgetPasswordController());

  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    phoneController.dispose();
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
          'Forget Password',
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
            55.verticalSpace,

            Text(
              'Please enter your email address or phone number for confirmation code.',
              textAlign: TextAlign.center,
              style: getTextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Color(0xFF5F5F5F),
              ),
            ),

            28.verticalSpace,

            // change forget password method to email or phone number
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // email
                Obx(() {
                  return GestureDetector(
                    onTap: () =>
                        controller.changeForgetPasswordMethod(method: 'email'),
                    child: Container(
                      height: 44.h,
                      width: 80.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        color: controller.forgetPasswordMethod.value == 'email'
                            ? AppColors.primaryDeepBlueNormal
                            : Colors.transparent,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Email',
                        style: getTextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color:
                              controller.forgetPasswordMethod.value == 'email'
                              ? AppColors.primaryDeepBlueLight
                              : AppColors.bodyDarkGray,
                        ),
                      ),
                    ),
                  );
                }),

                // phone number
                Obx(() {
                  return GestureDetector(
                    onTap: () =>
                        controller.changeForgetPasswordMethod(method: 'phone'),
                    child: Container(
                      height: 44.h,
                      width: 80.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        color: controller.forgetPasswordMethod.value == 'phone'
                            ? AppColors.primaryDeepBlueNormal
                            : Colors.transparent,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Phone',
                        style: getTextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color:
                              controller.forgetPasswordMethod.value == 'phone'
                              ? AppColors.primaryDeepBlueLight
                              : AppColors.bodyDarkGray,
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),

            // email or phone number input field
            30.verticalSpace,

            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() {
                    return Text(
                      controller.forgetPasswordMethod.value == 'phone'
                          ? 'Phone'
                          : 'Email',
                      style: getTextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.bodyDarkGray,
                      ),
                    );
                  }),

                  SizedBox(height: 5.h),

                  Obx(() {
                    return IField(
                      controller:
                          controller.forgetPasswordMethod.value == 'email'
                          ? emailController
                          : phoneController,
                      hintText: controller.forgetPasswordMethod.value == 'email'
                          ? "Enter your email"
                          : "Enter your phone number",
                      keyboardType: TextInputType.emailAddress,
                      filled: true,
                      hintTextStyle: getTextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.secondaryInfoMediumGray,
                      ),
                      fillColour: AppColors.primaryDeepBlueLight,
                    );
                  }),



                ],
              ),
            ),

            40.verticalSpace,

            CustomPrimaryButton(
              text: 'Send',
              color: AppColors.primaryDeepBlueNormal,
              onPressed: () => Get.to(VerificationCodeSendSuccessScreen(isFromSignUpScreen: false,)),
            ),
          ],
        ).paddingSymmetric(horizontal: 20.w),
      ),
    );
  }
}
