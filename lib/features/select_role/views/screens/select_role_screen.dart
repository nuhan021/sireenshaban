import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sireenshaban/core/common/styles/global_text_style.dart';
import 'package:sireenshaban/core/common/widgets/custom_primary_button.dart';
import 'package:sireenshaban/core/utils/constants/colors.dart';
import 'package:sireenshaban/core/utils/constants/icon_path.dart';
import 'package:sireenshaban/routes/app_routes.dart';

import '../../controller/select_role_controller.dart';

class SelectRoleScreen extends StatelessWidget {
  SelectRoleScreen({super.key});

  final controller = Get.put(SelectRoleController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30.h),
            Text(
              'Select Your Role',
              style: getTextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.bodyDarkGray,
              ),
            ),

            Text(
              'Choose a role to get started',
              style: getTextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.secondaryMediumGray,
              ),
            ),

            SizedBox(height: 20.h),

            Obx(() {
              return GestureDetector(
                onTap: () => controller.selectRole(userRole: 'business'),
                child: Container(
                  height: 80.h,
                  width: double.maxFinite,
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(
                      color: controller.role.value == 'business'
                          ? AppColors.primaryDeepBlueNormal
                          : Colors.transparent,
                    ),
                  ),
                  child: Center(
                    child: Row(
                      children: [
                        Container(
                          height: 40.h,
                          width: 40.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primaryDeepBlueNormal,
                          ),
                          child: Center(
                            child: Image.asset(
                              IconPath.calenderMonth,
                              height: 20.h,
                            ),
                          ),
                        ),

                        SizedBox(width: 12.w),

                        Text(
                          'Business profile 🎉',
                          style: getTextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.bodyDarkGray,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),

            SizedBox(height: 8.h),

            Obx(() {
              return GestureDetector(
                onTap: () => controller.selectRole(userRole: 'customer'),
                child: Container(
                  height: 80.h,
                  width: double.maxFinite,
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(
                      color: controller.role.value == 'customer'
                          ? AppColors.primaryDeepBlueNormal
                          : Colors.transparent,
                    ),
                  ),
                  child: Center(
                    child: Row(
                      children: [
                        Container(
                          height: 40.h,
                          width: 40.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primaryDeepBlueNormal,
                          ),
                          child: Center(
                            child: Image.asset(IconPath.user, height: 20.h),
                          ),
                        ),

                        SizedBox(width: 12.w),

                        Text(
                          'Customer🏢',
                          style: getTextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.bodyDarkGray,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),

            SizedBox(height: 40.h),

            CustomPrimaryButton(
              text: 'Continue',
              color: AppColors.primaryDeepBlueNormal,
              onPressed: () => Get.offAllNamed(AppRoute.loginScreen),
            ),
          ],
        ).paddingSymmetric(horizontal: 20.w),
      ),
    );
  }
}
