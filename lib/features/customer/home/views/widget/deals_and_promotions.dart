import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sireenshaban/core/utils/constants/enums.dart';
import 'package:sireenshaban/features/customer/home/controller/home_controller.dart';
import 'package:sireenshaban/features/customer/home/views/widget/deals_and_promotions_card.dart';

import '../../../../../core/common/styles/global_text_style.dart';
import '../../../../../core/utils/constants/colors.dart';

class DealsAndPromotions extends StatefulWidget {
  const DealsAndPromotions({
    super.key,
    required this.controller,
    this.isFromVendorScreen = false,
  });

  final HomeController controller;
  final bool isFromVendorScreen;

  @override
  State<DealsAndPromotions> createState() => _DealsAndPromotionsState();
}

class _DealsAndPromotionsState extends State<DealsAndPromotions> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (widget.controller.packages.value == null ||
          widget.controller.packages.value!.data.isEmpty) {
        return Text(
          'No Deals & Promotions',
          style: getTextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.secondaryInfoMediumGrayDarker,
          ),
        ).paddingOnly(left: 20.w);
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // title
          Text(
            'Deals & Promotions',
            style: getTextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.secondaryInfoMediumGrayDarker,
            ),
          ).paddingSymmetric(horizontal: 20.w),

          20.verticalSpace,

          CarouselSlider.builder(
            itemCount: widget.controller.packages.value?.data.length ?? 0,
            options: CarouselOptions(
              height: 365.h,
              autoPlay: false,
              enlargeCenterPage: true,
              viewportFraction: 0.6,
              enableInfiniteScroll: false,
              initialPage: 1,
              onPageChanged: (index, reason) {
                widget.controller.changeCarouselCurrentIndex(value: index);
              },
            ),
            itemBuilder: (context, index, realIndex) {
              return Obx(() {
                final packages = widget.controller.packages.value;
                if (packages == null) {
                  return Text(
                    'No Data Found!',
                    style: getTextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.secondaryInfoMediumGrayDarker,
                    ),
                  );
                }

                final item = packages.data[index];
                late ServicesGroup group;
                switch (item.serviceGroup) {
                  case 'businessAndCreativeServices':
                    group = ServicesGroup.businessAndCreativeServices;
                    break;
                  case 'personalCareAndEducation':
                    group = ServicesGroup.personalCareAndEducation;
                    break;
                  case 'homeAndMaintenanceServices':
                    group = ServicesGroup.homeAndMaintenanceServices;
                    break;
                }
                final bool isCenter =
                    realIndex == widget.controller.carouselCurrentIndex.value;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeOut,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: ImageFiltered(
                      imageFilter: isCenter
                          ? ImageFilter.blur(sigmaX: 0, sigmaY: 0)
                          : ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                      child: DealsAndPromotionsCard(
                        id: item.id,
                        image: item.image ?? '',
                        shopTitle: item.title,
                        discount: "0",
                        subtitle: item.subtitle ?? '',
                        validityDate: item.validUntil != null
                            ? "${item.validUntil!.day}-${item.validUntil!.month}-${item.validUntil!.year}"
                            : "N/A",
                        role: item.category.name,
                        group: group,
                        controller: widget.controller,
                        isFromVendorScreen: widget.isFromVendorScreen,
                        rating: item.reviewsSumRating,
                      ),
                    ),
                  ),
                );
              });
            },
          ),
        ],
      );
    });
  }
}
