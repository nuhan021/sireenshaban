import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sireenshaban/core/common/styles/global_text_style.dart';

import '../../../../../core/utils/constants/colors.dart';

class LocationCard extends StatelessWidget {
  const LocationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // title
        Text(
          "Location",
          style: getTextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.bodyDarkGray,
          ),
        ),

        12.verticalSpace,

        Row(
          children: [
            Icon(Icons.location_on_outlined, color: AppColors.secondaryTealNormal, size: 21.h,),
            8.horizontalSpace,

            Text(
              'New York',
              style: getTextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.secondaryTealNormal
              ),
            )
          ],
        ),

        8.verticalSpace,

        // map
        Container(
          height: 200.h,
          width: double.maxFinite,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: Color(0xFFD1D3D8)
            )
          ),

          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: Image.network(
              "https://developers.google.com/static/maps/images/landing/hero_maps_static_api.png",
              fit: BoxFit.cover,
            ),
          ),
        )
      ],
    );
  }
}
