import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sireenshaban/core/services/storage_service.dart';
import 'package:sireenshaban/features/customer/customer_bottom_nav_bar/controller/customer_bottom_nav_bar_controller.dart';
import 'package:sireenshaban/features/customer/home/controller/home_controller.dart';
import 'package:sireenshaban/features/vendor/vendor_bottom_nav_bar/controller/vendor_bottom_nav_bar_controller.dart';
import 'dart:io';
import '../../controller/vendor_edit_profile_controller.dart';
import 'package:sireenshaban/core/common/widgets/IField.dart';
import 'package:sireenshaban/core/common/widgets/custom_primary_button.dart';

import '../../../../../core/common/styles/global_text_style.dart';
import '../../../../../core/utils/constants/colors.dart';
import '../../../../../core/utils/constants/icon_path.dart';
import '../../../../../routes/app_routes.dart';

class VendorEditProfileScreen extends StatefulWidget {
  const VendorEditProfileScreen({super.key});

  @override
  State<VendorEditProfileScreen> createState() =>
      _VendorEditProfileScreenState();
}

class _VendorEditProfileScreenState extends State<VendorEditProfileScreen> {
  final VendorEditProfileController controller = Get.put(
    VendorEditProfileController(),
  );
  final HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    super.initState();

    // Prefill controllers from stored profile (if available)
    final profile = StorageService.userProfile;
    controller.firstNameController.text =
        StorageService.firstName ?? controller.firstNameController.text;
    controller.lastNameController.text =
        StorageService.lastName ?? controller.lastNameController.text;
    controller.countryController.text =
        profile?['country'] ?? controller.countryController.text;
    controller.cityController.text =
        StorageService.city ?? controller.cityController.text;
    controller.addressController.text =
        StorageService.address ?? controller.addressController.text;
    controller.serviceController.text =
        profile?['service'] ??
        profile?['business_name'] ??
        controller.serviceController.text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F4F4),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Edit Profile',
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
            /// 🔹 Cover Image
            Container(
              height: 180.h,
              width: double.infinity,
              color: Colors.transparent,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  /// 🔹 COVER BACKGROUND (SAME COLOR)
                  Obx(() {
                    final img = controller.coverImage.value;
                    return Container(
                      height: 180.h,
                      width: double.infinity,
                      decoration: img != null
                          ? BoxDecoration(
                              image: DecorationImage(
                                image: FileImage(File(img.path)),
                                fit: BoxFit.cover,
                              ),
                            )
                          : BoxDecoration(color: Color(0xFFF3F6FB)),
                    );
                  }),

                  /// 🔹 COVER CAMERA ICON (TOP CENTER)
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: EdgeInsets.only(top: 32.h),
                        child: GestureDetector(
                          onTap: controller.pickCoverImageFromGallery,
                          child: Container(
                            height: 44.h,
                            width: 44.w,
                            alignment: Alignment.center, // 👈 direct center
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(color: Colors.black12, blurRadius: 6),
                              ],
                            ),
                            child: Icon(
                              Icons.camera_alt,
                              size: 20.sp,
                              color: AppColors.primaryDeepBlueNormal,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  /// 🔹 PROFILE AVATAR (SAME BACKGROUND, CIRCLE)
                  Positioned(
                    bottom: -50.h,
                    left: 16.w,
                    child: GestureDetector(
                      onTap: controller.pickProfileImageFromGallery,
                      child: Obx(() {
                        final img = controller.profileImage.value;
                        return Container(
                          height: 120.h,
                          width: 120.w,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFFF3F6FB), // 👈 SAME AS COVER
                            border: Border.all(color: Colors.white, width: 6),
                            image: img != null
                                ? DecorationImage(
                                    image: FileImage(File(img.path)),
                                    fit: BoxFit.cover,
                                  )
                                : null,
                          ),
                          child: img == null
                              ? Container(
                                  height: 36.h,
                                  width: 36.w,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 4,
                                      ),
                                    ],
                                  ),
                                  child: Icon(
                                    Icons.camera_alt,
                                    size: 20.sp,
                                    color: AppColors.primaryDeepBlueNormal,
                                  ),
                                )
                              : null,
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),

            64.verticalSpace,
            // first name
            Text(
              'First Name',
              style: getTextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.primaryDeepBlueNormal,
              ),
            ),

            5.verticalSpace,

            // first name text field
            IField(
              controller: controller.firstNameController,
              hintText: StorageService.firstName ?? 'First Name',
              filled: true,
              fillColour: Colors.white,
              borderColor: Color(0xFFEBEBEB),
            ),

            15.verticalSpace,

            // last name
            Text(
              'Last Name',
              style: getTextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.primaryDeepBlueNormal,
              ),
            ),

            5.verticalSpace,

            // first name text field
            IField(
              controller: controller.lastNameController,
              hintText: StorageService.lastName ?? 'Last Name',
              filled: true,
              fillColour: Colors.white,
              borderColor: Color(0xFFEBEBEB),
            ),

            15.verticalSpace,

            // first name
            // Text(
            //   'Email',
            //   style: getTextStyle(
            //     fontSize: 12.sp,
            //     fontWeight: FontWeight.w500,
            //     color: AppColors.primaryDeepBlueNormal,
            //   ),
            // ),

            // 5.verticalSpace,

            // // first name text field
            // IField(
            //   controller: emailController,
            //   hintText: 'Email',
            //   filled: true,
            //   fillColour: Colors.white,
            //   borderColor: Color(0xFFEBEBEB),
            // ),

            // 15.verticalSpace,

            // first name
            Text(
              'Country',
              style: getTextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.primaryDeepBlueNormal,
              ),
            ),

            5.verticalSpace,

            // first name text field
            IField(
              controller: controller.countryController,
              hintText: StorageService.userProfile?['country'] ?? 'Country',
              filled: true,
              fillColour: Colors.white,
              borderColor: Color(0xFFEBEBEB),
            ),

            15.verticalSpace,

            // first name
            Text(
              'City',
              style: getTextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.primaryDeepBlueNormal,
              ),
            ),

            5.verticalSpace,

            // first name text field
            IField(
              controller: controller.cityController,
              hintText: StorageService.city ?? 'City',
              filled: true,
              fillColour: Colors.white,
              borderColor: Color(0xFFEBEBEB),
            ),

            15.verticalSpace,

            // first name
            Text(
              'Address',
              style: getTextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.primaryDeepBlueNormal,
              ),
            ),

            5.verticalSpace,

            // first name text field
            IField(
              controller: controller.addressController,
              hintText: StorageService.address ?? 'Address',
              filled: true,
              fillColour: Colors.white,
              borderColor: Color(0xFFEBEBEB),
            ),

            15.verticalSpace,

            // first name
            // Text(
            //   'Service/Business Category',
            //   style: getTextStyle(
            //     fontSize: 12.sp,
            //     fontWeight: FontWeight.w500,
            //     color: AppColors.primaryDeepBlueNormal,
            //   ),
            // ),

            // 5.verticalSpace,

            // // first name text field
            // IField(
            //   controller: serviceController,
            //   hintText: 'Service/Business Category',
            //   filled: true,
            //   fillColour: Colors.white,
            //   borderColor: Color(0xFFEBEBEB),
            // ),

            // 15.verticalSpace,
            20.verticalSpace,

            Obx(() {
              final loading = controller.isSubmitLoading.value;
              return CustomPrimaryButton(
                text: loading ? 'Saving...' : 'Save Change',
                color: AppColors.primaryDeepBlueNormal,
                isLoading: loading,
                onPressed: () async {
                  //for vendor update profile
                  if (loading) return;
                  await controller.updateVendorProfile();

                  if (controller.issuccess.value) {
                    final role = StorageService.role?.toLowerCase();
                    final isVendor =
                        controller.homeController.isFromVendor ||
                        role == 'vendor';
                    if (isVendor) {
                      final navController =
                          Get.isRegistered<VendorBottomNavBarController>()
                          ? Get.find<VendorBottomNavBarController>()
                          : Get.put(VendorBottomNavBarController());
                      navController.changeCurrentIndex(4);
                      navController.jumpToScreen(4);
                      Get.offAllNamed(AppRoute.getVendorBottomNavBar());
                    } else {
                      final navController =
                          Get.isRegistered<CustomerBottomNavBarController>()
                          ? Get.find<CustomerBottomNavBarController>()
                          : Get.put(CustomerBottomNavBarController());
                      navController.changeCurrentIndex(4);
                      navController.jumpToScreen(4);
                      Get.offAllNamed(AppRoute.getCustomerBottomNavBar());
                    }
                  }
                  // // for customer update profile

                  // // if (loading) return;
                  // final success = await controller.updateProfile();

                  // if (success) {
                  //   if (homeController.isFromVendor == false) {
                  //     final navController =
                  //         Get.isRegistered<VendorBottomNavBarController>()
                  //         ? Get.find<VendorBottomNavBarController>()
                  //         : Get.put(VendorBottomNavBarController());
                  //     navController.changeCurrentIndex(4);
                  //     navController.jumpToScreen(4);
                  //     Get.offAllNamed(AppRoute.getVendorBottomNavBar());
                  //   } else {
                  //     final navController =
                  //         Get.isRegistered<CustomerBottomNavBarController>()
                  //         ? Get.find<CustomerBottomNavBarController>()
                  //         : Get.put(CustomerBottomNavBarController());
                  //     navController.changeCurrentIndex(4);
                  //     navController.jumpToScreen(4);
                  //     Get.offAllNamed(AppRoute.getCustomerBottomNavBar());
                  //   }
                  // }
                },
              );
            }),

            30.verticalSpace,
          ],
        ).paddingSymmetric(horizontal: 20.w),
      ),
    );
  }
}
