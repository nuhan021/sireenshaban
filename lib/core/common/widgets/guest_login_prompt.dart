import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sireenshaban/core/common/styles/global_text_style.dart';
import 'package:sireenshaban/core/common/widgets/custom_primary_button.dart';
import 'package:sireenshaban/core/services/storage_service.dart';
import 'package:sireenshaban/core/utils/constants/colors.dart';
import 'package:sireenshaban/routes/app_routes.dart';

class GuestLoginPrompt extends StatelessWidget {
  const GuestLoginPrompt({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.lock_outline_rounded,
              size: 64,
              color: AppColors.secondaryInfoMediumGrayNormal,
            ),
            const SizedBox(height: 20),
            Text(
              message,
              textAlign: TextAlign.center,
              style: getTextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.bodyDarkGray,
              ),
            ),
            const SizedBox(height: 24),
            CustomPrimaryButton(
              text: 'Log In',
              color: AppColors.primaryDeepBlueNormal,
              height: 48,
              fontSize: 16,
              onPressed: () async {
                await StorageService.setGuestMode(false);
                Get.offAllNamed(AppRoute.selectRoleScreen);
              },
            ),
          ],
        ),
      ),
    );
  }
}
