import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sireenshaban/core/common/styles/global_text_style.dart';
import 'package:sireenshaban/core/utils/constants/colors.dart';

class CustomLoading extends StatelessWidget {
  const CustomLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.h,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: AppColors.primaryDeepBlueNormal,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Center(
        child: LoadingAnimationWidget.dotsTriangle(color: Colors.white, size: 25.w),
      ),
    );
  }
}
