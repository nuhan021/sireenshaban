import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sireenshaban/core/common/styles/global_text_style.dart';
import 'package:sireenshaban/core/utils/constants/colors.dart';

import '../../../../../core/utils/constants/icon_path.dart';

class ClientProfileSection extends StatelessWidget {
  const ClientProfileSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 20.w),
      decoration: BoxDecoration(
        color: AppColors.cardBackgroundSoftGray,
        borderRadius: BorderRadius.circular(14.r),
      ),

      child: Column(
        children: [

          // profile picture, name and others,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // profile picture
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 50.r,
                backgroundImage: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSCAh5xHkS7NYy0rbv7pv-yCtxbuSxTTVpUD1yF-Ol6WEGO4ERHVM9OagmsxQklY2JlJDQ&usqp=CAU"),
              ),

              20.horizontalSpace,

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Sarah's Photography",
                      style: getTextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.bodyDarkGray
                      ),
                    ),

                    2.verticalSpace,

                    Text(
                      "Professional Photography",
                      style: getTextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.secondaryInfoMediumGrayNormal
                      ),
                    ),

                    5.verticalSpace,

                    Container(
                      width: 100.w,
                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        color: Color(0xFFB6E9E3),
                        border: Border.all(color: Color(0xFF14B8A6))
                      ),

                      alignment: AlignmentGeometry.center,
                      child: Text(
                        "New Request",
                        style: getTextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF0C6E64)
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),

          20.verticalSpace,

          Divider(color: AppColors.primaryDeepBlueLight,),

          20.verticalSpace,

          // date and time
          Row(
            children: [
              Image.asset(IconPath.navCalendar, height: 25.h, color: AppColors.bodyDarkGray,),
              5.horizontalSpace,
              Text(
                'Date & Time',
                style: getTextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.bodyDarkGray
                ),
              )
            ],
          ),
          15.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // date
              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Date',
                    style: getTextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.bodyDarkGray
                    ),
                  ),
                  10.verticalSpace,
                  Container(

                    height: 37.h,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: AppColors.primaryDeepBlueLight,
                      borderRadius: BorderRadius.circular(4.r),
                    ),

                    alignment: AlignmentGeometry.center,
                    child: Text(
                      'Oct 15, 2025',
                      style: getTextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.bodyDarkGray
                      ),
                    ),
                  ),
                ],
              )),

              18.horizontalSpace,

              // date
              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Time',
                    style: getTextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.bodyDarkGray
                    ),
                  ),
                  10.verticalSpace,
                  Container(

                    height: 37.h,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: AppColors.primaryDeepBlueLight,
                      borderRadius: BorderRadius.circular(4.r),
                    ),

                    alignment: AlignmentGeometry.center,
                    child: Text(
                      '10:00 AM',
                      style: getTextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.bodyDarkGray
                      ),
                    ),
                  ),
                ],
              )),
            ],
          )
        ],
      ),
    );
  }
}
