import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sireenshaban/core/utils/helpers/app_helper.dart';
import 'package:sireenshaban/features/customer/home/views/widget/featured_vendors_card.dart';
import 'package:sireenshaban/features/customer/vendors/views/screens/vendors_screen.dart';
import '../../../../../core/common/styles/global_text_style.dart';
import '../../../../../core/utils/constants/colors.dart';

class FeaturedVendors extends StatelessWidget {
  const FeaturedVendors({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // title and button
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Featured Vendors',
              style: getTextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.secondaryInfoMediumGrayDarker,
              ),
            ),

            GestureDetector(
              onTap: () => AppHelperFunctions.navigateToScreen(
                context,
                VendorsScreen(),
              ),
              child: Text(
                'Explore All',
                style: getTextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryDeepBlueNormal,
                ),
              ),
            ),
          ],
        ).paddingSymmetric(horizontal: 20.sp),

        20.verticalSpace,

        // Column(
        //   children: [
        //     FeaturedVendorsCard(
        //       image:
        //           "https://img.freepik.com/premium-photo/sexy-girl-doing-yoga-home-kitchen_321831-2764.jpg",
        //       title: "Serenity Spa & Well",
        //       subtitle: "Beauty & Wellness",
        //       service: "Deep Tissue Massage",
        //       date: "15 March,2025",
        //       location: "Near you",
        //       price: "\$150",
        //     ),

        //     10.verticalSpace,

        //     FeaturedVendorsCard(
        //       image:
        //           "https://img.freepik.com/free-photo/female-doctor-hospital_23-2148827760.jpg",
        //       title: "Dr. Sarah Johnson",
        //       subtitle: "Healthcare",
        //       service: "Consultation",
        //       date: "27 April,2025",
        //       location: "Near you",
        //       price: "\$100",
        //     ),
        //   ],
        // ),
      ],
    );
  }
}