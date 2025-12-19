import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../../../../core/common/styles/global_text_style.dart';
import '../../../../../core/utils/constants/colors.dart';

class AdditionalServiceCard extends StatelessWidget {
  const AdditionalServiceCard({
    super.key,
    required this.img,
    required this.title,
    required this.onPressed,
    this.isHorizontal = false,
  });

  final String img;
  final String title;
  final VoidCallback onPressed;
  final bool isHorizontal;

  @override
  Widget build(BuildContext context) {
    return isHorizontal ? _buildHorizontalCard() : _buildVerticalCard();
  }

  Widget _buildHorizontalCard() {
    return GestureDetector(
      onTap: onPressed,
      child: Row(
        children: [
          Container(
            height: 70.h,
            width: 70.w,
            padding: EdgeInsets.all(5.w),
            decoration: BoxDecoration(
              color: const Color(0xFFFFFFFF), // Card Background Soft Gray
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: const Color(
                  0xFFE9EAEC,
                ), // Secondary Info Medium Gray Light Hover
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  offset: const Offset(0, 3),
                  blurRadius: 10,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5.r),
              child: CachedNetworkImage(
                imageUrl: img,
                fit: BoxFit.cover,
                placeholder: (context, url) => Center(
                  child: LoadingAnimationWidget.staggeredDotsWave(color: AppColors.primaryDeepBlueLight, size: 25.h),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
          7.horizontalSpace,
          Text(
            title,
            style: getTextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.secondaryInfoMediumGrayDarker,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVerticalCard() {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          Container(
            height: 70.h,
            width: 70.w,
            padding: EdgeInsets.all(3.w),
            decoration: BoxDecoration(
              color: const Color(0xFFFFFFFF), // Card Background Soft Gray
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: const Color(
                  0xFFE9EAEC,
                ), // Secondary Info Medium Gray Light Hover
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  offset: const Offset(0, 3),
                  blurRadius: 10,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5.r),
              child: CachedNetworkImage(
                imageUrl: img,
                fit: BoxFit.cover,
                placeholder: (context, url) => Center(
                  child: LoadingAnimationWidget.staggeredDotsWave(color: AppColors.primaryDeepBlueLight, size: 25.h),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              )
            ),
          ),
          7.horizontalSpace,
          Text(
            title,
            style: getTextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.secondaryInfoMediumGrayDarker,
            ),
          ),
        ],
      ),
    );
  }
}
