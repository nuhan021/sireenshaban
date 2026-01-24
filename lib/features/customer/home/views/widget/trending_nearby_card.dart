import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sireenshaban/core/utils/helpers/app_helper.dart';
import 'package:sireenshaban/core/utils/logging/logger.dart';
import 'package:sireenshaban/features/customer/business_and_creative_services/views/screens/business_and_creative_services_screens.dart';
import 'package:sireenshaban/features/customer/home/controller/home_controller.dart';
import 'package:sireenshaban/features/customer/home_and_maintenance_services/views/screens/home_and_maintenance_services_screens.dart';
import 'package:sireenshaban/features/customer/personal_care_and_education/views/screens/personal_care_and_education_screens.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../../core/common/styles/global_text_style.dart';
import '../../../../../core/utils/constants/colors.dart';

class TrendingNearbyCard extends StatelessWidget {
  const TrendingNearbyCard({
    super.key,
    required this.image,
    required this.title,
    required this.status,
    required this.group,
    required this.controller,
    required this.vendorId,
    required this.vendorUserId,
    this.coverImage,
  });
  final String image;
  final String title;
  final String status;
  final String group;
  final HomeController controller;
  final int vendorId;
  final int vendorUserId;
  final String? coverImage;

  @override
  Widget build(BuildContext context) {
    AppLoggerHelper.debug(group);
    return GestureDetector(
      onTap: () {
        switch (group) {
          case "businessAndCreativeServices":
            AppHelperFunctions.navigateToScreen(
              context,
              BusinessAndCreativeServicesScreens(
                image: image,
                coverImage: coverImage,
                title: title,
                controller: controller,
                vendorId: vendorId,
                
              ),
            );
              AppLoggerHelper.debug("case 1 : businessAndCreativeServices");
            break;
            
          case "personalCareAndEducation":
            AppHelperFunctions.navigateToScreen(
              context,
              PersonalCareAndEducationScreens(
                image: image,
                title: title,
                controller: controller,
                vendorId: vendorId,
              ),
            );
  AppLoggerHelper.debug("case 2 : personalCareAndEducation");
          default:
            AppHelperFunctions.navigateToScreen(
              context,
              HomeAndMaintenanceServicesScreens(
                image: image,
                title: title,
                controller: controller,
                vendorUserId: vendorUserId,
              ),
            );
              AppLoggerHelper.debug("case 3 : default");
        }
      },
      child: Card(
        child: Container(
          height: 180.h,
          width: 220.w,
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: AppColors.cardBackgroundSoftGray,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: AppColors.primaryDeepBlueLight),
          ),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // thumbnail image
              ClipRRect(
                borderRadius: BorderRadius.circular(4.r),
                child: CachedNetworkImage(
                  imageUrl: image,
                  fit: BoxFit.cover,
                  height: 113.h,
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

              Row(
                children: [
                  // title
                  Expanded(
                    child: Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      style: getTextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.secondaryInfoMediumGrayDarker,
                      ),
                    ),
                  ),

                  5.horizontalSpace,

                  // status
                  Container(
                    height: 25.h,
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    decoration: BoxDecoration(
                      color: AppColors.accentNormal,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      status,
                      style: getTextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ).paddingOnly(left: 20.w),
    );
  }
}
