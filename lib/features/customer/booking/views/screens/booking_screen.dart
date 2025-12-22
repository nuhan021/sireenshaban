import 'package:flutter/foundation.dart';
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

  // Get all bookings (not just completed)
  List<Datum> get allBookings {
    if (controller.bookings.value == null) {
      debugPrint('📋 [BookingScreen] bookings.value is NULL');
      return [];
    }
    debugPrint('📋 [BookingScreen] Total bookings: ${controller.bookings.value!.data.length}');
    for (var booking in controller.bookings.value!.data) {
      debugPrint('   📌 ID: ${booking.id}, Status: "${booking.status}", Date: ${booking.date}');
    }
    return controller.bookings.value!.data;
  }

  // Filter for in-progress bookings (not completed)
  List<Datum> get inProgressBookings {
    if (controller.bookings.value == null) {
      return [];
    }
    final filtered = controller.bookings.value!.data
        .where((booking) => booking.status.toLowerCase() != 'completed')
        .toList();
    debugPrint('📋 [BookingScreen] In-progress bookings: ${filtered.length}');
    return filtered;
  }

  // Filter for completed bookings only
  List<Datum> get completedBookings {
    if (controller.bookings.value == null) {
      return [];
    }
    final filtered = controller.bookings.value!.data
        .where((booking) => booking.status.toLowerCase() == 'completed')
        .toList();
    debugPrint('📋 [BookingScreen] Completed bookings: ${filtered.length}');
    return filtered;
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
        debugPrint('📋 [BookingScreen] ========== BUILD ==========');
        debugPrint('📋 [BookingScreen] isBookingLoading: ${controller.isBookingLoading.value}');
        debugPrint('📋 [BookingScreen] isBookingError: ${controller.isBookingError.value}');
        debugPrint('📋 [BookingScreen] bookings.value is null: ${controller.bookings.value == null}');
        if (controller.bookings.value != null) {
          debugPrint('📋 [BookingScreen] bookings.data.length: ${controller.bookings.value!.data.length}');
        }
        
        if (controller.isBookingLoading.value) {
          debugPrint('📋 [BookingScreen] Showing LOADING state');
          return const Center(child: CircularProgressIndicator());
        }

        // Handle null bookings data
        if (controller.bookings.value == null) {
          debugPrint('📋 [BookingScreen] Showing NULL DATA state (refresh button)');
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () => controller.getBooking(),
                  icon: const Icon(Icons.refresh, size: 40),
                ),
                10.verticalSpace,
                Text('Tap to load bookings'),
              ],
            ),
          );
        }

        // Handle Error State
        if (controller.isBookingError.value) {
          debugPrint('📋 [BookingScreen] Showing ERROR state');
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () => controller.getBooking(),
                  icon: const Icon(Icons.refresh, size: 40),
                ),
                10.verticalSpace,
                Text('Error loading bookings. Tap to retry.'),
              ],
            ),
          );
        }

        if (controller.bookings.value!.data.isEmpty) {
          debugPrint('📋 [BookingScreen] Showing EMPTY state');
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.event_busy, size: 50.sp, color: Colors.grey),
                10.verticalSpace,
                Text(
                  "No bookings found",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          );
        }
        
        debugPrint('📋 [BookingScreen] Showing DATA state with ${allBookings.length} bookings');
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

                // Container(
                //   height: 35.h,
                //   padding: EdgeInsets.symmetric(horizontal: 7.w),
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadiusGeometry.circular(4.r),
                //     border: Border.all(color: AppColors.primaryDeepBlueNormal),
                //   ),

                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       Text(
                //         'Short by',
                //         style: getTextStyle(
                //           fontSize: 12.sp,
                //           fontWeight: FontWeight.w400,
                //           color: AppColors.primaryDeepBlueNormal,
                //         ),
                //       ),

                //       Icon(Icons.keyboard_arrow_down_rounded),
                //     ],
                //   ),
                // ),
              ],
            ),

            10.verticalSpace,

            Text(
              'All Bookings',
              style: getTextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryDeepBlueNormal,
              ),
            ),

            12.verticalSpace,

            // actual data - show ALL bookings for now
            Expanded(
              child: ListView.separated(
                itemCount: allBookings.length,
                separatorBuilder: (context, index) => 10.verticalSpace,
                itemBuilder: (context, index) {
                  final item = allBookings[index];
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
                                    item.status,
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
