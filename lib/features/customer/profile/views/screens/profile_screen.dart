// ignore_for_file: use_full_hex_values_for_flutter_colors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sireenshaban/core/services/storage_service.dart';
import 'package:sireenshaban/core/utils/helpers/app_helper.dart';
import 'package:sireenshaban/features/customer/booking/views/screens/booking_screen.dart';
import 'package:sireenshaban/features/customer/payment_history/views/screens/payment_history_screen.dart';
import 'package:sireenshaban/features/customer/profile/controllers/profile_controller.dart';
import 'package:sireenshaban/features/customer/profile/models/user_model.dart';
import 'package:sireenshaban/features/customer/user_profile/views/screens/user_profile_screen.dart';

import '../../../../../core/common/styles/global_text_style.dart';
import '../../../../../core/utils/constants/colors.dart';
import '../../../../../core/utils/constants/icon_path.dart';
import '../../../../../routes/app_routes.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final ProfileController _profileController = Get.put(ProfileController());

  String _buildLocationText(UserModel user) {
    final parts = <String>[
      if ((user.address ?? '').isNotEmpty) user.address!,
      if ((user.city ?? '').isNotEmpty) user.city!,
      if ((user.country ?? '').isNotEmpty) user.country!,
    ];
    return parts.isNotEmpty ? parts.join(', ') : 'Location not set';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),
      appBar: AppBar(
        backgroundColor: const Color(
          0xFFF4F4F4,
        ), // ব্যাকগ্রাউন্ড কালার অ্যাড করা হয়েছে
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
                color: const Color(0xFF3333331A),
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Image.asset(IconPath.notification, height: 24.h),
            ),
          ),
        ],
      ),
      body: Obx(() {
        if (_profileController.isProfileLoading.value) {
          return Center(
            child: LoadingAnimationWidget.staggeredDotsWave(
              color: AppColors.primaryDeepBlueLight,
              size: 25.h,
            ),
          );
        }

        if (_profileController.isProfileError.value) {
          return Center(
            child: IconButton(
              onPressed: _profileController.getProfile,
              icon: const Icon(
                Icons.refresh,
                color: AppColors.primaryDeepBlueNormal,
              ),
            ),
          );
        }

        final user = _profileController.user.value;
        final imageUrl = user?.image ?? '';
        final fullName = user == null
            ? 'User'
            : '${user.firstName} ${user.lastName}'.trim();
        final locationText = user == null
            ? 'Location not set'
            : _buildLocationText(user);

        // ফিক্সড: একটি SingleChildScrollView বা Column রিটার্ন করা হয়েছে
        return SingleChildScrollView(
          child: Column(
            children: [
              20.verticalSpace,
              // avatar, name, location
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // avatar
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100.r),
                      child: imageUrl.isEmpty
                          ? Image.asset(
                              'assets/images/blank_user.jpg',
                              fit: BoxFit.cover,
                              height: 125.h,
                              width: 125.w,
                            )
                          : CachedNetworkImage(
                              imageUrl: imageUrl,
                              fit: BoxFit.cover,
                              height: 125.h,
                              width: 125.w,
                              placeholder: (context, url) => Center(
                                child:
                                    LoadingAnimationWidget.staggeredDotsWave(
                                  color: AppColors.primaryDeepBlueLight,
                                  size: 25.h,
                                ),
                              ),
                              errorWidget: (context, url, error) => Image.asset(
                                'assets/images/blank_user.jpg',
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                    10.verticalSpace,
                    // name
                    Text(
                      fullName.isEmpty ? 'User' : fullName,
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
                        const Icon(
                          Icons.location_on_outlined,
                          color: Color(0xFF5C5C5C),
                        ),
                        5.horizontalSpace,
                        Text(
                          locationText,
                          style: getTextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF5C5C5C),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              20.verticalSpace,

              // Profile Item
              _buildProfileMenu(
                icon: IconPath.navProfile,
                title: 'Profile',
                onTap: () => AppHelperFunctions.navigateToScreen(
                  context,
                  UserProfileScreen(),
                ),
              ),

              // Notification Item
              _buildProfileMenu(
                icon: IconPath.notificationOutline,
                title: 'Notification',
                onTap: () => Get.toNamed(AppRoute.getNotificationScreen()),
              ),

              // Payment History Item
              _buildProfileMenu(
                icon: IconPath.wallet,
                title: 'Payment History',
                onTap: () => AppHelperFunctions.navigateToScreen(
                  context,
                  PaymentHistoryScreen(),
                ),
              ),

              // My Booking Item
              _buildProfileMenu(
                icon: IconPath.ticket,
                title: 'My Booking',
                onTap: () => AppHelperFunctions.navigateToScreen(
                  context,
                  BookingScreen(),
                ),
              ),

              // Logout Item
              _buildProfileMenu(
                icon: IconPath.logout,
                title: 'Log Out',
                isLogout: true,
                onTap: () {
                  StorageService.logoutUser();
                  Get.offAllNamed(AppRoute.selectRoleScreen);
                },
              ),
            ],
          ).paddingSymmetric(horizontal: 20.w),
        );
      }),
    );
  }

  // কোড ক্লিন রাখার জন্য হেল্পার উইজেট
  Widget _buildProfileMenu({
    required String icon,
    required String title,
    required VoidCallback onTap,
    bool isLogout = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20.h),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Color(0xFFEBEBEB))),
        ),
        child: Row(
          children: [
            Image.asset(
              icon,
              height: 20.h,
              color: isLogout
                  ? AppColors.primaryDeepBlueNormal
                  : AppColors.bodyDarkGray,
            ),
            10.horizontalSpace,
            Text(
              title,
              style: getTextStyle(
                fontSize: 14.sp,
                fontWeight: isLogout ? FontWeight.w600 : FontWeight.w400,
                color: isLogout
                    ? AppColors.primaryDeepBlueNormal
                    : AppColors.bodyDarkGray,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
