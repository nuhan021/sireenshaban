import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sireenshaban/features/customer/home/controller/home_controller.dart';
import 'package:sireenshaban/core/utils/helpers/app_helper.dart';
import 'package:sireenshaban/features/vendor/vendor_profile/views/screens/vendor_edit_profile_screen.dart';
import '../../../../../core/common/styles/global_text_style.dart';
import '../../../../../core/utils/constants/colors.dart';
import '../../../../../core/utils/constants/icon_path.dart';
import '../../../../../routes/app_routes.dart';

class VendorUserProfileScreen extends StatelessWidget {
  const VendorUserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F4F4),
      appBar: AppBar(
        centerTitle: true,
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
                color: Color(0xff3333331a),
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
          children: [
            // profile header (cover + avatar)
            // VendorProfileHeader(
            //   coverPhoto:
            //       "https://cdn.shopify.com/s/files/1/0681/6976/1043/files/connor-ellsworth-y4QxywTWZj8-unsplash_1024x1024.jpg?v=1679340043",
            //   profilePhoto:
            //       "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTEGUodmPqUNG8wJWNkNCvqiNkr1T9tsft5oQ&s",
            // ),
            12.verticalSpace,

            // edit icon
            Align(
              alignment: AlignmentGeometry.topRight,
              child: GestureDetector(
                onTap: () => AppHelperFunctions.navigateToScreen(
                  context,
                  VendorEditProfileScreen(),
                ),
                child: Image.asset(IconPath.edit, height: 20.h),
              ),
            ),

            10.verticalSpace,

            // first name
            Obx(() {
              final homeController = Get.find<HomeController>();
              final vendorUser = homeController.vendorUser.value?.vendor.user;
              return ListTile(
                tileColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                title: Text(
                  'First Name',
                  style: getTextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryDeepBlueNormal,
                  ),
                ),
                subtitle: Text(
                  vendorUser?.firstName ?? '-',
                  style: getTextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF333333),
                  ),
                ),
              );
            }),

            8.verticalSpace,

            // last name
            Obx(() {
              final homeController = Get.find<HomeController>();
              final vendorUser = homeController.vendorUser.value?.vendor.user;
              return ListTile(
                tileColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                title: Text(
                  'Last Name',
                  style: getTextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryDeepBlueNormal,
                  ),
                ),
                subtitle: Text(
                  vendorUser?.lastName ?? '-',
                  style: getTextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF333333),
                  ),
                ),
              );
            }),

            8.verticalSpace,

            // email
            Obx(() {
              final homeController = Get.find<HomeController>();
              final vendorUser = homeController.vendorUser.value?.vendor.user;
              return ListTile(
                tileColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                title: Text(
                  'Email',
                  style: getTextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryDeepBlueNormal,
                  ),
                ),
                subtitle: Text(
                  vendorUser?.email ?? '-',
                  style: getTextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF333333),
                  ),
                ),
              );
            }),

            8.verticalSpace,
            // city
            Obx(() {
              final homeController = Get.find<HomeController>();
              final vendorUser = homeController.vendorUser.value?.vendor.user;
              return ListTile(
                tileColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                title: Text(
                  'City',
                  style: getTextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryDeepBlueNormal,
                  ),
                ),
                subtitle: Text(
                  vendorUser?.city ?? '-',
                  style: getTextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF333333),
                  ),
                ),
              );
            }),

            8.verticalSpace,

            // Address
            Obx(() {
              final homeController = Get.find<HomeController>();
              final vendorUser = homeController.vendorUser.value?.vendor.user;
              return ListTile(
                tileColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                title: Text(
                  'Address',
                  style: getTextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryDeepBlueNormal,
                  ),
                ),
                subtitle: Text(
                  vendorUser?.address ?? '-',
                  style: getTextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF333333),
                  ),
                ),
              );
            }),

            8.verticalSpace,

            // service/ business category
            // ListTile(
            //   tileColor: Colors.white,
            //   shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.circular(12.r),
            //   ),
            //   title: Text(
            //     'Services/Business Category',
            //     style: getTextStyle(
            //       fontSize: 12.sp,
            //       fontWeight: FontWeight.w500,
            //       color: AppColors.primaryDeepBlueNormal,
            //     ),
            //   ),

            //   subtitle: Text(
            //     'Photographer',
            //     style: getTextStyle(
            //       fontSize: 12.sp,
            //       fontWeight: FontWeight.w400,
            //       color: Color(0xFF333333),
            //     ),
            //   ),
            // ),
          ],
        ).paddingSymmetric(horizontal: 20.w),
      ),
    );
  }
}
