import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sireenshaban/features/customer/home/views/widget/trending_nearby_card.dart';

import '../../../../../core/common/styles/global_text_style.dart';
import '../../../../../core/utils/constants/colors.dart';

class TrendingNearby extends StatelessWidget {
  const TrendingNearby({super.key});

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

        // trending nearby card
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              TrendingNearbyCard(
                image:
                    "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/17/7e/c1/88/cafeteria-armenia.jpg?w=500&h=-1&s=1",
                title: "Artisan Coffee",
                status: "Popular",
              ),

              TrendingNearbyCard(
                image:
                "https://images.unsplash.com/photo-1585747860715-2ba37e788b70?ixid=M3wyNDE0NjF8MHwxfHNlYXJjaHw2fHxCYXJiZXJ8ZW58MHx8fHwxNjk1MzMwNzk5fDA&ixlib=rb-4.0.3&w=800&h=800",
                title: "Fresh Cuts Barbershop",
                status: "Popular",
              ),
            ],
          ),
        ),
      ],
    );
  }
}
