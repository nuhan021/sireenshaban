import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sireenshaban/core/common/styles/global_text_style.dart';
import 'package:sireenshaban/core/common/widgets/custom_primary_button.dart';
import 'package:sireenshaban/core/utils/constants/colors.dart';
import 'package:sireenshaban/core/utils/helpers/app_helper.dart';
import 'package:sireenshaban/features/onboarding/views/screens/onboarding_screen_2.dart';

import '../../../../core/utils/constants/image_path.dart';

class OnboardingScreen1 extends StatelessWidget {
  const OnboardingScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: AppHelperFunctions.screenHeight() * 0.22.h),

            // images
            Center(
              child: Transform.rotate(
                angle: 45 * (pi / 180),
                child: SizedBox(
                  height: 170.h,
                  width: 170.w,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // 1st row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Transform.rotate(
                            angle: -45 * (pi / 180),
                            child: Image.asset(
                              ImagePath.onboardingImage1,
                              height: 70.h,
                            ),
                          ),
                          Transform.rotate(
                            angle: -45 * (pi / 180),
                            child: Image.asset(
                              ImagePath.onboardingImage2,
                              height: 70.h,
                            ),
                          ),
                        ],
                      ),

                      // 1st row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Transform.rotate(
                            angle: -45 * (pi / 180),
                            child: Image.asset(
                              ImagePath.onboardingImage3,
                              height: 70.h,
                            ),
                          ),

                          Transform.rotate(
                            angle: -45 * (pi / 180),
                            child: Image.asset(
                              ImagePath.onboardingImage4,
                              height: 70.h,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // text
            Column(
              children: [
                Text(
                  'The Community list',
                  style: getTextStyle(
                    fontSize: 30.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryDeepBlueNormal,
                  ),
                ),

                15.verticalSpace,

                Text(
                  "Connecting you with trusted local business for seamless booking",
                  textAlign: TextAlign.center,
                  style: getTextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.accentNormal,
                  ),
                ),
              ],
            ).paddingSymmetric(horizontal: 30.w),

            CustomPrimaryButton(
              text: "Get Started",
              color: AppColors.primaryDeepBlueNormal,
              onPressed: () => AppHelperFunctions.navigateToScreen(
                context,
                OnboardingScreen2(),
              ),
            ).paddingSymmetric(horizontal: 20.w),
          ],
        ),
      ),
    );
  }
}
