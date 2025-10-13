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

class DealsAndPromotions extends StatefulWidget {
  DealsAndPromotions({super.key, required this.controller});

  final HomeController controller;

  @override
  State<DealsAndPromotions> createState() => _DealsAndPromotionsState();
}

class _DealsAndPromotionsState extends State<DealsAndPromotions> {
  final List<Widget> dealsAndPromotionsCardSliders = [];

  @override
  void initState() {
    super.initState();

    for (var dealsAndPromotion in widget.controller.dealsAndPromotion) {
      dealsAndPromotionsCardSliders.add(
        DealsAndPromotionsCard(
          image: dealsAndPromotion.image,
          shopTitle: dealsAndPromotion.shopTitle,
          discount: dealsAndPromotion.discount,
          subtitle: dealsAndPromotion.shopTitle,
          validityDate: dealsAndPromotion.validityDate,
          role: dealsAndPromotion.role,
          group: dealsAndPromotion.group,
          controller: widget.controller,
        ),
      );
    }
  }

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
              widget.controller.changeCarouselCurrentIndex(value: index);
            },
          ),
          itemBuilder: (context, index, realIndex) {
            return Obx(() {
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
