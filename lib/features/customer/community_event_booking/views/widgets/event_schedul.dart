import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sireenshaban/core/common/styles/global_text_style.dart';
import 'package:sireenshaban/core/utils/constants/colors.dart';
import 'package:sireenshaban/core/utils/constants/icon_path.dart';

class EventSchedul extends StatelessWidget {
  const EventSchedul({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500.h,
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(vertical: 20.h),
      decoration: BoxDecoration(
        color: AppColors.cardBackgroundSoftGray,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Image.asset(IconPath.clock, height: 24.h),
                    5.horizontalSpace,
                    Expanded(
                      child: Text(
                        'Event Schedule',
                        style: getTextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.bodyDarkGray,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                'Available Time',
                style: getTextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.secondaryTealNormal,
                ),
              ),
            ],
          ).paddingSymmetric(horizontal: 20.w),

          Divider(color: Color(0xFFD1D3D8)).paddingSymmetric(horizontal: 20.w),

          // date and time
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // date
              Expanded(
                child: ListTile(
                  leading: Container(
                    height: 42.h,
                    width: 42.h,
                    padding: EdgeInsets.all(7.w),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFFEF1E8),
                    ),
                    alignment: AlignmentGeometry.center,
                    child: Image.asset(
                      IconPath.navCalendar,
                      color: AppColors.accentNormal,
                    ),
                  ),
                  title: Text(
                    'Date',
                    style: getTextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.primaryDeepBlueNormal,
                    ),
                  ),
                  subtitle: Text(
                    "Sunday,Sept 28",
                    style: getTextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.secondaryInfoMediumGrayNormal,
                    ),
                  ),
                ),
              ),

              // time
              Expanded(
                child: ListTile(
                  leading: Container(
                    height: 42.h,
                    width: 42.h,
                    padding: EdgeInsets.all(7.w),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFE8F8F6),
                    ),
                    alignment: AlignmentGeometry.center,
                    child: Image.asset(
                      IconPath.clock,
                      color: AppColors.secondaryTealNormal,
                    ),
                  ),
                  title: Text(
                    'Time',
                    style: getTextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.primaryDeepBlueNormal,
                    ),
                  ),
                  subtitle: Text(
                    "10:00 AM",
                    style: getTextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.secondaryInfoMediumGrayNormal,
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Attendees and payment method
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // attendees
              Expanded(
                child: ListTile(
                  leading: Container(
                    height: 42.h,
                    width: 42.h,
                    padding: EdgeInsets.all(7.w),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFF0F1F2),
                    ),
                    alignment: AlignmentGeometry.center,
                    child: Image.asset(
                      IconPath.people,
                      color: AppColors.bodyDarkGray,
                    ),
                  ),
                  title: Text(
                    'Attendees',
                    style: getTextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.primaryDeepBlueNormal,
                    ),
                  ),
                  subtitle: Text(
                    "1 Guest",
                    style: getTextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.secondaryInfoMediumGrayNormal,
                    ),
                  ),
                ),
              ),

              // time
              Expanded(
                child: ListTile(
                  leading: Container(
                    height: 42.h,
                    width: 42.h,
                    padding: EdgeInsets.all(7.w),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFF0F1F2),
                    ),
                    alignment: AlignmentGeometry.center,
                    child: Image.asset(
                      IconPath.mobile,
                      color: AppColors.bodyDarkGray,
                    ),
                  ),
                  title: Text(
                    'Stripe',
                    style: getTextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.primaryDeepBlueNormal,
                    ),
                  ),
                  subtitle: Text(
                    "****4252",
                    style: getTextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.secondaryInfoMediumGrayNormal,
                    ),
                  ),
                ),
              ),
            ],
          ),

          Divider(color: Color(0xFFD1D3D8)).paddingSymmetric(horizontal: 20.w),

          Row(
            children: [
              Image.asset(IconPath.people, height: 24.h),
              7.horizontalSpace,
              Text(
                "Number of Tickets",
                style: getTextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.bodyDarkGray,
                ),
              ),
            ],
          ).paddingSymmetric(horizontal: 20.w),

          // add ticket number
          Container(
            height: 85,
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            decoration: BoxDecoration(
              color: AppColors.primaryDeepBlueLight,
              borderRadius: BorderRadius.circular(12.r),
            ),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // - button
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.remove_circle,
                    color: AppColors.primaryDeepBlueNormal,
                    size: 40,
                  ),
                ),

                Text(
                  "1",
                  style: getTextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryDeepBlueNormal,
                  )
                ),

                // + button
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.add_circle,
                    color: AppColors.primaryDeepBlueNormal,
                    size: 40,
                  ),
                ),
              ],
            ),
          ).paddingSymmetric(horizontal: 20.w),

          // total price
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Paid',
                style: getTextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryDeepBlueNormal,
                ),
              ),

              Text(
                '\$120.60',
                style: getTextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.bodyDarkGray,
                ),
              ),
            ],
          ).paddingSymmetric(horizontal: 20.w),


        ],
      ),
    );
  }
}
