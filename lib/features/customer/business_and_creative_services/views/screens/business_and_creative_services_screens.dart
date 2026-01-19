import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sireenshaban/core/common/styles/global_text_style.dart';
import 'package:sireenshaban/core/utils/constants/icon_path.dart';
import 'package:sireenshaban/features/customer/business_and_creative_services/controllers/business_and_service_controller.dart';
import 'package:sireenshaban/features/customer/home/controller/home_controller.dart';
import 'package:sireenshaban/features/customer/personal_care_and_education/views/widgets/header.dart';

import '../../../../../core/common/widgets/IField.dart';
import '../../../../../core/common/widgets/custom_primary_button.dart';
import '../../../../../core/utils/constants/colors.dart';
import '../../../home/views/widget/deals_and_promotions.dart';

class BusinessAndCreativeServicesScreens extends StatelessWidget {
  BusinessAndCreativeServicesScreens({
    super.key,
    required this.image,
    required this.title,
    required this.controller,
    required this.vendorId,
    this.latitude,
    this.longitude,
    this.coverImage,
  });

  final String image;
  final String title;
  final HomeController controller;
  final int vendorId;
  final double? latitude;
  final double? longitude;
  final String? coverImage;

  final BusinessAndServiceController serviceController = Get.put(
    BusinessAndServiceController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_outlined, color: Colors.white),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // header
            Header(
              image: coverImage,
              title: title,
              vendorId: vendorId,
              vendorName: title,
              vendorAvatar: image,
            ),

            40.verticalSpace,

            // deals and promotions
            DealsAndPromotions(controller: controller),

            40.verticalSpace,

            // select date and time
            // booking slot
            // CustomPrimaryButton(
            //   text: "Select Date & Time",
            //   textColor: AppColors.bodyDarkGray,
            //   color: AppColors.accentNormal,
            //   onPressed: () => AppHelperFunctions.navigateToScreen(
            //     context,
            //     SelectTimeAndDateScreen(),
            //   ),
            // ).paddingSymmetric(horizontal: 20.w),
            20.verticalSpace,

            // project details
            Container(
              // height: 385.h,
              width: double.maxFinite,
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Color(0xFFE5E5E5)),
                borderRadius: BorderRadius.circular(14.r),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  // title
                  Center(
                    child: Text(
                      'Project Details',
                      style: getTextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.bodyDarkGray,
                      ),
                    ),
                  ),
                  20.verticalSpace,
                  // project scope
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Project Scope',
                        style: getTextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.bodyDarkGray,
                        ),
                      ),
                      20.verticalSpace,
                      IField(
                        controller: serviceController.projectDetailsController,
                        maxLine: 5,
                        borderColor: Color(0xFFD1D3D8),
                        filled: true,
                        fillColour: AppColors.primaryDeepBlueLight,
                        hintText: 'project scope...',
                      ),
                    ],
                  ),

                  // // duration (hour)
                  // Text(
                  //   'Duration (Hours)',
                  //   style: getTextStyle(
                  //     fontSize: 16.sp,
                  //     fontWeight: FontWeight.w500,
                  //     color: AppColors.bodyDarkGray,
                  //   ),
                  // ),

                  // IField(
                  //   controller: projectScopeController,
                  //   borderColor: Color(0xFFD1D3D8),
                  //   filled: true,
                  //   fillColour: AppColors.primaryDeepBlueLight,
                  //   hintText: 'e.g,, 4',
                  // ),

                  // //Service Type
                  // Text(
                  //   'Service Type',
                  //   style: getTextStyle(
                  //     fontSize: 16.sp,
                  //     fontWeight: FontWeight.w500,
                  //     color: AppColors.bodyDarkGray,
                  //   ),
                  // ),

                  // Container(
                  //   height: 47.h,
                  //   width: double.maxFinite,
                  //   padding: EdgeInsets.all(8.w),
                  //   decoration: BoxDecoration(
                  //     color: AppColors.primaryDeepBlueLight,
                  //     borderRadius: BorderRadius.circular(8.r),
                  //     border: Border.all(color: Color(0xFFD1D3D8)),
                  //   ),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       Text(
                  //         'Select service type',
                  //         style: getTextStyle(
                  //             fontSize: 12.sp,
                  //             fontWeight: FontWeight.w400,
                  //             color: AppColors.secondaryInfoMediumGrayNormal
                  //         ),
                  //       ),

                  //       Icon(Icons.keyboard_arrow_down_sharp, color: Color(0xFFB9C2DB),)
                  //     ],
                  //   ),
                  // )
                ],
              ),
            ).paddingSymmetric(horizontal: 20.w),

            20.verticalSpace,

            // contact details
            Container(
              height: 420.h,
              width: double.maxFinite,
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Color(0xFFE5E5E5)),
                borderRadius: BorderRadius.circular(14.r),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // title
                  Row(
                    children: [
                      Image.asset(IconPath.userSquare, height: 24.h),
                      8.horizontalSpace,
                      Text(
                        'Contact Details',
                        style: getTextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.bodyDarkGray,
                        ),
                      ),
                    ],
                  ),
                  20.verticalSpace,
                  // Full Name
                  Text(
                    'First Name',
                    style: getTextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.bodyDarkGray,
                    ),
                  ),

                  IField(
                    controller: serviceController.firstNameController,
                    borderColor: Color(0xFFD1D3D8),
                    filled: true,
                    fillColour: AppColors.primaryDeepBlueLight,
                    hintText: 'Full Name',
                  ),
                  // Full Name
                  Text(
                    'Last Name',
                    style: getTextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.bodyDarkGray,
                    ),
                  ),

                  IField(
                    controller: serviceController.lastNameController,
                    borderColor: Color(0xFFD1D3D8),
                    filled: true,
                    fillColour: AppColors.primaryDeepBlueLight,
                    hintText: 'Last Name',
                  ),

                  // Phone Number
                  Text(
                    'Phone Number',
                    style: getTextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.bodyDarkGray,
                    ),
                  ),

                  IField(
                    controller: serviceController.phoneController,
                    borderColor: Color(0xFFD1D3D8),
                    filled: true,
                    fillColour: AppColors.primaryDeepBlueLight,
                    hintText: 'Phone Number',
                  ),

                  // Email
                  Text(
                    'Email',
                    style: getTextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.bodyDarkGray,
                    ),
                  ),

                  IField(
                    controller: serviceController.emailController,
                    borderColor: Color(0xFFD1D3D8),
                    filled: true,
                    fillColour: AppColors.primaryDeepBlueLight,
                    hintText: 'Email',
                    readOnly: true,
                  ),
                ],
              ),
            ).paddingSymmetric(horizontal: 20.w),

            // 40.verticalSpace,

            // // package booking
            // Text(
            //   'Payment Method',
            //   style: getTextStyle(
            //     fontSize: 22.sp,
            //     fontWeight: FontWeight.w600,
            //     color: AppColors.bodyDarkGray,
            //   ),
            // ).paddingSymmetric(horizontal: 20.w),
            //
            // 15.verticalSpace,

            // PackageBookingPaymentMethod().paddingSymmetric(horizontal: 20.w),

            // 40.verticalSpace,

            // // booking summary
            // Text(
            //   'Booking Summary',
            //   style: getTextStyle(
            //       fontSize: 22.sp,
            //       fontWeight: FontWeight.w600,
            //       color: AppColors.bodyDarkGray
            //   ),
            // ).paddingSymmetric(horizontal: 20.w),

            // 20.verticalSpace,

            // BookingSummary(),
            20.verticalSpace,

            // submit butto
            Obx(
              () => CustomPrimaryButton(
                text: 'Send Request for Quote',
                color: AppColors.primaryDeepBlueNormal,
                isLoading: serviceController.isSubmitting.value,
                onPressed: () => serviceController.sendServiceRequest(
                  vendorId: vendorId,
                  latitude: latitude,
                  longitude: longitude,
                ),
              ).paddingSymmetric(horizontal: 20.w),
            ),

            20.verticalSpace,

            // Center(
            //   child: TextButton(onPressed: (){}, child: Text(
            //     'Cancel',
            //     style: getTextStyle(
            //         fontSize: 14.sp,
            //         fontWeight: FontWeight.w400,
            //         color: AppColors.accentNormal
            //     ),
            //   )),
            // ),

            // 20.verticalSpace,
          ],
        ),
      ),
    );
  }
}
