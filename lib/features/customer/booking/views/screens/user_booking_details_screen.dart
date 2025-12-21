import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sireenshaban/features/vendor/vendor_home/model/vendor_booking_model.dart';

import '../../../../../core/common/styles/global_text_style.dart';
import '../../../../../core/common/widgets/IField.dart';
import '../../../../../core/utils/constants/colors.dart';
import '../../../../../core/utils/constants/icon_path.dart';
import '../../../../../core/utils/constants/image_path.dart';
import '../../../../../routes/app_routes.dart';

class UserBookingDetailsScreen extends StatelessWidget {
  const UserBookingDetailsScreen({super.key, required this.data});

  final Datum data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F4F4),
      appBar: AppBar(
        backgroundColor: Color(0xFFF4F4F4),
        title: Text(
          'Booking',
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
                      data.vendor.businessName,
                      style: getTextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.bodyDarkGray,
                      ),
                    ),
                    subtitle: Text(
                      data.package!.title,
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
                              '#${data.id}',
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
                              'Date',
                              style: getTextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryDeepBlueNormal,
                              ),
                            ),

                            Text(
                              "${data.date.day}-${data.date.month}-${data.date.year}",
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
                              'Stripe',
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
                              '\$${data.total}',
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

            40.verticalSpace,

            // contact host card
            ListTile(
              tileColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              leading: Image.asset(ImagePath.personImg, height: 40.h),
              title: Text(
                "Contact Customer",
                overflow: TextOverflow.ellipsis,
                style: getTextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.bodyDarkGray,
                ),
              ),

              subtitle: Text(
                data.user.phoneNumber ?? '',
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

            40.verticalSpace,

            // rating
            // Text(
            //   'Give Rating',
            //   style: getTextStyle(
            //     fontSize: 16.sp,
            //     fontWeight: FontWeight.w600,
            //     color: AppColors.primaryDeepBlueNormal,
            //   ),
            // ),
            //
            // 10.verticalSpace,
            //
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     for (int i = 0; i < 5; i++)
            //       Icon(
            //         Icons.star_outline_rounded,
            //         color: Color(0xFFF0C020),
            //         size: 20.h,
            //       ).paddingSymmetric(horizontal: 3.w),
            //   ],
            // ),
            //
            // 10.verticalSpace,
            //
            // Text(
            //   '0.00',
            //   style: getTextStyle(
            //     fontSize: 12.sp,
            //     fontWeight: FontWeight.w400,
            //     color: AppColors.secondaryInfoMediumGrayNormal
            //   ),
            // ),
            //
            // 20.verticalSpace,
            //
            // // feedback
            // Text(
            //   'Give feedback',
            //   style: getTextStyle(
            //     fontSize: 16.sp,
            //     fontWeight: FontWeight.w600,
            //     color: AppColors.primaryDeepBlueNormal,
            //   ),
            // ),
            //
            // 10.verticalSpace,
            //
            // IField(
            //   controller: TextEditingController(),
            //   borderColor: Color(0xFFD1D3D8),
            //   maxLine: 5,
            //   filled: true,
            //   fillColour: Colors.white,
            //   hintText: 'Your Feedback',
            // ),
            //
            // 30.verticalSpace,
            //
            // Container(
            //   height: 50.h,
            //   width: double.maxFinite,
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(12.r),
            //     border: Border.all(color: AppColors.primaryDeepBlueNormal,width: 2)
            //   ),
            //   alignment: AlignmentGeometry.center,
            //   child: Text(
            //     'Submit',
            //     style: getTextStyle(
            //       fontSize: 16.sp,
            //       fontWeight: FontWeight.w600,
            //       color: AppColors.primaryDeepBlueNormal
            //     ),
            //   ),
            // ),

            30.verticalSpace,
          ],
        ).paddingSymmetric(horizontal: 20.w),
      ),
    );
  }
}
