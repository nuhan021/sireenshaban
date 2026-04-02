import 'dart:math';

import 'package:flutter/material.dart';
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
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final imageSize = min(170.0, constraints.maxHeight * 0.2);
            final imageItemSize = min(70.0, constraints.maxHeight * 0.08);
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
                      child: Transform.rotate(
                        angle: 45 * (pi / 180),
                        child: SizedBox(
                          height: imageSize,
                          width: imageSize,
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
                                      height: imageItemSize,
                                    ),
                                  ),
                                  Transform.rotate(
                                    angle: -45 * (pi / 180),
                                    child: Image.asset(
                                      ImagePath.onboardingImage2,
                                      height: imageItemSize,
                                    ),
                                  ),
                                ],
                              ),

                              // 2nd row
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Transform.rotate(
                                    angle: -45 * (pi / 180),
                                    child: Image.asset(
                                      ImagePath.onboardingImage3,
                                      height: imageItemSize,
                                    ),
                                  ),

                                  Transform.rotate(
                                    angle: -45 * (pi / 180),
                                    child: Image.asset(
                                      ImagePath.onboardingImage4,
                                      height: imageItemSize,
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
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryDeepBlueNormal,
                          ),
                        ),

                        const SizedBox(height: 15),

                        Text(
                          "Connecting you with trusted local business for seamless booking",
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
                      text: "Get Started",
                      color: AppColors.primaryDeepBlueNormal,
                      height: 56,
                      fontSize: 16,
                      onPressed: () => AppHelperFunctions.navigateToScreen(
                        context,
                        OnboardingScreen2(),
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
