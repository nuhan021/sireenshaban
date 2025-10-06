import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../core/common/styles/global_text_style.dart';
import '../../../../../core/utils/constants/colors.dart';

class TrendingNearbyCard extends StatelessWidget {
  const TrendingNearbyCard({super.key, required this.image, required this.title, required this.status});
  final String image;
  final String title;
  final String status;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 180.h,
        width: 220.w,
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: AppColors.cardBackgroundSoftGray,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.primaryDeepBlueLight),
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // thumbnail image
            ClipRRect(
              borderRadius: BorderRadius.circular(4.r),
              child: Image.network(
                image,
                height: 113.h,
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),

            Row(
              children: [

                // title
                Expanded(
                  child: Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    style: getTextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.secondaryInfoMediumGrayDarker,
                    ),
                  ),
                ),

                5.horizontalSpace,

                // status
                Container(
                  height: 25.h,
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  decoration: BoxDecoration(
                    color: AppColors.accentNormal,
                    borderRadius: BorderRadius.circular(4.r)
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    status,
                    style: getTextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.white
                    )
                  ),
                )
              ],
            )
          ],
        ),
      ),
    ).paddingOnly(left: 20.w);
  }
}
