import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sireenshaban/core/utils/constants/colors.dart';

import '../../../../../core/common/styles/global_text_style.dart';

class CommunityEventsCard extends StatelessWidget {
  const CommunityEventsCard({
    super.key,
    required this.image,
    required this.title,
    required this.date,
    required this.location,
  });

  final String image;
  final String title;
  final String date;
  final String location;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 305.h,
        width: 261.w,
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
                height: 187.h,
                fit: BoxFit.cover,
              ),
            ),

            // title
            Text(
              title,
              overflow: TextOverflow.ellipsis,
              style: getTextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.secondaryInfoMediumGrayDarker,
              ),
            ),

            // date
            Row(
              children: [
                Icon(
                  Icons.calendar_month_outlined,
                  color: AppColors.secondaryInfoMediumGrayNormal,
                ),
                5.horizontalSpace,
                Text(
                  date,
                  style: getTextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.secondaryInfoMediumGrayNormal,
                  ),
                ),
              ],
            ),

            // location
            Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  color: AppColors.secondaryInfoMediumGrayNormal,
                ),

                5.horizontalSpace,
                Text(
                  location,
                  style: getTextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.secondaryAquaNormal,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ).paddingOnly(left: 20.w);
  }
}
