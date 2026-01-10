import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sireenshaban/core/common/widgets/IField.dart';

import '../../../../../core/common/styles/global_text_style.dart';
import '../../../../../core/utils/constants/colors.dart';
import '../../../../../core/utils/constants/icon_path.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F4F4),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: false,
        title: Text(
          'Search',
          style: getTextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.bodyDarkGray,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Container(
              height: 40.h,
              width: 40.w,
              padding: EdgeInsets.all(7.w),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFE9EAEC),
              ),
              child: Image.asset(IconPath.notification),
            ),
          ),
        ],
      ),

      body: Column(
        children: [
          10.verticalSpace,

          // search bar
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: const Color.fromRGBO(13, 10, 44, 0.06),
                  offset: const Offset(0, 3),
                  blurRadius: 10,
                  spreadRadius: 0,
                ),
              ],
              borderRadius: BorderRadius.circular(12),
            ),
            child: IField(
              controller: TextEditingController(),
              filled: true,
              fillColour: AppColors.cardBackgroundSoftGray,
              hintText: "Search Services",
              hintTextStyle: getTextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.secondaryInfoMediumGrayNormal,
              ),
              borderColor: Colors.transparent,
              suffixIcon: GestureDetector(
                onTap: () {},
                child: Padding(
                  padding: EdgeInsets.all(10.w),
                  child: Image.asset(
                    IconPath.navSearch,
                    height: 24.h,
                    color: AppColors.primaryDeepBlueNormal,
                  ),
                ),
              ),
            ),
          ),

          10.verticalSpace,

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset(
                    IconPath.navSearch,
                    height: 25.h,
                    color: AppColors.primaryDeepBlueNormal,
                  ),
                  10.horizontalSpace,
                  Text(
                    "Dentist",
                    style: getTextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.bodyDarkGray,
                    ),
                  ),
                ],
              ).paddingSymmetric(vertical: 10.h),
              Row(
                children: [
                  Image.asset(
                    IconPath.navSearch,
                    height: 25.h,
                    color: AppColors.primaryDeepBlueNormal,
                  ),
                  10.horizontalSpace,
                  Text(
                    "Restaurant",
                    style: getTextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.bodyDarkGray,
                    ),
                  ),
                ],
              ).paddingSymmetric(vertical: 10.h),
              Row(
                children: [
                  Image.asset(
                    IconPath.navSearch,
                    height: 25.h,
                    color: AppColors.primaryDeepBlueNormal,
                  ),
                  10.horizontalSpace,
                  Text(
                    "Plumber",
                    style: getTextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.bodyDarkGray,
                    ),
                  ),
                ],
              ).paddingSymmetric(vertical: 10.h),
              Row(
                children: [
                  Image.asset(
                    IconPath.navSearch,
                    height: 25.h,
                    color: AppColors.primaryDeepBlueNormal,
                  ),
                  10.horizontalSpace,
                  Text(
                    "Electrician",
                    style: getTextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.bodyDarkGray,
                    ),
                  ),
                ],
              ).paddingSymmetric(vertical: 10.h),
            ],
          ).paddingSymmetric(horizontal: 20.w),
        ],
      ).paddingSymmetric(horizontal: 20.w),
    );
  }
}
