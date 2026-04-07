import 'package:sireenshaban/core/common/styles/global_text_style.dart';
import 'package:sireenshaban/core/common/widgets/custom_loading.dart';
import 'package:sireenshaban/core/common/widgets/custom_primary_button.dart';
import 'package:sireenshaban/core/services/storage_service.dart';
import 'package:sireenshaban/core/utils/constants/colors.dart';
import 'package:sireenshaban/features/authentication/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sireenshaban/features/select_role/controller/select_role_controller.dart';
import 'package:sireenshaban/routes/app_routes.dart';

import '../../../../core/common/widgets/IField.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  final controller = Get.put(LoginController());
  final selectRoleController = Get.find<SelectRoleController>();

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    widget.controller.emailController.dispose();
    widget.controller.passwordController.dispose();
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'Log In',
          style: getTextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: AppColors.secondaryInfoMediumGray,
          ),
        ),
      ),

      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 35),

                        Text(
                          'Email',
                          style: getTextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: AppColors.bodyDarkGray,
                          ),
                        ),

                        const SizedBox(height: 5),

                        IField(
                          controller: widget.controller.emailController,
                          hintText: "Enter your email",
                          keyboardType: TextInputType.emailAddress,
                          filled: true,
                          hintTextStyle: getTextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.secondaryInfoMediumGray,
                          ),
                          fillColour: AppColors.primaryDeepBlueLight,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Email is required";
                            }
                            if (!value.contains("@")) {
                              return "Enter a valid email";
                            }
                            return null;
                          },
                          overrideValidator: true,
                        ),

                        const SizedBox(height: 20),

                        Text(
                          'Password',
                          style: getTextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: AppColors.bodyDarkGray,
                          ),
                        ),

                        const SizedBox(height: 5),

                        Obx(() {
                          return IField(
                            controller: widget.controller.passwordController,
                            hintText: "Enter your password",
                            keyboardType: TextInputType.emailAddress,
                            filled: true,
                            hintTextStyle: getTextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.secondaryInfoMediumGray,
                            ),
                            fillColour: AppColors.primaryDeepBlueLight,
                            obscureText: widget.controller.isObscure.value,
                            suffixIcon: InkWell(
                              onTap: widget.controller.togglePasswordVisibility,
                              child: Icon(
                                widget.controller.isObscure.value
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                size: 18,
                              ),
                            ),
                          );
                        }),

                        const SizedBox(height: 40),

                        Obx(() {
                          if (widget.controller.isLogInLoading.value) {
                            return CustomLoading();
                          }
                          return CustomPrimaryButton(
                            text: 'Log In',
                            color: AppColors.primaryDeepBlueNormal,
                            height: 56,
                            fontSize: 16,
                            onPressed: () {
                              widget.controller.login();
                            },
                          );
                        }),

                        const SizedBox(height: 16),

                        Align(
                          alignment: Alignment.center,
                          child: TextButton(
                            onPressed: () =>
                                Get.toNamed(AppRoute.forgetPasswordScreen),
                            child: Text(
                              'Forgot Password?',
                              style: getTextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppColors.primaryDeepBlueNormal,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ).paddingSymmetric(horizontal: 20),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () => Get.toNamed(AppRoute.signUpScreen),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Do not have an account?',
                                style: getTextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.bodyDarkGray,
                                ),
                              ),
                              Text(
                                '  Sign Up',
                                style: getTextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.primaryDeepBlueNormal,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextButton(
                          onPressed: () async {
                            await StorageService.setGuestMode(true);
                            await StorageService.saveToken(
                              '81|sBLBykoZP1FBoZvDRYhmyoy0NTqNnmArHOJJT4wO4effd95a',
                              '0',
                            );
                            await StorageService.initSecure();
                            await StorageService.saveRole('Customer');
                            Get.offAllNamed(AppRoute.customerBottomNavBar);
                          },
                          child: Text(
                            'Continue as Guest',
                            style: getTextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.secondaryInfoMediumGrayNormal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
