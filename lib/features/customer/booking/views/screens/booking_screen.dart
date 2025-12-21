import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sireenshaban/features/customer/booking/views/screens/user_booking_details_screen.dart';

import '../../../../../core/common/styles/global_text_style.dart';
import '../../../../../core/utils/constants/colors.dart';
import '../../../../../core/utils/constants/icon_path.dart';
import '../../../../../core/utils/helpers/app_helper.dart';
import '../../../../../routes/app_routes.dart';
import '../../../../vendor/vendor_home/model/vendor_booking_model.dart';
import '../../../home/controller/home_controller.dart';

class BookingScreen extends StatelessWidget {
  BookingScreen({super.key});

  final HomeController controller = Get.find<HomeController>();

  List<Datum> get completedBookings {
    return controller.bookings.value?.data.where((booking) =>
    booking.status.toLowerCase() == 'completed'
    ).toList() ?? [];
  }

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

      body: Obx(() {
        if (controller.isBookingLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        // --- 2. Handle Error State ---
        if (controller.isBookingError.value) {
          return Center(
            child: IconButton(
              onPressed: () => controller.getBooking(),
              icon: const Icon(Icons.refresh),
            ),
          );
        }

        if (controller.bookings.value!.data.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.event_busy, size: 50.sp, color: Colors.grey),
                10.verticalSpace,
                Text(
                  "No schedules for this date",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // title and short by (filter)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Booking List',
                  style: getTextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryDeepBlueNormal,
                  ),
                ),

                Container(
                  height: 35.h,
                  padding: EdgeInsets.symmetric(horizontal: 7.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusGeometry.circular(4.r),
                    border: Border.all(color: AppColors.primaryDeepBlueNormal),
                  ),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Short by',
                        style: getTextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.primaryDeepBlueNormal,
                        ),
                      ),

                      Icon(Icons.keyboard_arrow_down_rounded),
                    ],
                  ),
                ),
              ],
            ),

            10.verticalSpace,

            Text(
              'In Progress',
              style: getTextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryDeepBlueNormal,
              ),
            ),

            12.verticalSpace,

            // actual data
            Expanded(
              child: ListView.separated(
                itemCount: completedBookings.length,
                separatorBuilder: (context, index) => 10.verticalSpace,
                itemBuilder: (context, index) {
                  final item = completedBookings[index];
                  return Container(
                    height: 140.h,
                    width: double.maxFinite,
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 12.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.cardBackgroundSoftGray,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // 1st
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              item.package?.title ??
                                  item.event?.title ??
                                  'No Title',
                              style: getTextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.secondaryInfoMediumGrayNormal,
                              ),
                            ),

                            // Text(
                            //   'Thursday',
                            //   style: getTextStyle(
                            //     fontSize: 12.sp,
                            //     fontWeight: FontWeight.w400,
                            //     color: AppColors.secondaryInfoMediumGrayNormal,
                            //   ),
                            // ),
                          ],
                        ),

                        // 2nd
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              item.user.phoneNumber ?? 'No Phone Number',
                              style: getTextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: AppColors.secondaryInfoMediumGrayNormal,
                              ),
                            ),

                            Text(
                              "${item.date.day}-${item.date.month}-${item.date.year}",
                              style: getTextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: AppColors.secondaryInfoMediumGrayNormal,
                              ),
                            ),
                          ],
                        ),

                        // 3rd
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total Cost: ${item.total}\$',
                              style: getTextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: AppColors.secondaryInfoMediumGrayNormal,
                              ),
                            ),

                            Text(
                              'At - ${item.time}',
                              style: getTextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: AppColors.secondaryInfoMediumGrayNormal,
                              ),
                            ),
                          ],
                        ),

                        Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Text(
                                    'Booking Status:',
                                    style: getTextStyle(
                                      fontSize: 11.sp,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors
                                          .secondaryInfoMediumGrayNormal,
                                    ),
                                  ),

                                  5.horizontalSpace,

                                  Text(
                                    item.status ?? 'pending',
                                    style: getTextStyle(
                                      fontSize: 11.sp,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.success,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            GestureDetector(
                              onTap: () => AppHelperFunctions.navigateToScreen(
                                context,
                                UserBookingDetailsScreen(data: item,),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    'Booking Details',
                                    style: getTextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.primaryDeepBlueNormal,
                                    ),
                                  ),

                                  5.horizontalSpace,

                                  Image.asset(
                                    IconPath.arrowForword,
                                    height: 16.h,
                                    color: AppColors.primaryDeepBlueNormal,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            
            30.verticalSpace,
          ],
        ).paddingSymmetric(horizontal: 20.w);
      }),
    );
  }
}
