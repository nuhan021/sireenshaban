import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sireenshaban/core/common/styles/global_text_style.dart';
import 'package:sireenshaban/core/utils/constants/icon_path.dart';
import 'package:sireenshaban/features/customer/confirm_booking/views/widgets/booking_summary.dart';
import 'package:sireenshaban/features/customer/confirm_booking/views/widgets/package_booking_payment_method.dart';
import 'package:sireenshaban/features/customer/home/controller/home_controller.dart';
import 'package:sireenshaban/features/customer/personal_care_and_education/views/widgets/header.dart';

import '../../../../../core/common/widgets/IField.dart';
import '../../../../../core/common/widgets/custom_primary_button.dart';
import '../../../../../core/utils/constants/colors.dart';
import '../../../../../core/utils/helpers/app_helper.dart';
import '../../../confirm_booking/views/screens/select_time_and_date_screen.dart';
import '../../../home/views/widget/deals_and_promotions.dart';

class PersonalCareAndEducationScreens extends StatelessWidget {
  PersonalCareAndEducationScreens({super.key, required this.image, required this.title, required this.controller});

  final String image;
  final String title;
  final HomeController controller;

  final TextEditingController projectScopeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.arrow_back_outlined, color: Colors.white,)),
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // header
            Header(image: image, title: title),

            40.verticalSpace,

            // deals and promotions
            DealsAndPromotions(controller: controller,),

            40.verticalSpace,

            // select date and time
            // booking slot
            CustomPrimaryButton(
              text: "Select Date & Time",
              textColor: AppColors.bodyDarkGray,
              color: AppColors.accentNormal,
              onPressed: () => AppHelperFunctions.navigateToScreen(
                context,
                SelectTimeAndDateScreen(),
              ),
            ).paddingSymmetric(horizontal: 20.w),

            20.verticalSpace,


            // project details
            Container(
              height: 320.h,
              width: double.maxFinite,
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Color(0xFFE5E5E5)),
                borderRadius: BorderRadius.circular(14.r)
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // title
                  Center(
                    child: Text(
                      'Select Service',
                      style: getTextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.bodyDarkGray,
                      ),
                    ),
                  ),

                  //Service Type
                  Text(
                    'Event Type',
                    style: getTextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.bodyDarkGray,
                    ),
                  ),

                  Container(
                    height: 47.h,
                    width: double.maxFinite,
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: AppColors.primaryDeepBlueLight,
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: Color(0xFFD1D3D8)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Select event type',
                          style: getTextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.secondaryInfoMediumGrayNormal
                          ),
                        ),

                        Icon(Icons.keyboard_arrow_down_sharp, color: Color(0xFFB9C2DB),)
                      ],
                    ),
                  ),

                  // Special Concerns
                  Text(
                    'Special Concerns',
                    style: getTextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.bodyDarkGray,
                    ),
                  ),

                  IField(
                    controller: projectScopeController,
                    maxLine: 5,
                    borderColor: Color(0xFFD1D3D8),
                    filled: true,
                    fillColour: AppColors.primaryDeepBlueLight,
                  ),


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
                  borderRadius: BorderRadius.circular(14.r)
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // title
                  Row(
                    children: [
                      Image.asset(IconPath.userSquare, height: 24.h,),
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
                    'Full Name',
                    style: getTextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.bodyDarkGray,
                    ),
                  ),

                  IField(
                    controller: projectScopeController,
                    borderColor: Color(0xFFD1D3D8),
                    filled: true,
                    fillColour: AppColors.primaryDeepBlueLight,
                    hintText: 'Full Name',
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
                    controller: projectScopeController,
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
                    controller: projectScopeController,
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
                color: AppColors.bodyDarkGray
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
                  color: AppColors.bodyDarkGray
              ),
            ).paddingSymmetric(horizontal: 20.w),

            20.verticalSpace,

            BookingSummary(),


            40.verticalSpace,

            // submit butto
            CustomPrimaryButton(text: 'Send Request for Quote', color: AppColors.primaryDeepBlueNormal, onPressed: (){}).paddingSymmetric(horizontal: 20.w),

            20.verticalSpace,

            Center(
              child: TextButton(onPressed: (){}, child: Text(
                'Cancel',
                style: getTextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.accentNormal
                ),
              )),
            ),

            20.verticalSpace,
          ],
        ),
      ),
    );
  }
}
