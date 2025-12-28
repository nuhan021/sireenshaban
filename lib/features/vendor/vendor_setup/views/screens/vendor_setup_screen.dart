import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sireenshaban/core/utils/constants/colors.dart';
import 'package:sireenshaban/core/utils/constants/icon_path.dart';
import 'package:sireenshaban/features/vendor/vendor_profile_info/views/controller/vendor_profile_info_map_controller.dart';
import 'package:sireenshaban/features/vendor/vendor_setup/controller/vendor_setup_screen_controller.dart';
import 'package:sireenshaban/features/vendor/vendor_setup/views/widgets/vendor_setup_page_1st.dart';
import 'package:sireenshaban/features/vendor/vendor_setup/views/widgets/vendor_setup_page_2nd.dart';
import 'package:sireenshaban/features/vendor/vendor_setup/views/widgets/vendor_setup_page_3rd.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../core/common/styles/global_text_style.dart';
import '../../../../../core/common/widgets/IField.dart';
import '../../../../../routes/app_routes.dart';

class VendorSetupScreen extends StatelessWidget {
  VendorSetupScreen({super.key});

  final VendorSetupScreenController vendorSetupScreenController = Get.put(
    VendorSetupScreenController(),
  );

  final VendorProfileInfoMapController vendorProfileInfoMapController = Get.put(
    VendorProfileInfoMapController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F4F4),
      body: Obx(() {
        if (vendorSetupScreenController.isCategoriLoading.value) {
          return Center(
            child: LoadingAnimationWidget.dotsTriangle(
              color: AppColors.primaryDeepBlueNormal,
              size: 25.h,
            ),
          );
        }

        if (vendorSetupScreenController.isCategoriError.value) {
          return Center(
            child: IconButton(
              onPressed: () {
                vendorSetupScreenController.getCategory();
              },
              icon: Icon(Icons.refresh),
            ),
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // thumbnail image and profile
            SizedBox(
              height: 260.h,
              width: double.maxFinite,
              child: Stack(
                children: [
                  // thumbnail
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10.r),
                      bottomRight: Radius.circular(10.r),
                    ),
                    child: Obx(() {
                      return Container(
                        height: 225.h,
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          color: AppColors.primaryDeepBlueLight,
                          image:
                              vendorSetupScreenController.coverImage.value !=
                                  null
                              ? DecorationImage(
                                  fit: BoxFit.cover,
                                  image: FileImage(
                                    File(
                                      vendorSetupScreenController
                                          .coverImage
                                          .value!
                                          .path,
                                    ),
                                  ),
                                )
                              : null,
                        ),
                        child: Center(
                          child: IconButton(
                            onPressed: () {
                              HapticFeedback.lightImpact();
                              vendorSetupScreenController
                                  .pickCoverImageFromGalary();
                            },
                            icon: Icon(
                              IconlyLight.camera,
                              color: AppColors.primaryDeepBlueActive,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 20.w,
                    child: Obx(() {
                      return CircleAvatar(
                        radius: 60.r,
                        backgroundColor: AppColors.primaryDeepBlueActive,
                        backgroundImage:
                            vendorSetupScreenController.profileImage.value !=
                                null
                            ? FileImage(
                                File(
                                  vendorSetupScreenController
                                      .profileImage
                                      .value!
                                      .path,
                                ),
                              )
                            : null,
                        child: Center(
                          child: IconButton(
                            onPressed: () {
                              HapticFeedback.lightImpact();
                              vendorSetupScreenController
                                  .pickProfileImageFromGalary();
                            },
                            icon: Icon(
                              IconlyLight.camera,
                              color: AppColors.primaryDeepBlueLight,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),

            // ------------------------------------ Vendor Info -----------------------------------------
            Expanded(
              child: PageView(
                controller: vendorSetupScreenController.pageController,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  VendorSetupPage1st(
                    vendorSetupScreenController: vendorSetupScreenController,
                  ),
                  VendorSetupPage2nd(
                    vendorSetupScreenController: vendorSetupScreenController,
                  ),
                  VendorSetupPage3rd(
                    vendorSetupScreenController: vendorSetupScreenController,
                  ),
                ],
              ),
            ),

            10.verticalSpace,

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // previous
                GestureDetector(
                  onTap: () {
                    vendorSetupScreenController.goBack();
                  },
                  child: Container(
                    height: 32.h,
                    width: 82.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Obx(() {
                          return Icon(
                            Icons.arrow_back_ios,
                            size: 16,
                            color:
                                vendorSetupScreenController
                                        .currentPageIndex
                                        .value ==
                                    0
                                ? Color(0xFF33333333)
                                : AppColors.bodyDarkGray,
                          );
                        }),
                        7.horizontalSpace,
                        Obx(() {
                          return Text(
                            'Pre',
                            style: getTextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color:
                                  vendorSetupScreenController
                                          .currentPageIndex
                                          .value ==
                                      0
                                  ? Color(0xFF33333333)
                                  : AppColors.bodyDarkGray,
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),

                // indicator
                SmoothPageIndicator(
                  controller: vendorSetupScreenController.pageController,
                  count: 3,
                  effect: WormEffect(
                    dotColor: Colors.grey,
                    activeDotColor: AppColors.accentNormal,
                    dotHeight: 10,
                    dotWidth: 10,
                  ),
                ),

                // next
                GestureDetector(
                  onTap: () => vendorSetupScreenController.goNext(),
                  child: Container(
                    height: 32.h,
                    width: 82.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Obx(() {
                          return Text(
                            'Next',
                            style: getTextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color:
                                  vendorSetupScreenController
                                          .currentPageIndex
                                          .value ==
                                      2
                                  ? Color(0xFF33333333)
                                  : AppColors.bodyDarkGray,
                            ),
                          );
                        }),
                        7.horizontalSpace,
                        Obx(() {
                          return Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 16,
                            color:
                                vendorSetupScreenController
                                        .currentPageIndex
                                        .value ==
                                    2
                                ? Color(0xFF33333333)
                                : AppColors.bodyDarkGray,
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ],
            ).paddingSymmetric(horizontal: 20.w),

            15.verticalSpace,
          ],
        );
      }),
    );
  }
}
