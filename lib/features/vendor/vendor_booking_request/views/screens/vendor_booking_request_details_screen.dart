import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sireenshaban/core/common/widgets/IField.dart';
import 'package:sireenshaban/features/vendor/vendor_booking_request/views/widgets/client_profile_section.dart';

import '../../../../../core/common/styles/global_text_style.dart';
import '../../../../../core/common/widgets/custom_primary_button.dart';
import '../../../../../core/utils/constants/colors.dart';
import '../../../../../core/utils/constants/icon_path.dart';
import '../../../../../routes/app_routes.dart';

class VendorBookingRequestDetailsScreen extends StatelessWidget {
  const VendorBookingRequestDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F4F4),
      appBar: AppBar(
        backgroundColor: Color(0xFFF4F4F4),
        title: Text(
          'Booking Request',
          style: getTextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.bodyDarkGray,
          ),
        ),

        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed(AppRoute.getNotificationScreen());
            },
            icon: Container(
              height: 40.h,
              width: 40.w,
              decoration: BoxDecoration(
                color: Color(0xFF3333331A),
                shape: BoxShape.circle,
              ),
              alignment: AlignmentGeometry.center,
              child: Image.asset(IconPath.notification, height: 24.h),
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            20.verticalSpace,

            // client profile section
            ClientProfileSection(),

            20.verticalSpace,

            // request details
            Container(
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 20.h),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14.r),
                  color: AppColors.cardBackgroundSoftGray
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Request Details',
                    style: getTextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.bodyDarkGray,
                    ),
                  ),

                  20.verticalSpace,

                  Text(
                    'Project Scope',
                    style: getTextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.bodyDarkGray,
                    ),
                  ),

                  12.verticalSpace,

                  Text(
                    "Wedding photography mth engagement session. full day coverage including ceremony and reception",
                    textAlign: TextAlign.start,
                    style: getTextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.bodyDarkGray
                    ),
                  ),

                  20.verticalSpace,

                  Row(
                    children: [
                      Text(
                        'Duration:',
                        style: getTextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.bodyDarkGray,
                        ),
                      ),

                      20.horizontalSpace,

                      Text(
                        '8 hours',
                        style: getTextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.bodyDarkGray
                        ),
                      )
                    ],
                  ),

                  10.verticalSpace,

                  Row(
                    children: [
                      Text(
                        'Event Type:',
                        style: getTextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.bodyDarkGray,
                        ),
                      ),

                      20.horizontalSpace,

                      Text(
                        'Wedding',
                        style: getTextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.bodyDarkGray
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),

            20.verticalSpace,

            // quote
            Container(
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 20.h),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14.r),
                  color: AppColors.cardBackgroundSoftGray
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Provide Your Quote',
                    style: getTextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.bodyDarkGray
                    ),
                  ),

                  20.verticalSpace,

                  Text(
                    'Final Quote Price',
                    style: getTextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.secondaryAquaNormal
                    ),
                  ),

                  10.verticalSpace,

                  // // final quote price
                  IField(
                    controller: TextEditingController(),
                    filled: true,
                    fillColour: Color(0xFFE8F8F6),
                    borderColor: Color(0xFFB6E9E3),
                    hintText: "\$600.00",
                    hintTextStyle: getTextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.secondaryAquaNormal,
                    ),
                  ),

                  20.verticalSpace,

                  Text(
                    'Final Terms/Notes',
                    style: getTextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.secondaryAquaNormal
                    ),
                  ),

                  10.verticalSpace,

                  // final Terms
                  IField(
                    controller: TextEditingController(),
                    filled: true,
                    fillColour: Color(0xFFE8F8F6),
                    borderColor: Color(0xFFB6E9E3),
                    maxLine: 5,
                  )
                ],
              ),
            ),

            20.verticalSpace,

            // payment summary
            Container(
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 20.h),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14.r),
                  color: AppColors.cardBackgroundSoftGray
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Payment Summary',
                    style: getTextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.bodyDarkGray
                    ),
                  ),

                  30.verticalSpace,

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Services fee',
                        style: getTextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.primaryDeepBlueNormal,
                        ),
                      ),

                      Text(
                        '60.00',
                        style: getTextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.bodyDarkGray,
                        ),
                      ),

                    ],
                  ),
                  10.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Platform fee',
                        style: getTextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.primaryDeepBlueNormal,
                        ),
                      ),

                      Text(
                        '205.00',
                        style: getTextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.bodyDarkGray,
                        ),
                      ),

                    ],
                  ),

                  12.verticalSpace,

                  Divider(color: Color(0xFFB9C2DB),),

                  12.verticalSpace,

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total',
                        style: getTextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryDeepBlueNormal,
                        ),
                      ),

                      Text(
                        '274.60',
                        style: getTextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.bodyDarkGray,
                        ),
                      ),

                    ],
                  ),
                ],
              ),
            ),

            20.verticalSpace,

            // payment method
            Container(
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 20.h),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14.r),
                  color: AppColors.cardBackgroundSoftGray
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Payment Method',
                    style: getTextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.bodyDarkGray
                    ),
                  ),

                  10.verticalSpace,

                  // stripe
                  Container(
                    height: 50.h,
                    width: double.maxFinite,
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                        color: AppColors.primaryDeepBlueLight,
                        borderRadius: BorderRadius.circular(8.r)
                    ),

                    child: Row(
                      children: [
                        Image.asset(IconPath.mobile),
                        13.horizontalSpace,
                        Text(
                          'Stripe',
                          style: getTextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.bodyDarkGray
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),

            20.verticalSpace,

            CustomPrimaryButton(text: 'Quote & Accept', color: AppColors.primaryDeepBlueNormal, onPressed: (){}),

            20.verticalSpace,
          ],
        ).paddingSymmetric(horizontal: 15.w),
      ),
    );
  }
}
