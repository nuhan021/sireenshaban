import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sireenshaban/core/common/styles/global_text_style.dart';
import 'package:sireenshaban/core/common/widgets/custom_primary_button.dart';
import 'package:sireenshaban/core/services/storage_service.dart';
import 'package:sireenshaban/core/utils/constants/colors.dart';
import 'package:sireenshaban/core/utils/constants/icon_path.dart';
import 'package:sireenshaban/core/utils/helpers/app_helper.dart';
import 'package:sireenshaban/core/utils/logging/logger.dart';
import 'package:sireenshaban/features/customer/home/controller/home_controller.dart';
import 'package:sireenshaban/features/customer/home/views/widget/community_events.dart';
import 'package:sireenshaban/features/customer/home/views/widget/deals_and_promotions.dart';
import 'package:sireenshaban/features/vendor/create_event/views/screens/create_event_screen.dart';
import 'package:sireenshaban/features/vendor/vendor_profile/views/widgets/vendor_profile_header.dart';

import 'package:sireenshaban/features/vendor/vendor_schedule/views/widgets/vendor_schedule_card.dart';

import '../../../../../routes/app_routes.dart';
import '../../../create_package/view/screens/create_package.dart';

class VendorHomeScreen extends StatelessWidget {
  VendorHomeScreen({super.key});

  final HomeController controller = Get.put(HomeController(isFromVendor: true));

  // StripeController stripeController = Get.put(StripeController());

  @override
  Widget build(BuildContext context) {
    AppLoggerHelper.debug(StorageService.vendorId.toString());

    return RefreshIndicator(
      onRefresh: () async {
        controller.getVendorProfile();
        controller.getDealsAndPromotions();
        controller.getBooking();
        controller.getAdditionalService();
      },
      child: Scaffold(
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
                  color: Color(0xff3333331a),
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

        body: Obx(() {
          if (controller.isVendorProfileLoading.value) {
            return Center(
              child: LoadingAnimationWidget.dotsTriangle(
                color: AppColors.primaryDeepBlueNormal,
                size: 25.h,
              ),
            );
          }

          if (controller.isVendorProfileError.value) {
            return Center(
              child: IconButton(
                onPressed: () => controller.getVendorProfile(),
                icon: Icon(Icons.refresh),
              ),
            );
          }

          if (controller.vendorUser.value == null) {
            return const Center(child: Text("No Vendor Data Found"));
          }
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // header
                VendorProfileHeader(
                  coverPhoto:
                      controller.vendorUser.value!.vendor.user.backgroundImage,
                  profilePhoto: controller.vendorUser.value!.vendor.user.image,
                ),

                // title , work, location
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ElevatedButton(onPressed: (){
                    //   // stripeController.makePayment(amount: 100, currency: 'usd');
                    // }, child: Text('Pay')),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          controller.vendorUser.value!.vendor.businessName,
                          style: getTextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.bodyDarkGray,
                          ),
                        ),

                        _buildSubscriptionBadge(
                          controller
                              .vendorUser
                              .value
                              ?.vendor
                              .user
                              .subscriptionPlanId ?? 1,
                        ),
                      ],
                    ),

                    Text(
                      controller.vendorUser.value!.vendor.categoryName,
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
                          controller.vendorUser.value!.vendor.user.country,
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

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButton(
                      onPressed: () {
                        if (controller
                                    .vendorUser
                                    .value
                                    ?.vendor
                                    .user
                                    .subscriptionPlanId ==
                                null ||
                            controller
                                    .vendorUser
                                    .value
                                    ?.vendor
                                    .user
                                    .subscriptionPlanId ==
                                1) {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.r),
                                ),
                                title: Row(
                                  children: [
                                    Icon(
                                      Icons.stars,
                                      color: Colors.orange,
                                      size: 28.sp,
                                    ),
                                    10.horizontalSpace,
                                    Text(
                                      "Upgrade Required",
                                      style: getTextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                content: Text(
                                  "You are currently on a Free Plan. To access premium vendor features, please upgrade your subscription.",
                                  style: getTextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.grey,
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text(
                                      "Later",
                                      style: getTextStyle(color: Colors.grey),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 150.w,
                                    child: CustomPrimaryButton(
                                      text: 'Upgrade Now',
                                      color: AppColors.primaryDeepBlueNormal,
                                      onPressed: () {
                                        Navigator.pop(context);
                                        Get.toNamed(
                                          AppRoute.subscriptionScreen,
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                          return;
                        }
                        AppHelperFunctions.navigateToScreen(
                          context,
                          CreatePackage(),
                        );
                      },
                      child: Text(
                        '+ Add Promotions',
                        style: getTextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryDeepBlueNormal,
                        ),
                      ),
                    ),

                    TextButton(
                      onPressed: () {
                        AppLoggerHelper.debug('The subscription is: ${controller
                            .vendorUser
                            .value
                            ?.vendor
                            .user
                            .subscriptionPlanId}');
                        if (controller
                                    .vendorUser
                                    .value
                                    ?.vendor
                                    .user
                                    .subscriptionPlanId ==
                                1 ||
                            controller
                                    .vendorUser
                                    .value
                                    ?.vendor
                                    .user
                                    .subscriptionPlanId ==
                                2 ||
                            controller
                                    .vendorUser
                                    .value
                                    ?.vendor
                                    .user
                                    .subscriptionPlanId ==
                                null) {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.r),
                                ),
                                title: Row(
                                  children: [
                                    Icon(
                                      Icons.stars,
                                      color: Colors.orange,
                                      size: 28.sp,
                                    ),
                                    10.horizontalSpace,
                                    Text(
                                      "Upgrade Required",
                                      style: getTextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                content: Text(
                                  "You are currently on a Growth Plan. To access premium vendor features, please upgrade your subscription.",
                                  style: getTextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.grey,
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text(
                                      "Later",
                                      style: getTextStyle(color: Colors.grey),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 150.w,
                                    child: CustomPrimaryButton(
                                      text: 'Upgrade Now',
                                      color: AppColors.primaryDeepBlueNormal,
                                      onPressed: () {
                                        Navigator.pop(context);
                                        Get.toNamed(
                                          AppRoute.subscriptionScreen,
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                          return;
                        }
                        AppHelperFunctions.navigateToScreen(
                          context,
                          CreateEventScreen(),
                        );
                      },
                      child: Text(
                        '+ Add Event',
                        style: getTextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryDeepBlueNormal,
                        ),
                      ),
                    ),
                  ],
                ),

                40.verticalSpace,

                // deals and promotions
                Obx(() {
                  // 1. Check Loading State
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

                  // 3. Check for Empty List (New Condition)
                  // We check if data is null OR if the data list inside is empty
                  final dataList = controller.packages.value?.data;
                  if (dataList == null || dataList.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.inventory_2_outlined,
                            color: Colors.grey,
                            size: 40.h,
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            "No deals or promotions found",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  // 4. Return Data Widget if everything is fine
                  return DealsAndPromotions(
                    controller: controller,
                    isFromVendorScreen: true,
                  );
                }),

                40.verticalSpace,

                // events
                Obx(() {
                  // 1. Check Loading State
                  if (controller.isCommunityEventsLoading.value) {
                    return Center(
                      child: LoadingAnimationWidget.dotsTriangle(
                        color: AppColors.primaryDeepBlueNormal,
                        size: 25.h,
                      ),
                    );
                  }

                  if (controller.isCommunityEventsError.value) {
                    return Center(
                      child: IconButton(
                        onPressed: () => controller.getDealsAndPromotions(),
                        icon: Icon(Icons.refresh),
                      ),
                    );
                  }

                  // 3. Check for Empty List (New Condition)
                  // We check if data is null OR if the data list inside is empty
                  final dataList = controller.communityEvents.value?.data;
                  if (dataList == null || dataList.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.inventory_2_outlined,
                            color: Colors.grey,
                            size: 40.h,
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            "No event found",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  // 4. Return Data Widget if everything is fine
                  return CommunityEvents(
                    controller: controller,
                    isFromVendor: true,
                  );
                }),

                40.verticalSpace,

                // Schedule
                Obx(() {
                  // 1. Check Loading State
                  if (controller.isBookingLoading.value) {
                    return Center(
                      child: LoadingAnimationWidget.dotsTriangle(
                        color: AppColors.primaryDeepBlueNormal,
                        size: 25.h,
                      ),
                    );
                  }

                  // 2. Check Error State
                  if (controller.isBookingError.value) {
                    return Center(
                      child: IconButton(
                        onPressed: () => controller.getBooking(),
                        icon: Icon(Icons.refresh),
                      ),
                    );
                  }

                  // 3. Prepare Filtered Data (Today Only)
                  final now = DateTime.now();
                  final todayBookings =
                      controller.bookings.value?.data.where((booking) {
                        return booking.date.year == now.year &&
                            booking.date.month == now.month &&
                            booking.date.day == now.day;
                      }).toList() ??
                      [];

                  // 4. Check for Empty State
                  if (todayBookings.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.calendar_today_outlined,
                            color: Colors.grey,
                            size: 40.h,
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            "No Today Schedule Found",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  // 5. Success State: Return the Schedule UI
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                              color: const Color(0xFFE9EAEC),
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
                      // Map the filtered list here
                      Column(
                        children: todayBookings.map((e) {
                          return VendorScheduleCard(
                            data: e,
                          ).paddingOnly(bottom: 10.h);
                        }).toList(),
                      ),
                    ],
                  ).paddingSymmetric(horizontal: 20.w);
                }),

                40.verticalSpace,

                // booking request
                // Column(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     // schedule
                //     Text(
                //       "Booking Request",
                //       style: getTextStyle(
                //         fontSize: 22.sp,
                //         fontWeight: FontWeight.w600,
                //         color: AppColors.bodyDarkGray,
                //       ),
                //     ),
                //     10.verticalSpace,
                //
                //     Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       children: [
                //         Text(
                //           'New',
                //           style: getTextStyle(
                //             fontSize: 14.sp,
                //             fontWeight: FontWeight.w600,
                //             color: AppColors.primaryDeepBlueNormal,
                //           ),
                //         ),
                //
                //         Container(
                //           height: 40.h,
                //           width: 40.w,
                //           padding: EdgeInsets.all(8.w),
                //           decoration: BoxDecoration(
                //             color: Color(0xFFE9EAEC),
                //             borderRadius: BorderRadius.circular(8.r),
                //           ),
                //
                //           child: Image.asset(
                //             IconPath.calenderMonth,
                //             color: AppColors.secondaryInfoMediumGrayNormal,
                //           ),
                //         ),
                //       ],
                //     ),
                //
                //     20.verticalSpace,
                //
                //     for (int i = 0; i < 5; i++)
                //       BookingRequestCard().paddingOnly(bottom: 10.h),
                //   ],
                // ).paddingSymmetric(horizontal: 20.w),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildSubscriptionBadge(int subscriptionId) {
    String label;
    Color badgeColor;
    IconData iconData;

    // আইডি অনুযায়ী ডাটা সেট করা
    switch (subscriptionId) {
      case 1:
        label = 'Free';
        badgeColor = Colors.grey;
        iconData = Icons.person_outline;
        break;
      case 2:
        label = 'Premium';
        badgeColor = Colors.orange;
        iconData = Icons.star_rounded;
        break;
      case 3:
        label = 'VIP';
        badgeColor = Colors.purple;
        iconData = Icons.workspace_premium_rounded; // বা Icons.auto_awesome
        break;
      default:
        label = 'Basic';
        badgeColor = AppColors.primaryDeepBlueLight;
        iconData = Icons.info_outline;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: badgeColor.withOpacity(0.12),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: badgeColor.withOpacity(0.5), width: 0.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            iconData,
            size: 12.sp,
            color: badgeColor,
          ),
          4.horizontalSpace,
          Text(
            label,
            style: getTextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.w600,
              color: badgeColor,
            ),
          ),
        ],
      ),
    );
  }
}
