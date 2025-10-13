import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sireenshaban/core/common/styles/global_text_style.dart';
import 'package:sireenshaban/core/common/widgets/custom_primary_button.dart';
import 'package:sireenshaban/core/utils/constants/colors.dart';
import 'package:sireenshaban/core/utils/constants/icon_path.dart';
import 'package:sireenshaban/core/utils/constants/image_path.dart';
import 'package:sireenshaban/core/utils/helpers/app_helper.dart';
import 'package:sireenshaban/features/customer/booking_details/views/screens/booking_details_screen.dart';

class BookingConfirmedScreen extends StatelessWidget {
  const BookingConfirmedScreen({super.key});

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
              color: Color(0xFF3333331A),
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
        child: Center(
          child: Column(
            children: [
              // success image
              Image.asset(ImagePath.successfulImg, height: 75.h),

              20.verticalSpace,

              Text(
                'Booking Confirmed!',
                style: getTextStyle(
                  fontSize: 26.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryDeepBlueNormal,
                ),
              ),

              Text(
                "Your reservation with Marco's Kitchen is successfully booked.",
                textAlign: TextAlign.center,
                style: getTextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.accentNormal,
                ),
              ),

              20.verticalSpace,

              // booking details
              Container(
                height: 380.h,
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(vertical: 20.h),
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
                    // booking id
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Booking Id',
                          style: getTextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.bodyDarkGray,
                          ),
                        ),

                        Container(
                          height: 33.h,
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 8.h,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.r),
                            color: AppColors.secondaryTealNormal,
                          ),
                          alignment: AlignmentGeometry.center,
                          child: Text(
                            'BK-2024-001',
                            style: getTextStyle(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.cardBackgroundSoftGray,
                            ),
                          ),
                        ),
                      ],
                    ).paddingSymmetric(horizontal: 20.w),

                    Divider(
                      color: Color(0xFFD1D3D8),
                    ).paddingSymmetric(horizontal: 20.w),

                    ListTile(
                      leading: SizedBox(),
                      title: Text(
                        'Private Dinner Booking',
                        style: getTextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.bodyDarkGray,
                        ),
                      ),

                      subtitle: Text(
                        'Marco’s Kitchen',
                        style: getTextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.secondaryInfoMediumGrayNormal,
                        ),
                      ),
                    ),

                    // date and time
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // date
                        Expanded(
                          child: ListTile(
                            leading: Container(
                              height: 42.h,
                              width: 42.h,
                              padding: EdgeInsets.all(7.w),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFFFEF1E8),
                              ),
                              alignment: AlignmentGeometry.center,
                              child: Image.asset(
                                IconPath.navCalendar,
                                color: AppColors.accentNormal,
                              ),
                            ),
                            title: Text(
                              'Date',
                              style: getTextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: AppColors.primaryDeepBlueNormal,
                              ),
                            ),
                            subtitle: Text(
                              "Sunday,Sept 28",
                              style: getTextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.secondaryInfoMediumGrayNormal,
                              ),
                            ),
                          ),
                        ),

                        // time
                        Expanded(
                          child: ListTile(
                            leading: Container(
                              height: 42.h,
                              width: 42.h,
                              padding: EdgeInsets.all(7.w),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFFE8F8F6),
                              ),
                              alignment: AlignmentGeometry.center,
                              child: Image.asset(
                                IconPath.clock,
                                color: AppColors.secondaryTealNormal,
                              ),
                            ),
                            title: Text(
                              'Time',
                              style: getTextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: AppColors.primaryDeepBlueNormal,
                              ),
                            ),
                            subtitle: Text(
                              "10:00 AM",
                              style: getTextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.secondaryInfoMediumGrayNormal,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Attendees and payment method
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // attendees
                        Expanded(
                          child: ListTile(
                            leading: Container(
                              height: 42.h,
                              width: 42.h,
                              padding: EdgeInsets.all(7.w),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFFF0F1F2),
                              ),
                              alignment: AlignmentGeometry.center,
                              child: Image.asset(
                                IconPath.people,
                                color: AppColors.bodyDarkGray,
                              ),
                            ),
                            title: Text(
                              'Attendees',
                              style: getTextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: AppColors.primaryDeepBlueNormal,
                              ),
                            ),
                            subtitle: Text(
                              "1 Guest",
                              style: getTextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.secondaryInfoMediumGrayNormal,
                              ),
                            ),
                          ),
                        ),

                        // time
                        Expanded(
                          child: ListTile(
                            leading: Container(
                              height: 42.h,
                              width: 42.h,
                              padding: EdgeInsets.all(7.w),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFFF0F1F2),
                              ),
                              alignment: AlignmentGeometry.center,
                              child: Image.asset(
                                IconPath.mobile,
                                color: AppColors.bodyDarkGray,
                              ),
                            ),
                            title: Text(
                              'Stripe',
                              style: getTextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: AppColors.primaryDeepBlueNormal,
                              ),
                            ),
                            subtitle: Text(
                              "****4252",
                              style: getTextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.secondaryInfoMediumGrayNormal,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    Divider(
                      color: Color(0xFFD1D3D8),
                    ).paddingSymmetric(horizontal: 20.w),

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
                    ).paddingSymmetric(horizontal: 20.w),
                  ],
                ),
              ).paddingSymmetric(horizontal: 10.w),

              30.verticalSpace,

              // what next
              Align(
                alignment: AlignmentGeometry.centerLeft,
                child: Text(
                  "What's Next?",
                  style: getTextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.bodyDarkGray,
                  ),
                ),
              ).paddingSymmetric(horizontal: 20.w),

              10.verticalSpace,

              Row(
                children: [
                  Container(
                    height: 42.h,
                    width: 42.h,
                    padding: EdgeInsets.all(7.w),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primaryDeepBlueLight,
                    ),
                    alignment: AlignmentGeometry.center,
                    child: Image.asset(
                      IconPath.directBox,
                      color: AppColors.primaryDeepBlueNormal,
                    ),
                  ),

                  10.horizontalSpace,

                  Expanded(
                    child: Text(
                      "A confirmation email & receipt have been sent tojohn@example.com",
                      style: getTextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ).paddingSymmetric(horizontal: 20.w),

              10.verticalSpace,

              Row(
                children: [
                  Container(
                    height: 42.h,
                    width: 42.h,
                    padding: EdgeInsets.all(7.w),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFE8F8F6),
                    ),
                    alignment: AlignmentGeometry.center,
                    child: Image.asset(
                      IconPath.clock,
                      color: AppColors.secondaryTealNormal,
                    ),
                  ),

                  10.horizontalSpace,

                  Expanded(
                    child: Text(
                      "Your host will contact you24 hours beforethe event with final details.",
                      style: getTextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ).paddingSymmetric(horizontal: 20.w),

              30.verticalSpace,

              CustomPrimaryButton(
                text: 'View Booking Details',
                color: AppColors.primaryDeepBlueNormal,
                onPressed: () => AppHelperFunctions.navigateToScreen(context, BookingDetailsScreen()),
              ).paddingSymmetric(horizontal: 20.w),

              30.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
