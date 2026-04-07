import 'package:flutter/material.dart';
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
    required this.id,
    required this.image,
    required this.shopTitle,
    required this.discount,
    required this.subtitle,
    required this.validityDate,
    required this.role,
    required this.group,
    required this.controller,
    this.isFromVendorScreen = false,
    required this.rating,
    required this.category,
    required this.location,
    required this.price,
  });

  final int id;
  final String image;
  final String shopTitle;
  final String discount;
  final String subtitle;
  final String validityDate;
  final String role;
  final ServicesGroup group;
  final HomeController controller;
  final bool isFromVendorScreen;
  final int rating;
  final String category;
  final String location;
  final String price;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.cardBackgroundSoftGray,
        borderRadius: BorderRadius.circular(12),
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

      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Stack(
            children: [
              // image
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: CachedNetworkImage(
                  imageUrl: image,
                  fit: BoxFit.cover,
                  height: 160,
                  width: double.maxFinite,
                  placeholder: (context, url) => Center(
                    child: LoadingAnimationWidget.staggeredDotsWave(
                      color: AppColors.primaryDeepBlueLight,
                      size: 25,
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
                    height: 20,
                    width: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: const Color(0xFFFFC70F),
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          '$rating',
                          style: getTextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: AppColors.bodyDarkGray,
                          ),
                        ),

                        const Icon(
                          Icons.star,
                          color: AppColors.bodyDarkGray,
                          size: 15,
                        ),
                      ],
                    ),
                  ).paddingOnly(left: 12),

                  // favorite
                  Container(
                    height: 25,
                    width: 25,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.cardBackgroundSoftGray,
                    ),
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.favorite_border,
                      color: AppColors.bodyDarkGray,
                      size: 15,
                    ),
                  ).paddingOnly(right: 12),
                ],
              ).paddingOnly(top: 12),
            ],
          ),

          const SizedBox(height: 10),

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
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.bodyDarkGray,
                  ),
                ),
              ),

              // discount
              Container(
                height: 30,
                width: 65,
                decoration: BoxDecoration(
                  color: AppColors.secondaryAquaNormal,
                  borderRadius: BorderRadius.circular(4),
                ),
                alignment: Alignment.center,
                child: Text(
                  discount,
                  style: getTextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.secondaryTealLight,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 4),

          // category
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: AppColors.primaryDeepBlueLight,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              category,
              style: getTextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: AppColors.primaryDeepBlueNormal,
              ),
            ),
          ),

          const SizedBox(height: 4),

          // price
          Text(
            '\$$price / per event',
            style: getTextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.accentNormal,
            ),
          ),

          const SizedBox(height: 4),

          // location
          if (location.isNotEmpty)
            Row(
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  size: 14,
                  color: AppColors.secondaryInfoMediumGrayNormal,
                ),
                const SizedBox(width: 3),
                Expanded(
                  child: Text(
                    location,
                    overflow: TextOverflow.ellipsis,
                    style: getTextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      color: AppColors.secondaryInfoMediumGrayNormal,
                    ),
                  ),
                ),
              ],
            ),

          const SizedBox(height: 2),

          // validity date
          Row(
            children: [
              const Icon(
                Icons.access_time,
                size: 14,
                color: AppColors.secondaryTealNormal,
              ),
              const SizedBox(width: 3),
              Text(
                'Valid until $validityDate',
                style: getTextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  color: AppColors.secondaryTealNormal,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          CustomPrimaryButton(
            text: 'View Deal',
            color: AppColors.primaryDeepBlueNormal,
            height: 44,
            fontSize: 14,
            onPressed: () => AppHelperFunctions.navigateToScreen(
              context,
              PackageBookingPage(
                id: id,
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
    );
  }
}
