import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sireenshaban/core/common/styles/global_text_style.dart';
import 'package:sireenshaban/core/common/widgets/custom_primary_button.dart';
import 'package:sireenshaban/core/utils/constants/colors.dart';
import 'package:sireenshaban/core/utils/helpers/app_helper.dart';
import 'package:sireenshaban/features/onboarding/views/screens/onboarding_screen_3.dart';

import '../../../../core/utils/constants/image_path.dart';

class OnboardingScreen2 extends StatelessWidget {
  const OnboardingScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final imageHeight = min(150.0, constraints.maxHeight * 0.18);
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: constraints.maxHeight * 0.1),

                    // images
                    Center(
                      child: Image.asset(ImagePath.onboardingImage5, height: imageHeight),
                    ),

                    // text
                    Column(
                      children: [
                        Text(
                          'Discover Local',
                          style: getTextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryDeepBlueNormal,
                          ),
                        ),

                        Text(
                          "Find trusted businesses",
                          textAlign: TextAlign.center,
                          style: getTextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.accentNormal,
                          ),
                        ),
                      ],
                    ).paddingSymmetric(horizontal: 30),

                    CustomPrimaryButton(
                      text: "Continue",
                      color: AppColors.primaryDeepBlueNormal,
                      height: 56,
                      fontSize: 16,
                      onPressed: () => AppHelperFunctions.navigateToScreen(
                        context,
                        OnboardingScreen3(),
                      ),
                    ).paddingSymmetric(horizontal: 20),

                    SizedBox(height: constraints.maxHeight * 0.05),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
