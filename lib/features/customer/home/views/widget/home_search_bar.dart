import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../core/common/styles/global_text_style.dart';
import '../../../../../core/utils/constants/colors.dart';
import '../../../../../core/utils/constants/icon_path.dart';

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({super.key, required this.searchController});

  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 47.h,
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
            child: Center(
              child: TextField(
                controller: searchController,
                onTapOutside: (_) {
                  FocusScope.of(context).unfocus();
                },
                cursorColor: AppColors.primaryDeepBlueNormal,
                decoration: InputDecoration(
                  hintText: "Search venues & services... ",
                  hintStyle: getTextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.secondaryInfoMediumGray,
                  ),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  suffixIcon: Icon(
                    Icons.mic_none_outlined,
                    color: AppColors.secondaryInfoMediumGray,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                ),
              ),
            ),
          ),
        ),

        10.horizontalSpace,

        Container(
          height: 47.h,
          width: 47.w,
          decoration: BoxDecoration(
            color: AppColors.primaryDeepBlueNormal,
            borderRadius: BorderRadius.circular(8.r),
          ),
          alignment: Alignment.center,
          child: Image.asset(IconPath.sliders, height: 20.h),
        ),
      ],
    ).paddingSymmetric(horizontal: 20.w);
  }
}
