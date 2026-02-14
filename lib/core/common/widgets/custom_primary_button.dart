import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sireenshaban/core/common/styles/global_text_style.dart';
import 'package:sireenshaban/core/utils/constants/colors.dart';

class CustomPrimaryButton extends StatelessWidget {
  const CustomPrimaryButton({
    super.key,
    required this.text,
    required this.color,
    this.textColor = AppColors.primaryDeepBlueLight,
    required this.onPressed,
    this.isLoading = false,
  });

  final String text;
  final Color color;
  final Color textColor;
  final VoidCallback onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onPressed,
      child: Container(
        height: 48.h,
        width: double.maxFinite,
        decoration: BoxDecoration(
          // ignore: deprecated_member_use
          color: isLoading ? color.withOpacity(0.7) : color,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Center(
          child: isLoading
              ? SizedBox(
                  height: 20.h,
                  width: 20.h,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(textColor),
                  ),
                )
              : Text(
                  text,
                  style: getTextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: textColor,
                  ),
                ),
        ),
      ),
    );
  }
}
