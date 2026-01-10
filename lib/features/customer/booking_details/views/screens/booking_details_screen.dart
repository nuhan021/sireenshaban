import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sireenshaban/core/common/styles/global_text_style.dart';
import 'package:sireenshaban/core/common/widgets/custom_primary_button.dart';
import 'package:sireenshaban/core/utils/constants/image_path.dart';
import 'package:sireenshaban/features/customer/package_booking/views/widgets/location_card.dart';

import '../../../../../core/utils/constants/colors.dart';
import '../../../../../core/utils/constants/icon_path.dart';

class BookingDetailsScreen extends StatelessWidget {
  const BookingDetailsScreen({super.key});

  void showCancelBookingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          backgroundColor: Colors.white,
          child: Container(
            height: 255.h,
            width: 300.w,
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Color(0xFFD1D3D8)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  offset: Offset(0, 0),
                  blurRadius: 4,
                  spreadRadius: 0,
                ),
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  offset: Offset(0, 8),
                  blurRadius: 16,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Cancel Booking?',
                  style: getTextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.bodyDarkGray,
                  ),
                ),

                Text(
                  "Are you sure you want to cancel your reservation with Marco’s Kitchen on Sept 28 at 10:00 AM",
                  textAlign: TextAlign.center,
                  style: getTextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.bodyDarkGray,
                  ),
                ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomPrimaryButton(
                      text: "keep Booking",
                      color: AppColors.primaryDeepBlueNormal,
                      onPressed: () => Navigator.pop(context),
                    ),
                    5.verticalSpace,
                    CustomPrimaryButton(
                      text: "Confirm Cancel",
                      color: Color(0xFFC20000),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ).paddingSymmetric(horizontal: 40.w),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F4F4),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            height: 40.h,
            width: 40.w,
            padding: EdgeInsets.all(7.w),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xff3333331a),
            ),
            child: Image.asset(
              IconPath.arrowBack,
              height: 15.h,
              color: Colors.white,
            ),
          ).paddingAll(7.w),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            25.verticalSpace,

            // order details card
            Container(
              height: 412.h,
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(vertical: 16.h),
              decoration: BoxDecoration(
                color: AppColors.cardBackgroundSoftGray,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    offset: Offset(0, 0),
                    blurRadius: 4,
                    spreadRadius: 0,
                  ),
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    offset: Offset(0, 4),
                    blurRadius: 8,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // logo and title
                  ListTile(
                    leading: Image.asset(ImagePath.logo),
                    title: Text(
                      'Marco’s Kitchen',
                      style: getTextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.bodyDarkGray,
                      ),
                    ),
                    subtitle: Text(
                      'Private Dinner Booking',
                      style: getTextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.secondaryInfoMediumGrayNormal,
                      ),
                    ),
                  ),

                  30.verticalSpace,

                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // booking id
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Booking ID',
                              style: getTextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryDeepBlueNormal,
                              ),
                            ),

                            Text(
                              '#BV-2025-0142',
                              style: getTextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: AppColors.bodyDarkGray,
                              ),
                            ),
                          ],
                        ),

                        Divider(color: Color(0xFFD1D3D8)),

                        // date and time
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Date & Time',
                              style: getTextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryDeepBlueNormal,
                              ),
                            ),

                            Text(
                              'March 15, 2025',
                              style: getTextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: AppColors.bodyDarkGray,
                              ),
                            ),
                          ],
                        ),

                        Divider(color: Color(0xFFD1D3D8)),

                        // payment method
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Payment Method',
                              style: getTextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryDeepBlueNormal,
                              ),
                            ),

                            Text(
                              'Cash',
                              style: getTextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: AppColors.bodyDarkGray,
                              ),
                            ),
                          ],
                        ),

                        Divider(color: Color(0xFFD1D3D8)),

                        // total price
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total Paid',
                              style: getTextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.primaryDeepBlueNormal,
                              ),
                            ),

                            Text(
                              '\$120.60',
                              style: getTextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.bodyDarkGray,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ).paddingSymmetric(horizontal: 16.w),
                  ),
                ],
              ),
            ),

            30.verticalSpace,

            // additional information card
            Container(
              height: 550.h,
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.w),
              decoration: BoxDecoration(
                color: AppColors.cardBackgroundSoftGray,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    offset: Offset(0, 0),
                    blurRadius: 4,
                    spreadRadius: 0,
                  ),
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    offset: Offset(0, 4),
                    blurRadius: 8,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Additional Information',
                    style: getTextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.bodyDarkGray,
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(IconPath.message, height: 24.h),
                      7.horizontalSpace,
                      Expanded(
                        child: Text(
                          'Any Dietary restrictions, preferences, or special arrangements',
                          style: getTextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.bodyDarkGray,
                          ),
                        ),
                      ),
                    ],
                  ),

                  LocationCard(),

                  Text(
                    '123 Main Street, Downtown, NY 10001 Open in Maps',
                    style: getTextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.bodyDarkGray,
                    ),
                  ),

                  ListTile(
                    leading: Image.asset(ImagePath.personImg, height: 40.h),
                    title: Text(
                      "Contact Host",
                      overflow: TextOverflow.ellipsis,
                      style: getTextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.bodyDarkGray,
                      ),
                    ),

                    subtitle: Text(
                      "Restaurant Manager",
                      overflow: TextOverflow.ellipsis,
                      style: getTextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.bodyDarkGray,
                      ),
                    ),

                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Image.asset(IconPath.message, height: 24.h),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Image.asset(IconPath.call, height: 24.h),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            30.verticalSpace,

            CustomPrimaryButton(
              text: 'Cancel Booking',
              color: Color(0xFFC20000),
              onPressed: () => showCancelBookingDialog(context),
            ),

            30.verticalSpace,
          ],
        ).paddingSymmetric(horizontal: 20.w),
      ),
    );
  }
}
