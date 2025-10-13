import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sireenshaban/core/common/styles/global_text_style.dart';

import '../../../../../core/utils/constants/colors.dart';

class BookingSummary extends StatelessWidget {
  const BookingSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: AppColors.cardBackgroundSoftGray,
        borderRadius: BorderRadius.circular(12.r),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          ListTile(
            title: Text(
              'Private Dinner Booking',
              style: getTextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.bodyDarkGray
              ),
            ),

            subtitle: Text(
              'Guests',
              style: getTextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.secondaryInfoMediumGrayNormal
              ),
            ),

            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '\$120',
                  style: getTextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.bodyDarkGray
                  ),
                ),

                Text(
                  '1',
                  style: getTextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.bodyDarkGray
                  ),
                )
              ],
            ),
          ),
          Divider(
            color: AppColors.primaryDeepBlueLight,
          ),

          ListTile(
            title: Text(
              'Subtotal',
              style: getTextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.bodyDarkGray
              ),
            ),

            subtitle: Text(
              'Tax',
              style: getTextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.secondaryInfoMediumGrayNormal
              ),
            ),

            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '\$120.00',
                  style: getTextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.bodyDarkGray
                  ),
                ),

                Text(
                  '\$9.60',
                  style: getTextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.bodyDarkGray
                  ),
                )
              ],
            ),
          ),
          Divider(
            color: AppColors.primaryDeepBlueLight,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: getTextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.bodyDarkGray
                ),
              ),

              Text(
                '\$129.60',
                style: getTextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.bodyDarkGray
                ),
              ),
            ],
          ).paddingSymmetric(horizontal: 15.w)
        ],
      ),

    );
  }
}
