import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sireenshaban/core/common/styles/global_text_style.dart';
import 'package:sireenshaban/core/common/widgets/custom_primary_button.dart';
import 'package:sireenshaban/core/utils/constants/colors.dart';
import 'package:sireenshaban/core/utils/helpers/app_helper.dart';
import 'package:sireenshaban/features/customer/home/controller/home_controller.dart';
import 'package:sireenshaban/features/customer/package_booking/views/screens/package_booking_page.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../../../core/utils/constants/enums.dart';

class DealsAndPromotionsCard extends StatelessWidget {
  const DealsAndPromotionsCard({
    super.key,
    required this.image,
    required this.shopTitle,
    required this.discount,
    required this.subtitle,
    required this.validityDate,
    required this.role,
    required this.group,
    required this.controller,
    this.isFromVendorScreen = false,
  });

  final String image;
  final String shopTitle;
  final String discount;
  final String subtitle;
  final String validityDate;
  final String role;
  final ServicesGroup group;
  final HomeController controller;
  final bool isFromVendorScreen;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 364.h,
      width: 260.w,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.cardBackgroundSoftGray,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.primaryDeepBlueLight),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            offset: const Offset(0, 0),
            blurRadius: 4,
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            offset: const Offset(0, 8),
            blurRadius: 16,
            spreadRadius: 0,
          ),
        ],
      ),

      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                // image
                ClipRRect(
                  borderRadius: BorderRadius.circular(4.r),
                  child: CachedNetworkImage(
                    imageUrl: image,
                    fit: BoxFit.cover,
                    height: 160.h,
                    width: double.maxFinite,
                    placeholder: (context, url) => Center(
                      child: LoadingAnimationWidget.staggeredDotsWave(
                        color: AppColors.primaryDeepBlueLight,
                        size: 25.h,
                      ),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // rating
                    Container(
                      height: 20.h,
                      width: 50.w,
                      padding: EdgeInsets.symmetric(horizontal: 6.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.r),
                        color: Color(0xFFFFC70F),
                      ),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            '4.5',
                            style: getTextStyle(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.bodyDarkGray,
                            ),
                          ),

                          Icon(
                            Icons.star,
                            color: AppColors.bodyDarkGray,
                            size: 15,
                          ),
                        ],
                      ),
                    ).paddingOnly(left: 12.w),

                    // favorite
                    Container(
                      height: 25.h,
                      width: 25.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.cardBackgroundSoftGray,
                      ),
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.favorite_border,
                        color: AppColors.bodyDarkGray,
                        size: 15,
                      ),
                    ).paddingOnly(right: 12.w),
                  ],
                ).paddingOnly(top: 12.h),
              ],
            ),

            30.verticalSpace,

            // shop title and discount
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // shop title
                Expanded(
                  child: Text(
                    shopTitle,
                    overflow: TextOverflow.ellipsis,
                    style: getTextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.bodyDarkGray,
                    ),
                  ),
                ),

                // discount
                Container(
                  height: 30.h,
                  width: 65.w,
                  decoration: BoxDecoration(
                    color: AppColors.secondaryAquaNormal,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    discount,
                    style: getTextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.secondaryTealLight,
                    ),
                  ),
                ),
              ],
            ),

            // subtitle
            Text(
              subtitle,
              style: getTextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.secondaryInfoMediumGrayNormal,
              ),
            ),

            // validity date
            Text(
              validityDate,
              style: getTextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.secondaryTealNormal,
              ),
            ),

            27.verticalSpace,

            CustomPrimaryButton(
              text: 'View Deal',
              color: AppColors.primaryDeepBlueNormal,
              onPressed: () => AppHelperFunctions.navigateToScreen(
                context,
                PackageBookingPage(
                  image: image,
                  title: shopTitle,
                  controller: controller,
                  group: group,
                  isFromVendorScreen: isFromVendorScreen,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
