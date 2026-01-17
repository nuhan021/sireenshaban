import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sireenshaban/core/common/widgets/custom_loading.dart';
import 'package:sireenshaban/core/common/widgets/custom_primary_button.dart';
import 'package:sireenshaban/core/utils/helpers/app_helper.dart';
import 'package:sireenshaban/features/customer/confirm_booking/views/controller/confirm_booking_controller.dart';
import 'package:sireenshaban/features/customer/confirm_booking/views/screens/select_time_and_date_screen.dart';
import 'package:sireenshaban/features/customer/confirm_booking/views/widgets/booking_summary.dart';
import 'package:sireenshaban/features/customer/confirm_booking/views/widgets/package_booking_payment_method.dart';
import 'package:sireenshaban/features/customer/confirm_booking/views/widgets/special_concern.dart';

import '../../../../../core/common/styles/global_text_style.dart';
import '../../../../../core/utils/constants/colors.dart';
import '../../../home/model/packages_model.dart';
import '../../../package_booking/views/widgets/booking_app_bar.dart';
import '../../../package_booking/views/widgets/thumbnail_image.dart';

class ConfirmBookingScreen extends StatelessWidget {
  ConfirmBookingScreen({super.key, required this.data});

  final Datum data;

  final ConfirmBookingController confirmBookingController = Get.put(
    ConfirmBookingController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Color(0xFFF4F4F4),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: BookingAppBar(),
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // thumbnail image
            ThumbnailImage(
              image: data.image ?? '',
              rating: data.reviewsSumRating,
              reviews: data.reviews.length,
            ),

            30.verticalSpace,

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // title and price
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        data.title,
                        overflow: TextOverflow.ellipsis,
                        style: getTextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.bodyDarkGray,
                        ),
                      ),
                    ),

                    Container(
                      height: 40.h,
                      padding: EdgeInsets.symmetric(
                        vertical: 8.h,
                        horizontal: 7.w,
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xFFDDE1ED),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "${data.pricePerEvent}/per event",
                        style: getTextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryDeepBlueNormal,
                        ),
                      ),
                    ),
                  ],
                ).paddingSymmetric(horizontal: 10.w),

                30.verticalSpace,

                // booking slot
                CustomPrimaryButton(
                  text: "Select Date & Time",
                  textColor: AppColors.bodyDarkGray,
                  color: AppColors.accentNormal,
                  onPressed: () => AppHelperFunctions.navigateToScreen(
                    context,
                    SelectTimeAndDateScreen(
                      availableDates: data.availableDates,
                      serviceDuration: data.duration,
                    ),
                  ),
                ).paddingSymmetric(horizontal: 10.w),

                30.verticalSpace,

                // payment methods
                Text(
                  "Payment Methods",
                  style: getTextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.bodyDarkGray,
                  ),
                ).paddingSymmetric(horizontal: 10.w),

                20.verticalSpace,

                PackageBookingPaymentMethod(),

                30.verticalSpace,

                // special concerns
                SpecialConcern(),

                30.verticalSpace,

                // booking summary
                BookingSummary(price: data.pricePerEvent),

                30.verticalSpace,

                // confirm booking button
                Obx(() {
                  if (confirmBookingController.isConfirmBookingLoading.value) {
                    return CustomLoading();
                  }
                  return CustomPrimaryButton(
                    text: "Confirm Booking",
                    textColor: AppColors.cardBackgroundSoftGray,
                    color: AppColors.primaryDeepBlueNormal,
                    onPressed: () {
                      // AppHelperFunctions.navigateToScreen(
                      //   context,
                      //   BookingConfirmedScreen(),
                      // );

                      confirmBookingController.confirmBooking(
                        context: context,
                        datum: data,
                        totalPrice: double.parse(data.pricePerEvent),
                      );
                    },
                  );
                }),

                20.verticalSpace,

                // cancel button
                Align(
                  alignment: AlignmentGeometry.center,
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Cancel',
                      style: getTextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.accentNormal,
                      ),
                    ),
                  ),
                ),

                30.verticalSpace,
              ],
            ).paddingSymmetric(horizontal: 10.w),
          ],
        ),
      ),
    );
  }
}
