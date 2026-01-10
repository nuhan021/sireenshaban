import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sireenshaban/features/vendor/vendor_setup/controller/vendor_setup_screen_controller.dart';

import '../../../../../core/common/styles/global_text_style.dart';
import '../../../../../core/common/widgets/IField.dart';
import '../../../../../core/utils/constants/colors.dart';
import '../../../../../routes/app_routes.dart';

class VendorSetupPage1st extends StatelessWidget {
  const VendorSetupPage1st({
    super.key,
    required this.vendorSetupScreenController,
  });

  final VendorSetupScreenController vendorSetupScreenController;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // title
          Center(
            child: Text(
              'Add Profile Info',
              textAlign: TextAlign.center,
              style: getTextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryDeepBlueNormal,
              ),
            ),
          ),

          25.verticalSpace,

          Text(
            'Personal Info:',
            style: getTextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Color(0xFFF97316),
            ),
          ),

          10.verticalSpace,

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
            controller: vendorSetupScreenController.firstNameController,
            hintText: 'First Name',
            filled: true,
            fillColour: Colors.white,
            borderColor: Color(0xFFEBEBEB),
          ),

          15.verticalSpace,

          // first name
          Text(
            'Last Name',
            style: getTextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.primaryDeepBlueNormal,
            ),
          ),

          5.verticalSpace,

          // lst name
          IField(
            controller: vendorSetupScreenController.lastNameController,
            hintText: 'Last Name',
            filled: true,
            fillColour: Colors.white,
            borderColor: Color(0xFFEBEBEB),
          ),

          15.verticalSpace,

          // Phone Number
          Text(
            'Phone Number',
            style: getTextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.primaryDeepBlueNormal,
            ),
          ),

          5.verticalSpace,

          // phone number
          Row(
            children: [
              CountryCodePicker(
                initialSelection: vendorSetupScreenController.countryCode,
                onChanged: (value) {
                  vendorSetupScreenController.countryCode = value.code!;
                  vendorSetupScreenController.dialCode = value.dialCode!
                      .toString();
                },
              ),
              Expanded(
                child: IField(
                  controller: vendorSetupScreenController.numberController,
                  keyboardType: TextInputType.number,
                  hintText: 'xxx - xxx - xxxx',
                  filled: true,
                  fillColour: Colors.white,
                  borderColor: Color(0xFFEBEBEB),
                ),
              ),
            ],
          ),

          15.verticalSpace,

          // email
          Text(
            'Email',
            style: getTextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.primaryDeepBlueNormal,
            ),
          ),

          5.verticalSpace,

          // email
          IField(
            controller: vendorSetupScreenController.emailController,
            keyboardType: TextInputType.emailAddress,
            hintText: 'xxx12@gmail.com',
            filled: true,
            fillColour: Colors.white,
            borderColor: Color(0xFFEBEBEB),
          ),
          30.verticalSpace,

          // ----------------------- set location ------------------------
          Row(
            children: [
              Expanded(
                child: Text(
                  'Set location',
                  textAlign: TextAlign.start,
                  style: getTextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.accentNormal,
                  ),
                ),
              ),

              GestureDetector(
                onTap: () => Get.toNamed(AppRoute.vendorProfileInfoMap),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 12.h,
                    horizontal: 16.w,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_on_rounded,
                        color: AppColors.accentNormal,
                      ),

                      5.horizontalSpace,

                      Text(
                        'Location',
                        style: getTextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryDeepBlueNormal,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Country
          Text(
            'Country',
            style: getTextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.primaryDeepBlueNormal,
            ),
          ),

          5.verticalSpace,

          // lst name
          IField(
            controller: vendorSetupScreenController.countryController,
            hintText: 'USA',
            filled: true,
            fillColour: Colors.white,
            borderColor: Color(0xFFEBEBEB),
          ),

          15.verticalSpace,

          // City
          Text(
            'City',
            style: getTextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.primaryDeepBlueNormal,
            ),
          ),

          5.verticalSpace,

          // lst name
          IField(
            controller: vendorSetupScreenController.cityController,
            hintText: 'New York',
            filled: true,
            fillColour: Colors.white,
            borderColor: Color(0xFFEBEBEB),
          ),

          15.verticalSpace,

          // road
          Text(
            'Road',
            style: getTextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.primaryDeepBlueNormal,
            ),
          ),

          5.verticalSpace,

          // road
          IField(
            controller: vendorSetupScreenController.roadController,
            hintText: '456 Market Street',
            filled: true,
            fillColour: Colors.white,
            borderColor: Color(0xFFEBEBEB),
          ),

          15.verticalSpace,
        ],
      ).paddingSymmetric(horizontal: 20.w),
    );
  }
}
