import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sireenshaban/core/common/styles/global_text_style.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:sireenshaban/core/common/widgets/custom_primary_button.dart';
import 'package:sireenshaban/routes/app_routes.dart';
import '../../../../core/utils/constants/colors.dart';

class VerificationCodeSendSuccessScreen extends StatelessWidget {
  const VerificationCodeSendSuccessScreen({super.key, this.isFromSignUpScreen = true});

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
                numberOfFields: 5,
                borderRadius: BorderRadius.circular(10.0.r),
                fieldHeight: 42.0.w,
                fieldWidth: 42.0.w,
                borderColor: AppColors.primaryDeepBlueLight,
                showFieldAsBox: true,
                onCodeChanged: (code) {
                  /* when value changes */
                },
                onSubmit: (verificationCode) {
                  // when all fields are filled
                },
              ),
              20.verticalSpace,

              Text(
                'Verification code has been sent to the phone number Your 0724****',
                textAlign: TextAlign.center,
                style: getTextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.bodyDarkGray
                ),
              ),

              26.verticalSpace,

              TextButton(onPressed: (){}, child: Text('Resend Code', style: getTextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.primaryDeepBlueNormal
              ))),

              40.verticalSpace,

              CustomPrimaryButton(
                text: 'Continue',
                color: AppColors.primaryDeepBlueNormal,
                onPressed: () => isFromSignUpScreen ? Get.offAllNamed(AppRoute.loginScreen) : Get.toNamed(AppRoute.changePasswordScreen),
              ),
            ],
          ).paddingSymmetric(horizontal: 20.w),
        ),
      ),
    );
  }
}
