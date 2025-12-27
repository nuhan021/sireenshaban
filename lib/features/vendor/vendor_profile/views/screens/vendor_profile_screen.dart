import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sireenshaban/core/services/storage_service.dart';
import 'package:sireenshaban/features/customer/home/controller/home_controller.dart';
import 'package:sireenshaban/features/vendor/vendor_profile/views/screens/vendor_user_profile_screen.dart';
import 'package:sireenshaban/features/vendor/vendor_profile/views/widgets/vendor_profile_header.dart';

import '../../../../../core/common/styles/global_text_style.dart';
import '../../../../../core/controllers/user_controller.dart';
import '../../../../../core/utils/constants/colors.dart';
import '../../../../../core/utils/constants/icon_path.dart';
import '../../../../../core/utils/helpers/app_helper.dart';
import '../../../../../routes/app_routes.dart';
import '../../../../customer/booking/views/screens/booking_screen.dart';
import '../../../../customer/payment_history/views/screens/payment_history_screen.dart';

class VendorProfileScreen extends StatelessWidget {
  VendorProfileScreen({super.key});

  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Color(0xFFF9FAFB),

      body: Obx(() {
        if (homeController.isFromVendor == false) {
          return Center(child: CircularProgressIndicator());
        }

        final userCtrl = homeController.vendorUser.value!.vendor.user;
        return SingleChildScrollView(
          child: Column(
            children: [
              VendorProfileHeader(
                coverPhoto: homeController
                    .vendorUser
                    .value!
                    .vendor
                    .user
                    .backgroundImage,
                profilePhoto:
                homeController.vendorUser.value!.vendor.user.image,
              ),

              // name

              Text(
                '${userCtrl.firstName} ${userCtrl.lastName}',
                style: getTextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.bodyDarkGray,
                ),
              ),


              Text(
                homeController.vendorUser.value!.vendor.categoryName,
                style: getTextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.bodyDarkGray,
                ),
              ),

              10.verticalSpace,

              // location
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // location icon
                  Icon(
                    Icons.location_on_outlined,
                    color: AppColors.secondaryAquaNormal,
                  ),
                  5.horizontalSpace,
                  Text(
                    '${userCtrl.country}, ${userCtrl.city}',
                    style: getTextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.secondaryAquaNormal,
                    ),
                  ),
                ],
              ),


              20.verticalSpace,

              // profile
              GestureDetector(
                onTap: () => AppHelperFunctions.navigateToScreen(
                  context,
                  VendorUserProfileScreen(),
                ),
                child: Container(
                  height: 65.h,
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Color(0xFFEBEBEB)),
                    ),
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
                  height: 65.h,
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Color(0xFFEBEBEB)),
                    ),
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
                  height: 65.h,
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Color(0xFFEBEBEB)),
                    ),
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

              // Completed booking
              GestureDetector(
                onTap: () => AppHelperFunctions.navigateToScreen(
                  context,
                  BookingScreen(),
                ),
                child: Container(
                  height: 65.h,
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Color(0xFFEBEBEB)),
                    ),
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
                        'Completed Booking',
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
                onTap: () {
                  StorageService.logoutUser();
                  Get.offAllNamed(AppRoute.selectRoleScreen);
                },
                child: Container(
                  height: 65.h,
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Color(0xFFEBEBEB)),
                    ),
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
        );
      }),
    );
  }
}