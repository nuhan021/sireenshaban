import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sireenshaban/core/utils/constants/colors.dart';
import 'package:sireenshaban/core/utils/helpers/app_helper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:sireenshaban/features/customer/community_event_booking/views/screens/community_event_booking_screen.dart';

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
    return GestureDetector(
      onTap: () => AppHelperFunctions.navigateToScreen(context, CommunityEventBookingScreen(image: image, title: title,)),
      child: Card(
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
                child: CachedNetworkImage(
                  imageUrl: image,
                  fit: BoxFit.cover,
                  height: 187.h,
                  width: double.maxFinite,
                  placeholder: (context, url) => Center(
                    child: LoadingAnimationWidget.staggeredDotsWave(color: AppColors.primaryDeepBlueLight, size: 25.h),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                )
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
      ).paddingOnly(left: 20.w),
    );
  }
}
