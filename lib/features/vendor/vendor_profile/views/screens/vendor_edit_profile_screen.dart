import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sireenshaban/core/common/widgets/IField.dart';
import 'package:sireenshaban/core/common/widgets/custom_primary_button.dart';

import '../../../../../core/common/styles/global_text_style.dart';
import '../../../../../core/utils/constants/colors.dart';
import '../../../../../core/utils/constants/icon_path.dart';
import '../../../../../routes/app_routes.dart';

class VendorEditProfileScreen extends StatefulWidget {
  const VendorEditProfileScreen({super.key});


  @override
  State<VendorEditProfileScreen> createState() => _VendorEditProfileScreenState();
}

class _VendorEditProfileScreenState extends State<VendorEditProfileScreen> {

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController serviceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    firstNameController.text = 'Sara';
    lastNameController.text = 'Nim';
    emailController.text = 'abc@gmail.com';
    countryController.text = 'USA';
    cityController.text = 'New York';
    addressController.text = '456 Market Street';
    serviceController.text = 'Photographer';
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
            30.verticalSpace,
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
              controller: firstNameController,
              hintText: 'First Name',
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
              controller: lastNameController,
              hintText: 'Last Name',
              filled: true,
              fillColour: Colors.white,
              borderColor: Color(0xFFEBEBEB),
            ),

            15.verticalSpace,


            // first name
            Text(
              'Email',
              style: getTextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.primaryDeepBlueNormal,
              ),
            ),

            5.verticalSpace,

            // first name text field
            IField(
              controller: emailController,
              hintText: 'Email',
              filled: true,
              fillColour: Colors.white,
              borderColor: Color(0xFFEBEBEB),
            ),

            15.verticalSpace,

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
              controller: countryController,
              hintText: 'Country',
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
              controller: cityController,
              hintText: 'City',
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
              controller: addressController,
              hintText: 'Address',
              filled: true,
              fillColour: Colors.white,
              borderColor: Color(0xFFEBEBEB),
            ),

            15.verticalSpace,


            // first name
            Text(
              'Service/Business Category',
              style: getTextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.primaryDeepBlueNormal,
              ),
            ),

            5.verticalSpace,

            // first name text field
            IField(
              controller: serviceController,
              hintText: 'Service/Business Category',
              filled: true,
              fillColour: Colors.white,
              borderColor: Color(0xFFEBEBEB),
            ),

            15.verticalSpace,


            20.verticalSpace,

            CustomPrimaryButton(text: "Save Change", color: AppColors.primaryDeepBlueNormal, onPressed: (){}),

            30.verticalSpace,
          ],
        ).paddingSymmetric(horizontal: 20.w),
      ),
    );
  }
}
