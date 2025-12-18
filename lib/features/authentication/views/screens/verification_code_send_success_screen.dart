import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sireenshaban/core/common/styles/global_text_style.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:sireenshaban/core/common/widgets/custom_primary_button.dart';
import 'package:sireenshaban/core/utils/constants/enums.dart';
import 'package:sireenshaban/core/utils/logging/logger.dart';
import 'package:sireenshaban/features/authentication/controllers/sign_up_screen_controller.dart';
import 'package:sireenshaban/features/select_role/controller/select_role_controller.dart';
import 'package:sireenshaban/routes/app_routes.dart';
import '../../../../core/common/widgets/custom_loading.dart';
import '../../../../core/utils/constants/colors.dart';

class VerificationCodeSendSuccessScreen extends StatelessWidget {
  VerificationCodeSendSuccessScreen({
    super.key,
    this.isFromSignUpScreen = true,
  });

  final SelectRoleController selectRoleController =
      Get.find<SelectRoleController>();

  final SignUpScreenController signUpScreenController =
      Get.find<SignUpScreenController>();

  final bool isFromSignUpScreen;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              50.verticalSpace,
              Text(
                'Enter the',
                textAlign: TextAlign.center,
                style: getTextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.bodyDarkGray,
                ),
              ),
              Text(
                'confirmation code',
                textAlign: TextAlign.center,
                style: getTextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.bodyDarkGray,
                ),
              ),

              22.verticalSpace,

              //otp feild
              OtpTextField(
                contentPadding: EdgeInsets.zero,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                numberOfFields: 6,
                borderRadius: BorderRadius.circular(10.0.r),
                fieldHeight: 42.0.w,
                fieldWidth: 42.0.w,
                borderColor: AppColors.primaryDeepBlueLight,
                showFieldAsBox: true,
                onCodeChanged: (code) {
                  /* when value changes */
                },
                onSubmit: (verificationCode) {
                  signUpScreenController.otp = verificationCode;
                },
              ),
              20.verticalSpace,

              Text(
                'Verification code has been sent to the email "${signUpScreenController.emailController.text}"',
                textAlign: TextAlign.center,
                style: getTextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.bodyDarkGray,
                ),
              ),

              26.verticalSpace,

              Obx(() {
                if(signUpScreenController.isResendOtpLoading.value) {
                  return LoadingAnimationWidget.dotsTriangle(color: AppColors.primaryDeepBlueNormal, size: 25.h);
                }
                return TextButton(
                  onPressed: () => signUpScreenController.resendOtp(),
                  child: Text(
                    'Resend Code',
                    style: getTextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryDeepBlueNormal,
                    ),
                  ),
                );
              }),

              40.verticalSpace,

              Obx(() {
                if (signUpScreenController.isOtpLoading.value) {
                  return CustomLoading();
                }
                return CustomPrimaryButton(
                  text: 'Continue',
                  color: AppColors.primaryDeepBlueNormal,
                  onPressed: () =>
                      signUpScreenController.verifyOtp(isFromSignUpScreen),
                );
              }),
            ],
          ).paddingSymmetric(horizontal: 20.w),
        ),
      ),
    );
  }
}
