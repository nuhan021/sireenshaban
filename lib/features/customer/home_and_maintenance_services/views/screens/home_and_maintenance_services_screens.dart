import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sireenshaban/core/common/styles/global_text_style.dart';
import 'package:sireenshaban/core/utils/constants/icon_path.dart';
import 'package:sireenshaban/core/utils/logging/logger.dart';
import 'package:sireenshaban/features/customer/business_and_creative_services/controllers/business_and_service_controller.dart';
import 'package:sireenshaban/features/customer/confirm_booking/views/widgets/package_booking_payment_method.dart';
import 'package:sireenshaban/features/customer/home/controller/home_controller.dart';
import 'package:sireenshaban/features/customer/personal_care_and_education/views/widgets/header.dart';
import '../../../../../core/common/widgets/IField.dart';
import '../../../../../core/common/widgets/custom_primary_button.dart';
import '../../../../../core/utils/constants/colors.dart';
import '../../../confirm_booking/views/widgets/booking_summary.dart';

class HomeAndMaintenanceServicesScreens extends StatelessWidget {
  HomeAndMaintenanceServicesScreens({
    super.key,
    required this.image,
    required this.title,
    required this.controller,
    this.vendorId,
    this.latitude,
    this.longitude,
  });

  final String image;
  final String title;
  final HomeController controller;
  final int? vendorId;
  final double? latitude;
  final double? longitude;

  final TextEditingController projectScopeController = TextEditingController();
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
              image: image,
              title: title,
              vendorId: 0,
              vendorName: title,
              vendorAvatar: null,
            ),

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

            // Issue Details
            Container(
              height: 430.h,
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
                  Center(
                    child: Text(
                      'Issue Details',
                      style: getTextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.bodyDarkGray,
                      ),
                    ),
                  ),

                  // Problem Description
                  Text(
                    'Problem Description',
                    style: getTextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.bodyDarkGray,
                    ),
                  ),

                  IField(
                    controller: serviceController.projectDetailsController3,
                    maxLine: 5,
                    borderColor: Color(0xFFD1D3D8),
                    filled: true,
                    fillColour: AppColors.primaryDeepBlueLight,
                  ),

                  // duration (hour)
                  Text(
                    'Add Photo/Video',
                    style: getTextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.bodyDarkGray,
                    ),
                  ),

                  8.verticalSpace,

                  Obx(() {
                    final hasImage =
                        serviceController.selectedImage.value != null;
                    return InkWell(
                      onTap: () => serviceController.onSelectImage(),
                      child: Container(
                        height: 100.h, // Increased height for better preview
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          color: AppColors.primaryDeepBlueLight,
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(color: const Color(0xFFD1D3D8)),
                        ),
                        child: hasImage
                            ? Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8.r),
                                    child: Image.file(
                                      serviceController.selectedImage.value!,
                                      width: double.maxFinite,
                                      height: 100.h,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Positioned(
                                    top: 5,
                                    right: 5,
                                    child: GestureDetector(
                                      onTap: () =>
                                          serviceController.clearImage(),
                                      child: CircleAvatar(
                                        radius: 12.r,
                                        backgroundColor: Colors.red,
                                        child: Icon(
                                          Icons.close,
                                          size: 16.sp,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.camera_alt_outlined,
                                    color: AppColors.bodyDarkGray,
                                  ),
                                  Text(
                                    'Select a photo',
                                    style: getTextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.bodyDarkGray,
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    );
                  }),

                  //Service Type
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
                  //           fontSize: 12.sp,
                  //           fontWeight: FontWeight.w400,
                  //           color: AppColors.secondaryInfoMediumGrayNormal,
                  //         ),
                  //       ),

                  //       Icon(
                  //         Icons.keyboard_arrow_down_sharp,
                  //         color: Color(0xFFB9C2DB),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ).paddingSymmetric(horizontal: 20.w),

            20.verticalSpace,

            // contact details
            Container(
              height: 350.h,
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
                    controller: serviceController.firstNameController3,
                    borderColor: Color(0xFFD1D3D8),
                    filled: true,
                    fillColour: AppColors.primaryDeepBlueLight,
                    hintText: 'First Name',
                  ),
                  // Full Name
                  Text(
                    'last Name',
                    style: getTextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.bodyDarkGray,
                    ),
                  ),

                  IField(
                    controller: serviceController.lastNameController3,
                    borderColor: Color(0xFFD1D3D8),
                    filled: true,
                    fillColour: AppColors.primaryDeepBlueLight,
                    hintText: 'last Name',
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
                    controller: serviceController.phoneController3,
                    borderColor: Color(0xFFD1D3D8),
                    filled: true,
                    fillColour: AppColors.primaryDeepBlueLight,
                    hintText: 'Phone Number',
                  ),

                  //Service Type
                  Text(
                    'Email',
                    style: getTextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.bodyDarkGray,
                    ),
                  ),

                  IField(
                    controller: serviceController.emailController3,
                    borderColor: Color(0xFFD1D3D8),
                    filled: true,
                    fillColour: AppColors.primaryDeepBlueLight,
                    hintText: 'email',
                  ),
                ],
              ),
            ).paddingSymmetric(horizontal: 20.w),

            40.verticalSpace,

            // package booking
            Text(
              'Payment Method',
              style: getTextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.bodyDarkGray,
              ),
            ).paddingSymmetric(horizontal: 20.w),

            15.verticalSpace,

            PackageBookingPaymentMethod().paddingSymmetric(horizontal: 20.w),

            40.verticalSpace,

            // booking summary
            Text(
              'Booking Summary',
              style: getTextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.bodyDarkGray,
              ),
            ).paddingSymmetric(horizontal: 20.w),

            20.verticalSpace,

            BookingSummary(),

            40.verticalSpace,

            // submit butto
            CustomPrimaryButton(
              text: 'Send Request for Quote',
              color: AppColors.primaryDeepBlueNormal,
              onPressed: () {
                serviceController.sendServiceRequest(
                  vendorId: vendorId!,
                  latitude: latitude,
                  longitude: longitude,
                  email: serviceController.emailController3,
                  firstName: serviceController.firstNameController3,
                  lastName: serviceController.lastNameController3,
                  phone: serviceController.phoneController3,
                  projectDetails: serviceController.projectDetailsController3,
                //  image: serviceController.selectedImage.value,
                );
              },
            ).paddingSymmetric(horizontal: 20.w),

            Center(
              child: TextButton(
                onPressed: () {},
                child: Text(
                  'Cancel',
                  style: getTextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.accentNormal,
                  ),
                ),
              ),
            ),

            20.verticalSpace,
          ],
        ),
      ),
    );
  }
}
