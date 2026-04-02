// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sireenshaban/core/common/widgets/IField.dart';
import 'package:sireenshaban/core/utils/constants/icon_path.dart';
import 'package:sireenshaban/features/customer/home/controller/home_controller.dart';
import '../../../../../core/common/styles/global_text_style.dart';
import '../../../../../core/utils/constants/colors.dart';
import '../../../../../core/utils/helpers/app_helper.dart';
import '../../../vendors/views/screens/vendors_screen.dart';
import 'additional_service_card.dart';

class AdditionalService extends StatelessWidget {
  AdditionalService({super.key, required this.controller});

  final HomeController controller;
  TextEditingController additionalSearchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // additional services title and button
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Additional Services',
              style: getTextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.secondaryInfoMediumGrayDarker,
              ),
            ),

            // explore all button
            GestureDetector(
              onTap: () => controller.changeIsAdditionalServicesClose(
                value: !controller.isAdditionalServicesClose.value,
              ),
              child: Row(
                children: [
                  Text(
                    'Explore All',
                    style: getTextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryDeepBlueNormal,
                    ),
                  ),

                  const SizedBox(width: 8),

                  Obx(() {
                    return Icon(
                      controller.isAdditionalServicesClose.value
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down_rounded,
                      color: AppColors.primaryDeepBlueNormal,
                    );
                  }),
                ],
              ),
            ),
          ],
        ).paddingSymmetric(horizontal: 20),

        const SizedBox(height: 26),

        // additional services
        Obx(() {
          return Container(
            height: controller.isAdditionalServicesClose.value ? 456 : 120,
            width: double.maxFinite,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: AppColors.primaryDeepBlueLight),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                controller.isAdditionalServicesClose.value
                    ? const SizedBox(height: 20)
                    : const SizedBox.shrink(),
                // search bar
                controller.isAdditionalServicesClose.value
                    ? IField(
                        controller: additionalSearchController,
                        borderColor: AppColors.primaryDeepBlueLight,
                        filled: true,
                        fillColour: AppColors.softGray,
                        hintText: 'Search services provider',
                        hintTextStyle: getTextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),

                        suffixIcon: IconButton(
                          onPressed: () {},
                          icon: Image.asset(
                            IconPath.navSearch,
                            height: 24,
                            color: Colors.grey.shade800,
                          ),
                        ),
                      )
                    : const SizedBox(),

                const SizedBox(height: 8),

                if (controller.isAdditionalServicesClose.value)
                  // providers list view
                  Expanded(
                    child: ListView.builder(
                      itemCount: controller.categorys.value!.data.length,
                      itemBuilder: (context, index) {
                        final item = controller.categorys.value!.data[index];
                        return GestureDetector(
                          onTap: () => AppHelperFunctions.navigateToScreen(
                            context,
                            VendorsScreen(categorySlug: item.slug),
                          ),
                          child: Container(
                            width: double.maxFinite,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(color: Color(0xFFE9EAEC)),
                              ),
                            ),
                            child: AdditionalServiceCard(
                              img: item.image ?? '',
                              title: item.name,
                              isHorizontal: true,
                              onPressed: () =>
                                  AppHelperFunctions.navigateToScreen(
                                    context,
                                    VendorsScreen(categorySlug: item.slug),
                                  ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                else
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: controller.categorys.value!.data.map((e) {
                          return AdditionalServiceCard(
                            img: e.image ?? '',
                            title: e.name,
                            onPressed: () =>
                                AppHelperFunctions.navigateToScreen(
                                  context,
                                  VendorsScreen(categorySlug: e.slug),
                                ),
                          ).paddingOnly(right: 15);
                        }).toList(),
                      ),
                    ),
                  ),
              ],
            ),
          ).paddingSymmetric(horizontal: 20);
        }),
      ],
    );
  }
}
