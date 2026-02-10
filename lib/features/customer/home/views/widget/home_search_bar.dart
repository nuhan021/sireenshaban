import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sireenshaban/features/customer/home/controller/home_controller.dart';
import 'package:sireenshaban/features/customer/vendors/views/screens/vendors_screen.dart';

import '../../../../../core/common/styles/global_text_style.dart';
import '../../../../../core/utils/constants/colors.dart';
import '../../../../../core/utils/constants/icon_path.dart';
import '../../../../../core/utils/helpers/app_helper.dart';

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({
    super.key,
    required this.onTap,
    required this.controller,
  });

  final VoidCallback onTap;
  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              height: 47.h,
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              decoration: BoxDecoration(
                color: AppColors.softGray,
                border: Border.all(color: AppColors.deepBlueLight),
                borderRadius: BorderRadius.circular(8.r),

                boxShadow: [
                  BoxShadow(
                    color: const Color.fromRGBO(13, 10, 44, 0.06),
                    offset: const Offset(0, 3),
                    blurRadius: 10,
                    spreadRadius: 0,
                  ),
                ],
              ),

              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "Search venues & services",
                      style: getTextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.secondaryInfoMediumGray,
                      ),
                    ),
                  ),

                  // mic icon
                  Icon(
                    Icons.mic_none_outlined,
                    color: AppColors.secondaryInfoMediumGray,
                  ),
                ],
              ),
            ),
          ),
        ),

        10.horizontalSpace,

        PopupMenuButton(
          child: Container(
            height: 47.h,
            width: 47.w,
            decoration: BoxDecoration(
              color: AppColors.primaryDeepBlueNormal,
              borderRadius: BorderRadius.circular(8.r),
            ),
            alignment: Alignment.center,
            child: Image.asset(IconPath.sliders, height: 20.h),
          ),

          itemBuilder: (BuildContext context) {
            return controller.categorys.value?.data.map((category) {
                  return PopupMenuItem<String>(
                    value: category.slug,
                    child: Text(
                      category.name,
                      style: getTextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.bodyDarkGray,
                      ),
                    ),
                  );
                }).toList() ??
                [const PopupMenuItem(child: Text("No categories available"))];
          },

          onSelected: (value) {
            AppHelperFunctions.navigateToScreen(
              context,
              VendorsScreen(categorySlug: value),
            );
          },
        ),
      ],
    ).paddingSymmetric(horizontal: 20.w);
  }
}
