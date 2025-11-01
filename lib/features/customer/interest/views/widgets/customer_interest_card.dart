import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sireenshaban/core/common/styles/global_text_style.dart';
import 'package:sireenshaban/core/utils/logging/logger.dart';
import 'package:sireenshaban/features/customer/interest/controller/customer_interest_controller.dart';

import '../../../../../core/utils/constants/colors.dart';

class CustomerInterestCard extends StatelessWidget {
  const CustomerInterestCard({
    super.key,
    required this.image,
    required this.role,
    required this.controller,
  });

  final String image;
  final String role;
  final CustomerInterestController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Column(
          children: [
            SizedBox(
              height: 80.h,
              width: 80.w,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(360.r),
                child: CachedNetworkImage(
                  imageUrl: image,
                  fit: BoxFit.cover,
                  height: 80.h,
                  width: double.maxFinite,
                  placeholder: (context, url) => Center(
                    child: LoadingAnimationWidget.staggeredDotsWave(
                      color: AppColors.primaryDeepBlueLight,
                      size: 25.h,
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),

            10.verticalSpace,

            Text(
              role[0].toUpperCase() + role.substring(1),
              style: getTextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.bodyDarkGray,
              ),
            ),
          ],
        ),

        Obx(() {
          return controller.selectedCategory.contains(role)
              ? Positioned(
                  right: 10.w,
                  top: 0,
                  child: Container(
                    height: 30.h,
                    width: 30.w,
                    padding: EdgeInsets.all(4.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green,
                      ),
                      child: Center(
                        child: Icon(Icons.check, color: Colors.white),
                      ),
                    ),
                  ),
                )
              : SizedBox();
        }),

        GestureDetector(
          onTap: () => controller.addAndRemoveCategory(role: role),
          child: Container(
            height: double.maxFinite,
            width: double.maxFinite,
            color: Colors.transparent,
          ),
        )
      ],
    );
  }
}
