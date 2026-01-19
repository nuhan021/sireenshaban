import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sireenshaban/core/common/styles/global_text_style.dart';
import 'package:sireenshaban/core/utils/constants/icon_path.dart';
import 'package:sireenshaban/routes/app_routes.dart';

import '../../../../../core/utils/constants/colors.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
    required this.image,
    required this.title,
    required this.vendorId,
    required this.vendorName,
    this.vendorAvatar,
  });

  final String? image;
  final String title;
  final int vendorId;
  final String vendorName;
  final String? vendorAvatar;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 240.h,
          width: double.maxFinite,
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10.r),
                  bottomRight: Radius.circular(10.r),
                ),
                child: image != null && image!.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl: image!,
                        fit: BoxFit.cover,
                        height: 225.h,
                        width: double.maxFinite,
                        placeholder: (context, url) => Center(
                          child: LoadingAnimationWidget.staggeredDotsWave(
                            color: AppColors.primaryDeepBlueLight,
                            size: 25.h,
                          ),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      )
                    : Container(
                        height: 225.h,
                        width: double.maxFinite,
                        color: Colors.grey[300],
                        child: Center(child: Icon(Icons.image, size: 50.h)),
                      ),
              ),
              Positioned(
                bottom: 0,
                left: 15.w,
                child: CircleAvatar(
                  radius: 50.r,
                  backgroundImage: (vendorAvatar != null && vendorAvatar!.isNotEmpty)
                      ? NetworkImage(vendorAvatar!)
                      : null,
                  backgroundColor: Colors.grey[300],
                  child: (vendorAvatar == null || vendorAvatar!.isEmpty)
                      ? Icon(Icons.person)
                      : null,
                ),
              ),
            ],
          ),
        ),

        20.verticalSpace,

        Text(
          title,
          style: getTextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.bodyDarkGray,
          ),
        ).paddingSymmetric(horizontal: 20.w),

        Text(
          'professional service',
          style: getTextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.bodyDarkGray,
          ),
        ).paddingSymmetric(horizontal: 20.w),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  color: AppColors.secondaryTealNormal,
                ),
                8.horizontalSpace,
                Text(
                  'New York',
                  style: getTextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.secondaryTealNormal,
                  ),
                ),
              ],
            ),

            GestureDetector(
              onTap: () {
                Get.toNamed(
                  AppRoute.chatScreen,
                  arguments: {
                    'receiverId': vendorId,
                    'receiverName': vendorName,
                    'receiverAvatar': vendorAvatar,
                  },
                );
              },
              child: Image.asset(IconPath.message, height: 25.h),
            ),
          ],
        ).paddingSymmetric(horizontal: 20.w),
      ],
    );
  }
}
