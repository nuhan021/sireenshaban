import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sireenshaban/core/utils/helpers/app_helper.dart';
import 'package:sireenshaban/features/customer/booking/views/screens/booking_screen.dart';
import 'package:sireenshaban/features/customer/payment_history/views/screens/payment_history_screen.dart';
import 'package:sireenshaban/features/customer/user_profile/views/screens/user_profile_screen.dart';

import '../../../../../core/common/styles/global_text_style.dart';
import '../../../../../core/utils/constants/colors.dart';
import '../../../../../core/utils/constants/icon_path.dart';
import '../../../../../routes/app_routes.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F4F4),
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'Profile',
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            40.verticalSpace,

            // avatar, name, location
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // avatar
                  ClipRRect(
                    borderRadius: BorderRadiusGeometry.circular(100.r),
                    child: CachedNetworkImage(
                      imageUrl:
                          "https://cdn-images.dzcdn.net/images/cover/2489db20eecbc62b9a6e03ac76471f91/0x1900-000000-80-0-0.jpg",
                      fit: BoxFit.cover,
                      height: 125.h,
                      width: 125.w,
                      placeholder: (context, url) => Center(
                        child: LoadingAnimationWidget.staggeredDotsWave(
                          color: AppColors.primaryDeepBlueLight,
                          size: 25.h,
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),

                  10.verticalSpace,

                  // name
                  Text(
                    'Sara Nim',
                    style: getTextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryDeepBlueNormal,
                    ),
                  ),

                  // location
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // location icon
                      Icon(
                        Icons.location_on_outlined,
                        color: Color(0xFF5C5C5C),
                      ),
                      5.horizontalSpace,
                      Text(
                        'Radio Colony, Savar',
                        style: getTextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF5C5C5C),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            20.verticalSpace,

            // profile
            GestureDetector(
              onTap: () => AppHelperFunctions.navigateToScreen(
                context,
                UserProfileScreen(),
              ),
              child: Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Color(0xFFEBEBEB))),
                ),
                child: Row(
                  children: [
                    Image.asset(
                      IconPath.navProfile,
                      height: 20.h,
                      color: AppColors.bodyDarkGray,
                    ),
                    10.horizontalSpace,
                    Text(
                      'Profile',
                      style: getTextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.bodyDarkGray,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // notification
            GestureDetector(
              onTap: () {
                Get.toNamed(AppRoute.getNotificationScreen());
              },
              child: Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Color(0xFFEBEBEB))),
                ),
                child: Row(
                  children: [
                    Image.asset(
                      IconPath.notificationOutline,
                      height: 20.h,
                      color: AppColors.bodyDarkGray,
                    ),
                    10.horizontalSpace,
                    Text(
                      'Notification',
                      style: getTextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.bodyDarkGray,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // payment history
            GestureDetector(
              onTap: () => AppHelperFunctions.navigateToScreen(
                context,
                PaymentHistoryScreen(),
              ),
              child: Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Color(0xFFEBEBEB))),
                ),
                child: Row(
                  children: [
                    Image.asset(
                      IconPath.wallet,
                      height: 20.h,
                      color: AppColors.bodyDarkGray,
                    ),
                    10.horizontalSpace,
                    Text(
                      'Payment History',
                      style: getTextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.bodyDarkGray,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // my booking
            GestureDetector(
              onTap: () =>
                  AppHelperFunctions.navigateToScreen(context, BookingScreen()),
              child: Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Color(0xFFEBEBEB))),
                ),
                child: Row(
                  children: [
                    Image.asset(
                      IconPath.ticket,
                      height: 20.h,
                      color: AppColors.bodyDarkGray,
                    ),
                    10.horizontalSpace,
                    Text(
                      'My Booking',
                      style: getTextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.bodyDarkGray,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // logout
            GestureDetector(
              onTap: () => Get.offAllNamed(AppRoute.selectRoleScreen),
              child: Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Color(0xFFEBEBEB))),
                ),
                child: Row(
                  children: [
                    Image.asset(
                      IconPath.logout,
                      height: 20.h,
                      color: AppColors.bodyDarkGray,
                    ),
                    10.horizontalSpace,
                    Text(
                      'Log Out',
                      style: getTextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryDeepBlueNormal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
