import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sireenshaban/core/common/styles/global_text_style.dart';
import 'package:sireenshaban/core/common/widgets/custom_primary_button.dart';
import 'package:sireenshaban/core/utils/constants/colors.dart';
import 'package:sireenshaban/core/utils/constants/icon_path.dart';
import 'package:sireenshaban/core/utils/helpers/app_helper.dart';
import 'package:sireenshaban/features/onboarding/views/screens/onboarding_screen_3.dart';
import 'package:sireenshaban/routes/app_routes.dart';

import '../../../../core/utils/constants/image_path.dart';

class OnboardingScreen2 extends StatelessWidget {
  const OnboardingScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            SizedBox(
              height: AppHelperFunctions.screenHeight() * 0.22.h,
            ),

            // images
            Center(
              child: Image.asset(ImagePath.onboardingImage5, height: 150.h,),
            ),

            // text
            Column(
              children: [
                Text(
                  'Discover Local',
                  style: getTextStyle(
                    fontSize: 30.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryDeepBlueNormal,
                  ),
                ),

                // 5.verticalSpace,

                Text(
                  "Find trusted businesses",
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
              text: "Continue",
              color: AppColors.primaryDeepBlueNormal,
              onPressed: () => AppHelperFunctions.navigateToScreen(context, OnboardingScreen3()),
            ).paddingSymmetric(horizontal: 20.w),
          ],
        ),
      ),
    );
  }
}
