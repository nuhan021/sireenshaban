import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sireenshaban/core/common/styles/global_text_style.dart';
import 'package:sireenshaban/core/common/widgets/custom_primary_button.dart';
import 'package:sireenshaban/core/utils/constants/colors.dart';

class EventCard extends StatelessWidget {
  const EventCard({super.key, required this.bannerImage, required this.title});

  final String bannerImage;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 390.h,
      width: double.maxFinite,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.cardBackgroundSoftGray,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // image
          ClipRRect(
            borderRadius: BorderRadius.circular(7.r),
            child: CachedNetworkImage(
              imageUrl:
                  bannerImage,
              fit: BoxFit.cover,
              height: 185.h,
              width: double.maxFinite,
              placeholder: (context, url) => Center(
                child: LoadingAnimationWidget.staggeredDotsWave(
                  color: AppColors.primaryDeepBlueLight,
                  size: 25.h,
                ),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),

          // title
          Text(
            title,
            style: getTextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.bodyDarkGray,
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
                "15 March, 2025",
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
                "Community Center",
                style: getTextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.secondaryAquaNormal,
                ),
              ),
            ],
          ),

          // ticket price
          Row(
            children: [
              Icon(
                Icons.airplane_ticket_rounded,
                color: AppColors.accentNormal,
              ),

              5.horizontalSpace,
              Text(
                "\$ 120/ per ticket",
                style: getTextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.accentNormal,
                ),
              ),
            ],
          ),
          
          CustomPrimaryButton(text: "View details", color: AppColors.primaryDeepBlueNormal, onPressed: (){})
        ],
      ),
    );
  }
}
