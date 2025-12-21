import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sireenshaban/core/common/styles/global_text_style.dart';
import 'package:sireenshaban/core/utils/constants/colors.dart';
import 'package:sireenshaban/core/utils/constants/icon_path.dart';
import 'package:sireenshaban/features/customer/home/controller/home_controller.dart';
import 'package:sireenshaban/features/customer/home/views/widget/deals_and_promotions.dart';
import 'package:sireenshaban/features/customer/stripe/controller/stripe_controller.dart';
import 'package:sireenshaban/features/vendor/vendor_booking_request/views/widgets/booking_request_card.dart';
import 'package:sireenshaban/features/vendor/vendor_home/views/controller/vendor_home_controller.dart';
import 'package:sireenshaban/features/vendor/vendor_profile/views/widgets/vendor_profile_header.dart';

import 'package:sireenshaban/features/vendor/vendor_schedule/views/widgets/vendor_schedule_card.dart';

class VendorHomeScreen extends StatelessWidget {
  VendorHomeScreen({super.key});

  final HomeController controller = Get.put(HomeController(isFromVendor: true));

  // StripeController stripeController = Get.put(StripeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F4F4),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Container(
              height: 40.h,
              width: 40.w,
              padding: EdgeInsets.all(6.w),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF3333331A),
              ),
              child: Image.asset(
                IconPath.notification,
                height: 24.h,
                color: AppColors.cardBackgroundSoftGray,
              ),
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // header
            VendorProfileHeader(
              coverPhoto:
                  "https://cdn.shopify.com/s/files/1/0681/6976/1043/files/connor-ellsworth-y4QxywTWZj8-unsplash_1024x1024.jpg?v=1679340043",
              profilePhoto:
                  "https://images.unsplash.com/photo-1623039497026-00af61471107?ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8Z2lybCUyMGJvZHl8ZW58MHx8MHx8fDA%3D&fm=jpg&q=60&w=3000",
            ),

            // title , work, location
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // stripeController.makePayment(amount: 100, currency: 'usd');
                  },
                  child: Text('Pay'),
                ),
                Text(
                  'Photography',
                  style: getTextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.bodyDarkGray,
                  ),
                ),

                Text(
                  'professional  service',
                  style: getTextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.bodyDarkGray,
                  ),
                ),

                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      color: AppColors.secondaryTealNormal,
                    ),
                    Text(
                      'New York',
                      style: getTextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.secondaryTealNormal,
                      ),
                    ),
                  ],
                ),
              ],
            ).paddingSymmetric(horizontal: 20.w),

            40.verticalSpace,

            // deals and promotions
            Obx(() {
              if (controller.isDealsAndPromotionLoading.value) {
                return Center(
                  child: LoadingAnimationWidget.dotsTriangle(
                    color: AppColors.primaryDeepBlueNormal,
                    size: 25.h,
                  ),
                );
              }

              if (controller.isDealsAndPromotionError.value) {
                return Center(
                  child: IconButton(
                    onPressed: () => controller.getDealsAndPromotions(),
                    icon: Icon(Icons.refresh),
                  ),
                );
              }
              return DealsAndPromotions(
                controller: controller,
                isFromVendorScreen: true,
              );
            }),

            40.verticalSpace,

            // Schedule
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // schedule
                Text(
                  "Schedule",
                  style: getTextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.bodyDarkGray,
                  ),
                ),
                10.verticalSpace,

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Today',
                      style: getTextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryDeepBlueNormal,
                      ),
                    ),

                    Container(
                      height: 40.h,
                      width: 40.w,
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: Color(0xFFE9EAEC),
                        borderRadius: BorderRadius.circular(8.r),
                      ),

                      child: Image.asset(
                        IconPath.calenderMonth,
                        color: AppColors.secondaryInfoMediumGrayNormal,
                      ),
                    ),
                  ],
                ),

                20.verticalSpace,

                for (int i = 0; i < 5; i++)
                  VendorScheduleCard().paddingOnly(bottom: 10.h),
              ],
            ).paddingSymmetric(horizontal: 20.w),

            40.verticalSpace,

            // booking request
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // schedule
                Text(
                  "Booking Request",
                  style: getTextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.bodyDarkGray,
                  ),
                ),
                10.verticalSpace,

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'New',
                      style: getTextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryDeepBlueNormal,
                      ),
                    ),

                    Container(
                      height: 40.h,
                      width: 40.w,
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: Color(0xFFE9EAEC),
                        borderRadius: BorderRadius.circular(8.r),
                      ),

                      child: Image.asset(
                        IconPath.calenderMonth,
                        color: AppColors.secondaryInfoMediumGrayNormal,
                      ),
                    ),
                  ],
                ),

                20.verticalSpace,

                for (int i = 0; i < 5; i++)
                  BookingRequestCard().paddingOnly(bottom: 10.h),
              ],
            ).paddingSymmetric(horizontal: 20.w),
          ],
        ),
      ),
    );
  }
}
