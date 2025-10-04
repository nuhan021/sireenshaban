import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../core/common/styles/global_text_style.dart';
import '../../../../core/common/widgets/IField.dart';
import '../../../../core/common/widgets/custom_primary_button.dart';
import '../../../../core/utils/constants/colors.dart';
import '../../../../routes/app_routes.dart';
import '../../controllers/change_password_controller.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});
  
  final controller = Get.put(ChangePasswordController());

  final _formKey = GlobalKey<FormState>();

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController retypePasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () => Get.back(), icon: Icon(Icons.arrow_back)),
        title: Text('Change Password', style: getTextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.secondaryInfoMediumGray
        ),),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            55.verticalSpace,

            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    'New Password',
                    style: getTextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.bodyDarkGray,
                    ),
                  ),

                  SizedBox(height: 5.h),

                  Obx(() {
                    return IField(
                      controller: passwordController,
                      hintText: "Enter your password",
                      keyboardType: TextInputType.emailAddress,
                      filled: true,
                      hintTextStyle: getTextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.secondaryInfoMediumGray,
                      ),
                      fillColour: AppColors.primaryDeepBlueLight,
                      obscureText: controller.isObscurePassword.value,
                      suffixIcon: InkWell(
                        onTap: controller.togglePasswordVisibility,
                        child: Icon(
                          controller.isObscurePassword.value
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          size: 18.w,
                        ),
                      ),
                    );
                  }),

                  SizedBox(height: 20.h),

                  Text(
                    'Confirm Password',
                    style: getTextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.bodyDarkGray,
                    ),
                  ),

                  SizedBox(height: 5.h),

                  Obx(() {
                    return IField(
                      controller: retypePasswordController,
                      hintText: "Enter your password",
                      keyboardType: TextInputType.emailAddress,
                      filled: true,
                      hintTextStyle: getTextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.secondaryInfoMediumGray,
                      ),
                      fillColour: AppColors.primaryDeepBlueLight,
                      obscureText: controller.isObscureRetypePassword.value,
                      suffixIcon: InkWell(
                        onTap: controller.toggleRetypePasswordVisibility,
                        child: Icon(
                          controller.isObscureRetypePassword.value
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          size: 18.w,
                        ),
                      ),
                    );
                  }),


                  30.verticalSpace,

                  CustomPrimaryButton(
                    text: 'Change',
                    color: AppColors.primaryDeepBlueNormal,
                    onPressed: () => Get.offAllNamed(AppRoute.loginScreen),
                  ),
                ],
              ),
            )
          ],
        ).paddingSymmetric(horizontal: 20.w),
      ),
    );
  }
}
