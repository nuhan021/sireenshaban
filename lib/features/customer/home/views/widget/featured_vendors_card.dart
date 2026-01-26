import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sireenshaban/core/common/styles/global_text_style.dart';
import 'package:sireenshaban/features/customer/home/controller/home_controller.dart';

import '../../../../../core/utils/constants/colors.dart';
import '../../../../../core/utils/helpers/app_helper.dart';
import '../../../business_and_creative_services/views/screens/business_and_creative_services_screens.dart';
import '../../../home_and_maintenance_services/views/screens/home_and_maintenance_services_screens.dart';
import '../../../personal_care_and_education/views/screens/personal_care_and_education_screens.dart';

class FeaturedVendorsCard extends StatelessWidget {
  FeaturedVendorsCard({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.service,
    required this.price,
    required this.date,
    required this.location,
    required this.serviceGroup, required this.coverImage, required this.vendorId,
  });

  final String image;
  final String title;
  final String subtitle;
  final String service;
  final String price;
  final String date;
  final String location;
  final String serviceGroup;
  final String coverImage;
  final int vendorId;

  final HomeController controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170.h,
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: AppColors.cardBackgroundSoftGray,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.primaryDeepBlueLight),
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // image, title, subtitle, service, price
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // image
              ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Image.network(
                  image,
                  height: 71.h,
                  width: 71.w,
                  fit: BoxFit.cover,
                ),
              ),

              12.horizontalSpace,

              // title, subtitle, service
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // title
                    Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      style: getTextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.secondaryInfoMediumGrayDarker,
                      ),
                    ),

                    // subtitle
                    Text(
                      subtitle,
                      overflow: TextOverflow.ellipsis,
                      style: getTextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.secondaryInfoMediumGrayNormal,
                      ),
                    ),

                    // service
                    Text(
                      service,
                      overflow: TextOverflow.ellipsis,
                      style: getTextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.secondaryAquaNormal,
                      ),
                    ),
                  ],
                ),
              ),

              // price
              Text(
                price,
                style: getTextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.accentNormal,
                ),
              ),
            ],
          ),

          // date, location, book now button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // date, location
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // date
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_month_outlined,
                        color: AppColors.secondaryInfoMediumGrayNormal,
                      ),
                      5.horizontalSpace,
                      Text(
                        date,
                        style: getTextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.secondaryInfoMediumGrayNormal,
                        ),
                      ),
                    ],
                  ),

                  5.verticalSpace,

                  // location
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        color: AppColors.secondaryInfoMediumGrayNormal,
                      ),

                      5.horizontalSpace,
                      Text(
                        location,
                        style: getTextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.secondaryAquaNormal,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              // book now button
              GestureDetector(
                onTap: () {
                  switch (serviceGroup) {
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
                      break;
                    case "personalCareAndEducation":
                      AppHelperFunctions.navigateToScreen(
                        context,
                        PersonalCareAndEducationScreens(
                          image: image,
                          title: title,
                          controller: controller,
                        ),
                      );

                    default:
                      AppHelperFunctions.navigateToScreen(
                        context,
                        HomeAndMaintenanceServicesScreens(
                          image: image,
                          title: title,
                          controller: controller,
                        ),
                      );
                  }
                },
                child: Container(
                  height: 44.h,
                  width: 120.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.r),
                    border: Border.all(
                      color: AppColors.primaryDeepBlueNormal,
                      width: 2,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Book Now',
                    style: getTextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryDeepBlueNormal,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ).paddingSymmetric(horizontal: 20.w);
  }
}
