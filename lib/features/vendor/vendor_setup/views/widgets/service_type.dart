import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:sireenshaban/core/common/styles/global_text_style.dart';
import 'package:sireenshaban/core/utils/constants/colors.dart';
import 'package:sireenshaban/features/vendor/vendor_setup/controller/vendor_setup_screen_controller.dart';

class ServiceType extends StatelessWidget {
  const ServiceType({super.key, required this.controller});

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
        children: [
          Obx(() {
            return GestureDetector(
              onTap: () {
                HapticFeedback.heavyImpact();

                controller.atMyBusinessAddress.value =
                    !controller.atMyBusinessAddress.value;
              },
              child: Container(
                height: 40.h,
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                decoration: BoxDecoration(
                  color: controller.atMyBusinessAddress.value
                      ? AppColors.primaryDeepBlueNormal
                      : Colors.white,
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'At my business address',
                        style: getTextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: controller.atMyBusinessAddress.value
                              ? Colors.white
                              : AppColors.bodyDarkGray,
                        ),
                      ),
                    ),

                    Container(
                      height: 24.h,
                      width: 24.w,
                      decoration: BoxDecoration(
                        color: controller.atMyBusinessAddress.value
                            ? Colors.white
                            : Color(0xFFD8D8D8),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Icon(
                        Icons.check,
                        color: controller.atMyBusinessAddress.value
                            ? AppColors.primaryDeepBlueNormal
                            : Colors.white,
                        size: 16,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),

          8.verticalSpace,

          Obx(() {
            return GestureDetector(
              onTap: () {
                HapticFeedback.heavyImpact();
                controller.iTravelToTheClient.value =
                    !controller.iTravelToTheClient.value;
              },
              child: Container(
                height: 40.h,
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                decoration: BoxDecoration(
                  color: controller.iTravelToTheClient.value
                      ? AppColors.primaryDeepBlueNormal
                      : Colors.white,
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'I travel to the client',
                        style: getTextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: controller.iTravelToTheClient.value
                              ? Colors.white
                              : AppColors.bodyDarkGray,
                        ),
                      ),
                    ),

                    Container(
                      height: 24.h,
                      width: 24.w,
                      decoration: BoxDecoration(
                        color: controller.iTravelToTheClient.value
                            ? Colors.white
                            : Color(0xFFD8D8D8),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Icon(
                        Icons.check,
                        color: controller.iTravelToTheClient.value
                            ? AppColors.primaryDeepBlueNormal
                            : Colors.white,
                        size: 16,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
