import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sireenshaban/core/common/styles/global_text_style.dart';
import 'package:sireenshaban/core/utils/constants/colors.dart';

class ThumbnailImage extends StatelessWidget {
  const ThumbnailImage({
    super.key,
    required this.image,
    required this.rating,
    required this.reviews,
  });

  final String image;
  final int rating;
  final int reviews;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 326.h,
      width: double.maxFinite,
      child: Stack(
        children: [
          // thumbnail image
          ClipRRect(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(10.r),
              bottomLeft: Radius.circular(10.r),
            ),
            child: CachedNetworkImage(
              imageUrl: image,
              fit: BoxFit.cover,
              height: 326.h,
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

          // rating and reviews
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              height: 30.h,
              width: 150.w,
              decoration: BoxDecoration(
                color: AppColors.bodyDarkGray.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(4.r),
              ),

              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // star
                  Icon(Icons.star_rounded, color: Color(0xFFF0C020)),

                  // star value
                  Text(
                    rating.toString(),
                    style: getTextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.cardBackgroundSoftGray,
                    ),
                  ),

                  Text(
                    reviews.toString(),
                    style: getTextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFFD1D3D8),
                    ),
                  ),
                ],
              ),
            ).paddingOnly(left: 20.w, bottom: 20.h),
          ),
        ],
      ),
    );
  }
}
