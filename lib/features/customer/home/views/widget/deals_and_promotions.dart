import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sireenshaban/features/customer/home/controller/home_controller.dart';
import 'package:sireenshaban/features/customer/home/views/widget/deals_and_promotions_card.dart';

import '../../../../../core/common/styles/global_text_style.dart';
import '../../../../../core/utils/constants/colors.dart';
import '../../../../../core/utils/constants/image_path.dart';

class DealsAndPromotions extends StatelessWidget {
  DealsAndPromotions({super.key, required this.controller});

  final HomeController controller;

  final List<Widget> dealsAndPromotionsCardSliders = [
    DealsAndPromotionsCard(
      image: ImagePath.restaurantBannerImg,
      shopTitle: 'Marco\'s Kitchen',
      discount: '15% off',
      subtitle: 'Dinner for two',
      validityDate: 'Valid until Feb 20',
      role: 'restaurant',
    ),

    DealsAndPromotionsCard(
      image: ImagePath.salonBannerImg,
      shopTitle: 'Bella vista Salon',
      discount: '15% off',
      subtitle: 'First haircut & styling',
      validityDate: 'Valid until Feb 20',
      role: 'salon',
    ),

    DealsAndPromotionsCard(
      image: ImagePath.gymBannerImg,
      shopTitle: 'FitLife Gym',
      discount: '15% off',
      subtitle: 'Trial membership',
      validityDate: 'Valid until Feb 20',
      role: 'gym',
    )
  ];

  @override
  Widget build(BuildContext context) {
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
          itemCount: dealsAndPromotionsCardSliders.length,
          options: CarouselOptions(
            height: 365.h,
            autoPlay: false,
            enlargeCenterPage: true,
            viewportFraction: 0.6,
            enableInfiniteScroll: false,
            initialPage: 1,
            onPageChanged: (index, reason) {
              controller.changeCarouselCurrentIndex(value: index);
            },
          ),
          itemBuilder: (context, index, realIndex) {
            return Obx(() {
              final bool isCenter =
                  realIndex == controller.carouselCurrentIndex.value;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOut,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: ImageFiltered(
                    imageFilter: isCenter
                        ? ImageFilter.blur(sigmaX: 0, sigmaY: 0)
                        : ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                    child: dealsAndPromotionsCardSliders[realIndex],
                  ),
                ),
              );
            });
          },
        ),
      ],
    );
  }
}
