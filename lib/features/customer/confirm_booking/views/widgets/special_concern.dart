import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sireenshaban/core/common/widgets/IField.dart';

import '../../../../../core/common/styles/global_text_style.dart';
import '../../../../../core/utils/constants/colors.dart';

class SpecialConcern extends StatelessWidget {
  const SpecialConcern({super.key, required this.specialConcernController});

  final TextEditingController specialConcernController;

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
          Text(
            "Special Concerns",
            style: getTextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.bodyDarkGray,
            ),
          ).paddingSymmetric(horizontal: 10.w),

          12.verticalSpace,
          IField(
            controller: specialConcernController,
            maxLine: 5,
            borderColor: Color(0xFFD1D3D8),
            filled: true,
            fillColour: AppColors.primaryDeepBlueLight,
            hintText: 'Your special concerns',
          ),
        ],
      ),
    );
  }
}
