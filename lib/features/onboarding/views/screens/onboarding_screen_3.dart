import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sireenshaban/core/common/styles/global_text_style.dart';
import 'package:sireenshaban/core/common/widgets/custom_primary_button.dart';
import 'package:sireenshaban/core/services/storage_service.dart';
import 'package:sireenshaban/core/utils/constants/colors.dart';
import 'package:sireenshaban/core/utils/constants/icon_path.dart';
import 'package:sireenshaban/core/utils/helpers/app_helper.dart';
import 'package:sireenshaban/routes/app_routes.dart';

import '../../../../core/utils/constants/image_path.dart';

class OnboardingScreen3 extends StatelessWidget {
  const OnboardingScreen3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            SizedBox(
              height: AppHelperFunctions.screenHeight() * 0.10.h,
            ),

            // images
            Center(
              child: Image.asset(ImagePath.onboardingImage6, height: 250.h,),
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

            Column(
              children: [
                for(int i = 0; i < 3; i++)
                  CustomPrimaryButton(
                    text: i == 0 ? "Man": i == 1 ? "Woman" : "Skip",
                    color: AppColors.primaryDeepBlueNormal,
                    onPressed: () async {
                      await StorageService.setOnboardingStatus(value: true);
                      Get.offNamed(AppRoute.selectRoleScreen);
                    },
                  ).paddingSymmetric(horizontal: 20.w, vertical: 6.h)
              ],
            )
          ],
        ),
      ),
    );
  }
}
