import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sireenshaban/core/common/styles/global_text_style.dart';
import 'package:sireenshaban/core/common/widgets/custom_primary_button.dart';
import 'package:sireenshaban/core/services/storage_service.dart';
import 'package:sireenshaban/core/utils/constants/colors.dart';
import 'package:sireenshaban/routes/app_routes.dart';

import '../../../../core/utils/constants/image_path.dart';

class OnboardingScreen3 extends StatelessWidget {
  const OnboardingScreen3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final imageHeight = min(250.0, constraints.maxHeight * 0.25);
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: constraints.maxHeight * 0.05),

                    // images
                    Center(
                      child: Image.asset(ImagePath.onboardingImage6, height: imageHeight),
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

                    Column(
                      children: [
                        for (int i = 0; i < 3; i++)
                          CustomPrimaryButton(
                            text: i == 0
                                ? "Man"
                                : i == 1
                                ? "Woman"
                                : "Skip",
                            color: AppColors.primaryDeepBlueNormal,
                            height: 56,
                            fontSize: 16,
                            onPressed: () async {
                              await StorageService.setOnboardingStatus(value: true);
                              Get.offNamed(AppRoute.selectRoleScreen);
                            },
                          ).paddingSymmetric(horizontal: 20, vertical: 6),
                      ],
                    ),

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
