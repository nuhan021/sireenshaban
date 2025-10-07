import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/common/styles/global_text_style.dart';
import '../../../../../core/utils/constants/colors.dart';

class AdditionalServiceCard extends StatelessWidget {
  const AdditionalServiceCard({
    super.key,
    required this.img,
    required this.title,
    required this.onPressed,
  });

  final String img;
  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 80.h,
          width: 80.w,
          padding: EdgeInsets.all(10),
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
          child: Image.asset(img),
        ),
        7.horizontalSpace,
        Text(
          title,
          style: getTextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.secondaryInfoMediumGrayDarker,
          ),
        ),
      ],
    );
  }
}
