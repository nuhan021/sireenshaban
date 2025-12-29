import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sireenshaban/features/customer/home/controller/home_controller.dart';
import 'package:sireenshaban/features/customer/home/views/widget/trending_nearby_card.dart';

import '../../../../../core/common/styles/global_text_style.dart';
import '../../../../../core/utils/constants/colors.dart';
import '../../../../../core/utils/constants/enums.dart';

class TrendingNearby extends StatelessWidget {
  const TrendingNearby({super.key, required this.controller});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // title
        Text(
          'Trending Nearby',
          style: getTextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.secondaryInfoMediumGrayDarker,
          ),
        ).paddingSymmetric(horizontal: 20.w),

        20.verticalSpace,

        SizedBox(
          height: 180.h,
          width: double.maxFinite,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: controller.trending.value!.data.length,
            itemBuilder: (context, index) {
              final item = controller.trending.value!.data[index];
              return TrendingNearbyCard(
                image: item.image ?? '',
                coverImage: item.backgroundImage,
                title: item.businessName ?? '',
                status: 'popular',
                group: ServicesGroup.businessAndCreativeServices,
                controller: controller,
                vendorId: item.id,
              );
            },
          ),
        ),
      ],
    );
  }
}
