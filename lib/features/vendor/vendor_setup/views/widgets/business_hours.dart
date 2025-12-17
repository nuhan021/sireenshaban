import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:sireenshaban/core/common/styles/global_text_style.dart';
import 'package:sireenshaban/core/utils/constants/colors.dart';
import 'package:sireenshaban/features/vendor/vendor_setup/controller/vendor_setup_screen_controller.dart';

class BusinessHours extends StatelessWidget {
  const BusinessHours({super.key, required this.vendorSetupScreenController});
  final VendorSetupScreenController vendorSetupScreenController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 10.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: Colors.white,
        border: Border.all(color: Color(0xFFE5E7EB)),
      ),
      child: Column(
        children: vendorSetupScreenController.daysOrder.map((day) {
          return Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Switch and Day Name - Fixed width
                Expanded(
                  child: Row(
                    children: [
                      Obx(() {
                        return Transform.scale(
                          scale: 0.75,
                          child: Switch(
                            inactiveTrackColor: Color(0xFFEBEBEB),
                            activeTrackColor: AppColors.primaryDeepBlueNormal,
                            inactiveThumbColor: AppColors.primaryDeepBlueNormal,
                            activeThumbColor: Colors.white,
                            thumbIcon: MaterialStateProperty.resolveWith<Icon?>(
                              (states) {
                                if (states.contains(MaterialState.disabled)) {
                                  return const Icon(Icons.close);
                                }
                                if (states.contains(MaterialState.selected)) {
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
                              },
                            ),
                            value: vendorSetupScreenController
                                .weekDays[day]!
                                .value,
                            onChanged: (value) {
                              HapticFeedback.lightImpact();
                              vendorSetupScreenController.weekDays[day]!.value =
                                  value;
                            },
                          ),
                        );
                      }),
                      Expanded(
                        child: Text(
                          day,
                          overflow: TextOverflow.ellipsis,
                          style: getTextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primaryDeepBlueNormal,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Start Time - Fixed width
                Obx(() {
                  if (!vendorSetupScreenController.weekDays[day]!.value) {
                    return Expanded(
                      child: Text(
                        'Closed',
                        textAlign: TextAlign.center,
                        style: getTextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.error,
                        ),
                      ),
                    );
                  }
                  return SizedBox(
                    width: 90, // Adjust based on your needs
                    child: GestureDetector(
                      onTap: () async {
                        final picked = await showTimePicker(
                          context: context,
                          initialTime: vendorSetupScreenController
                              .startTimes[day]!
                              .value,
                        );

                        if (picked != null) {
                          vendorSetupScreenController.startTimes[day]!.value =
                              picked;
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            vendorSetupScreenController.getFormatedTime(
                              context,
                              vendorSetupScreenController
                                  .startTimes[day]!
                                  .value,
                            ),
                            style: getTextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.bodyDarkGray,
                            ),
                          ),
                          5.horizontalSpace,
                          Icon(IconlyLight.time_circle, size: 16),
                        ],
                      ),
                    ),
                  );
                }),

                10.horizontalSpace,

                // End Time - Fixed width
                Obx(() {
                  if (vendorSetupScreenController.weekDays[day]!.value) {
                    return SizedBox(
                      width: 90, // Adjust based on your needs
                      child: GestureDetector(
                        onTap: () async {
                          final picked = await showTimePicker(
                            context: context,
                            initialTime: vendorSetupScreenController
                                .endTimes[day]!
                                .value,
                          );

                          if (picked != null) {
                            vendorSetupScreenController.endTimes[day]!.value =
                                picked;
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              vendorSetupScreenController.getFormatedTime(
                                context,
                                vendorSetupScreenController
                                    .endTimes[day]!
                                    .value,
                              ),
                              style: getTextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.bodyDarkGray,
                              ),
                            ),
                            5.horizontalSpace,
                            Icon(IconlyLight.time_circle, size: 16),
                          ],
                        ),
                      ),
                    );
                  }

                  return SizedBox();

                }),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
