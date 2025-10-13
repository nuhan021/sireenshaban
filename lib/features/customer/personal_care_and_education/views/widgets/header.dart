import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sireenshaban/core/common/styles/global_text_style.dart';
import 'package:sireenshaban/core/utils/constants/icon_path.dart';

import '../../../../../core/utils/constants/colors.dart';

class Header extends StatelessWidget {
  const Header({super.key, required this.image, required this.title});
  final String image;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // thumbnail image and profile
        SizedBox(
          height: 240.h,
          width: double.maxFinite,
          child: Stack(
            children: [
              // thumbnail
              ClipRRect(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10.r), bottomRight: Radius.circular(10.r)),
                child: CachedNetworkImage(
                  imageUrl: image,
                  fit: BoxFit.cover,
                  height: 225.h,
                  width: double.maxFinite,
                  placeholder: (context, url) => Center(
                    child: LoadingAnimationWidget.staggeredDotsWave(color: AppColors.primaryDeepBlueLight, size: 25.h),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 15.w,
                child: CircleAvatar(
                  radius: 50.r,
                  backgroundImage: NetworkImage("https://cdn.wallpapersafari.com/72/25/n02Ke8F.jpg", ),
                ),
              )
            ],
          ),
        ),

        20.verticalSpace,

        // title
        Text(
          title,
          style: getTextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.bodyDarkGray
          ),
        ).paddingSymmetric(horizontal: 20.w),

        Text(
          'professional  service',
          style: getTextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.bodyDarkGray
          ),
        ).paddingSymmetric(horizontal: 20.w),
        
        
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.location_on_outlined, color: AppColors.secondaryTealNormal,),
                8.horizontalSpace,
                Text(
                  'New York',
                  style: getTextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.secondaryTealNormal,
                  ),
                )
              ],
            ),

            Row(
              children: [
                Image.asset(IconPath.message, height: 25.h,),
                8.horizontalSpace,
                Image.asset(IconPath.call, height: 25.h,)
              ],
            )
          ],
        ).paddingSymmetric(horizontal: 20.w),

      ],
    );
  }
}
