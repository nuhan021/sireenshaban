import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sireenshaban/core/common/styles/global_text_style.dart';
import 'package:sireenshaban/core/utils/constants/colors.dart';
import 'package:sireenshaban/core/utils/helpers/app_helper.dart';
import 'package:sireenshaban/features/vendor/vendor_schedule/views/screens/vendor_request_status_screen.dart';

class VendorScheduleCard extends StatelessWidget {
  const VendorScheduleCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.cardBackgroundSoftGray,
        borderRadius: BorderRadius.circular(10.r),
      ),

      child: Column(
        children: [
          // top row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // user info
              Expanded(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 25.r,
                    backgroundImage: NetworkImage(
                      "https://cdn.pixabay.com/photo/2022/04/24/14/16/sexy-girl-7153683_640.jpg",
                    ),
                  ),

                  title: Text(
                    'Jhon’s Birthday',
                    style: getTextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.secondaryInfoMediumGrayDarker,
                    ),
                  ),

                  subtitle: Text(
                    'Total Cost: 5000\$',
                    style: getTextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.secondaryAquaNormal,
                    ),
                  ),
                ),
              ),

              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Thursday',
                    style: getTextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.secondaryInfoMediumGrayDarker,
                    ),
                  ),

                  5.verticalSpace,

                  Text(
                    '15-12-2024',
                    style: getTextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.secondaryInfoMediumGrayDarker,
                    ),
                  ),

                  5.verticalSpace,

                  Text(
                    'At - 07.50pm',
                    style: getTextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.secondaryInfoMediumGrayDarker,
                    ),
                  ),
                ],
              ).paddingOnly(right: 10.w),
            ],
          ),

          // booking id
          Row(
            children: [
              Text(
                'Booking ID',
                style: getTextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.accentNormal,
                ),
              ),

              5.horizontalSpace,

              Text(
                '#BV-2025-0142',
                style: getTextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.bodyDarkGray,
                ),
              ),
            ],
          ).paddingOnly(left: 10.w),

          20.verticalSpace,

          // contact and view details button
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 40.h,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: AppColors.primaryDeepBlueNormal,
                      width: 2,
                    ),
                  ),

                  child: Center(
                    child: Text(
                      'Contact',
                      style: getTextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primaryDeepBlueNormal,
                      ),
                    ),
                  ),
                ),
              ),

              12.horizontalSpace,

              Expanded(
                child: GestureDetector(
                  onTap: () => AppHelperFunctions.navigateToScreen(context, VendorRequestStatusScreen()),
                  child: Container(
                    height: 40.h,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      color: AppColors.primaryDeepBlueNormal,
                    ),
                  
                    child: Center(
                      child: Text(
                        'View details',
                        style: getTextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ).paddingSymmetric(horizontal: 10.w),
        ],
      ),
    );
  }
}
