import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:iconly/iconly.dart';
import 'package:sireenshaban/core/common/styles/global_text_style.dart';
import 'package:sireenshaban/core/utils/constants/colors.dart';
import 'package:sireenshaban/features/vendor/vendor_setup/controller/vendor_setup_screen_controller.dart';

class VirtualMeeting extends StatelessWidget {
  const VirtualMeeting({super.key, required this.controller});

  final VendorSetupScreenController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: Colors.white,
        border: Border.all(color: Color(0xFFE5E7EB)),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Virtual Meetings',
            style: getTextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.primaryDeepBlueNormal,
            ),
          ),

          12.verticalSpace,

          Text(
            'Offer services remotely via video call or phone',
            style: getTextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.bodyDarkGray,
            ),
          ),

          12.verticalSpace,

          Row(
            children: [
              Icon(IconlyLight.video, size: 30),
              10.horizontalSpace,
              Expanded(
                child: Text(
                  'Offer Virtual Meeting',
                  style: getTextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.accentNormal,
                  ),
                ),
              ),

              Obx(() {
                return Transform.scale(
                  scale: 0.75,
                  child: Switch(
                    inactiveTrackColor: Color(0xFFEBEBEB),
                    activeTrackColor: AppColors.primaryDeepBlueNormal,
                    inactiveThumbColor: AppColors.primaryDeepBlueNormal,
                    activeThumbColor: Colors.white,
                    thumbIcon: WidgetStateProperty.resolveWith<Icon?>((states) {
                      if (states.contains(WidgetState.disabled)) {
                        return const Icon(Icons.close);
                      }
                      if (states.contains(WidgetState.selected)) {
                        return Icon(
                          Icons.check,
                          size: 16,
                          color: AppColors.primaryDeepBlueNormal,
                        );
                      }
                      return const Icon(
                        Icons.close,
                        size: 16,
                        color: Colors.white,
                      );
                    }),
                    value: controller.offerVirtualMeeting.value,
                    onChanged: (value) {
                      HapticFeedback.lightImpact();
                      controller.offerVirtualMeeting.value = value;
                    },
                  ),
                );
              }),
            ],
          ),
        ],
      ),
    );
  }
}
