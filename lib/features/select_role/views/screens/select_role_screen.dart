import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sireenshaban/core/common/styles/global_text_style.dart';
import 'package:sireenshaban/core/common/widgets/custom_primary_button.dart';
import 'package:sireenshaban/core/utils/constants/colors.dart';
import 'package:sireenshaban/core/utils/constants/enums.dart';
import 'package:sireenshaban/core/utils/constants/icon_path.dart';
import 'package:sireenshaban/core/utils/constants/image_path.dart';
import 'package:sireenshaban/routes/app_routes.dart';

import '../../controller/select_role_controller.dart';

class SelectRoleScreen extends StatelessWidget {
  SelectRoleScreen({super.key});

  final controller = Get.find<SelectRoleController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: constraints.maxHeight * 0.4,
                      ),
                      child: Center(child: Image.asset(ImagePath.selectRole)),
                    ),

                    const SizedBox(height: 10),
                    Text(
                      'Select Your Role',
                      style: getTextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: AppColors.bodyDarkGray,
                      ),
                    ),

                    Text(
                      'Choose a role to get started',
                      style: getTextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColors.secondaryMediumGray,
                      ),
                    ),

                    Obx(() {
                      return GestureDetector(
                        onTap: () => controller.selectRole(userRole: UserRole.vendor),
                        child: Container(
                          height: 72,
                          width: double.maxFinite,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: controller.role.value == UserRole.vendor
                                  ? AppColors.primaryDeepBlueNormal
                                  : Colors.transparent,
                            ),
                          ),
                          child: Center(
                            child: Row(
                              children: [
                                Container(
                                  height: 40,
                                  width: 40,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.primaryDeepBlueNormal,
                                  ),
                                  child: Center(
                                    child: Image.asset(
                                      IconPath.calenderMonth,
                                      height: 20,
                                    ),
                                  ),
                                ),

                                const SizedBox(width: 12),

                                Text(
                                  'Business profile',
                                  style: getTextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.bodyDarkGray,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),

                    Obx(() {
                      return GestureDetector(
                        onTap: () => controller.selectRole(userRole: UserRole.customer),
                        child: Container(
                          height: 72,
                          width: double.maxFinite,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: controller.role.value == UserRole.customer
                                  ? AppColors.primaryDeepBlueNormal
                                  : Colors.transparent,
                            ),
                          ),
                          child: Center(
                            child: Row(
                              children: [
                                Container(
                                  height: 40,
                                  width: 40,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.primaryDeepBlueNormal,
                                  ),
                                  child: Center(
                                    child: Image.asset(IconPath.user, height: 20),
                                  ),
                                ),

                                const SizedBox(width: 12),

                                Text(
                                  'Customer',
                                  style: getTextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.bodyDarkGray,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),

                    const SizedBox(height: 30),

                    CustomPrimaryButton(
                      text: 'Continue',
                      color: AppColors.primaryDeepBlueNormal,
                      height: 56,
                      fontSize: 16,
                      onPressed: () => Get.toNamed(AppRoute.loginScreen),
                    ),

                    const SizedBox(height: 20),
                  ],
                ).paddingSymmetric(horizontal: 20),
              ),
            );
          },
        ),
      ),
    );
  }
}
