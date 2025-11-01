import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../core/common/styles/global_text_style.dart';
import '../../../../../core/common/widgets/IField.dart';
import '../../../../../core/common/widgets/custom_primary_button.dart';
import '../../../../../core/utils/constants/colors.dart';
import '../../../../../core/utils/constants/icon_path.dart';
import '../../../../../routes/app_routes.dart';

class VendorProfileInfo extends StatefulWidget {
  VendorProfileInfo({super.key});

  @override
  State<VendorProfileInfo> createState() => _VendorProfileInfoState();
}

class _VendorProfileInfoState extends State<VendorProfileInfo> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController retypePasswordController =
      TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    retypePasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F4F4),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Add Profile Info',
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
          children: [
            SizedBox(height: 35.h),

            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Name',
                    style: getTextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.bodyDarkGray,
                    ),
                  ),

                  SizedBox(height: 5.h),

                  IField(
                    controller: nameController,
                    hintText: "First Name",
                    keyboardType: TextInputType.text,
                    filled: true,
                    hintTextStyle: getTextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.secondaryInfoMediumGray,
                    ),
                    fillColour: AppColors.primaryDeepBlueLight,
                  ),

                  SizedBox(height: 20.h),

                  Text(
                    'Last Name',
                    style: getTextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.bodyDarkGray,
                    ),
                  ),

                  SizedBox(height: 5.h),

                  IField(
                    controller: phoneController,
                    hintText: "Enter your phone number",
                    keyboardType: TextInputType.phone,
                    filled: true,
                    hintTextStyle: getTextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.secondaryInfoMediumGray,
                    ),
                    fillColour: AppColors.primaryDeepBlueLight,
                  ),

                  SizedBox(height: 20.h),

                  TextButton(
                    onPressed: () => Get.toNamed(AppRoute.vendorProfileInfoMap),
                    child: Text(
                      'Add location',
                      style: getTextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.warning,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ).paddingSymmetric(horizontal: 20.w),
      ),
    );
  }
}
