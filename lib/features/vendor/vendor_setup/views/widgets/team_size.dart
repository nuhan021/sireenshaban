import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../../../core/common/styles/global_text_style.dart';
import '../../../../../core/utils/constants/colors.dart';
import '../../controller/vendor_setup_screen_controller.dart';

// Helper widget for a single selectable team size option
class _TeamSizeOption extends StatelessWidget {
  const _TeamSizeOption({
    required this.label,
    required this.value,
    required this.controller,
  });

  final String label;
  final String value;
  final VendorSetupScreenController controller;

  @override
  Widget build(BuildContext context) {
    // FIX: Wrapping the specific widget content with Obx ensures that only
    // this option rebuilds when the selection (controller.teamSize.value) changes.
    return Obx(() {
      // Check if the current option is selected
      final isSelected = controller.teamSize.value == value;

      return GestureDetector(
        onTap: () {
          HapticFeedback.heavyImpact();
          controller.teamSize.value = value;
        },
        child: Container(
          height: 40.h,
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primaryDeepBlueNormal : Colors.white,
            borderRadius: BorderRadius.circular(6.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  label,
                  style: getTextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: isSelected ? Colors.white : AppColors.bodyDarkGray,
                  ),
                ),
              ),
              Container(
                height: 24.h,
                width: 24.w,
                decoration: BoxDecoration(
                  color: isSelected ? Colors.white : const Color(0xFFD8D8D8),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Icon(
                  Icons.check,
                  color: isSelected ? AppColors.primaryDeepBlueNormal : Colors.white,
                  size: 16,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class TeamSize extends StatelessWidget {
  const TeamSize({super.key, required this.controller});

  final VendorSetupScreenController controller;

  // Internal keys used by the controller
  final String justMe = '1';
  final String staff2To4 = '2-4';
  final String staff5To9 = '5-9';
  final String staff10Plus = '10+';

  @override
  Widget build(BuildContext context) {
    // The main Obx wrapper is removed here as the individual options are now wrapped.
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column( // Obx removed from here
        children: [
          // 1. Just me
          _TeamSizeOption(
            label: 'Just me',
            value: justMe,
            controller: controller,
          ),
          8.verticalSpace,

          // 2. 2-4 staff members
          _TeamSizeOption(
            label: '2-4 staff members',
            value: staff2To4,
            controller: controller,
          ),
          8.verticalSpace,

          // 3. 5-9 staff members
          _TeamSizeOption(
            label: '5-9 staff members',
            value: staff5To9,
            controller: controller,
          ),
          8.verticalSpace,

          // 4. More than 10 staff members
          _TeamSizeOption(
            label: 'More than 10 staff members',
            value: staff10Plus,
            controller: controller,
          ),
        ],
      ),
    );
  }
}