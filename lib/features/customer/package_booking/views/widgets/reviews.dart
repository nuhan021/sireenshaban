import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sireenshaban/core/common/styles/global_text_style.dart';
import 'package:sireenshaban/core/utils/constants/icon_path.dart';
import 'package:sireenshaban/features/customer/package_booking/views/widgets/reviews_card.dart';

import '../../../../../core/utils/constants/colors.dart';

class Reviews extends StatelessWidget {
  const Reviews({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // title
        Text(
          "Reviews",
          style: getTextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.bodyDarkGray,
          ),
        ),

        // reviews
        Column(
          children: [
            ReviewsCard(),
            ReviewsCard(),
            ReviewsCard(),
          ],
        ),

        // explore all button

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Explore All',
              style: getTextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.accentNormal
              ),
            ),

            5.horizontalSpace,
            
            Image.asset(IconPath.arrowForword, height: 16.h,)
          ],
        )
      ],
    );
  }
}
