// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
                fontSize: 18.sp,
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
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryDeepBlueNormal,
                    ),
                  ),

                  8.horizontalSpace,

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
        ).paddingSymmetric(horizontal: 20.w),

        26.verticalSpace,

        // additional services
        Obx(() {
          return Container(
            height: controller.isAdditionalServicesClose.value ? 456.h : 120.h,
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: AppColors.primaryDeepBlueLight),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              children: [
                controller.isAdditionalServicesClose.value
                    ? 20.verticalSpace
                    : 0.verticalSpace,
                // search bar
                controller.isAdditionalServicesClose.value
                    ? IField(
                        controller: additionalSearchController,
                        borderColor: AppColors.primaryDeepBlueLight,
                        filled: true,
                        fillColour: AppColors.softGray,
                        hintText: 'Search services provider',
                        hintTextStyle: getTextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),

                        suffixIcon: IconButton(
                          onPressed: () {},
                          icon: Image.asset(
                            IconPath.navSearch,
                            height: 24.h,
                            color: Colors.grey.shade800,
                          ),
                        ),
                      )
                    : SizedBox(),

                8.verticalSpace,

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
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(color: Color(0xFFE9EAEC)),
                              ),
                            ),
                            child: AdditionalServiceCard(
                              img: item.image ?? '',
                              title: item.name,
                              isHorizontal: true,
                              onPressed: () => AppHelperFunctions.navigateToScreen(
                                context,
                                VendorsScreen(categorySlug: item.slug),
                              ),// not used since GestureDetector handles tap
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
                            onPressed: () => AppHelperFunctions.navigateToScreen(
                              context,
                              VendorsScreen(
                                categorySlug: e.slug,
                              ),
                            ),
                          ).paddingOnly(right: 15.r);
                        }).toList(),
                      ),
                    ),
                  ),
              ],
            ),
          ).paddingSymmetric(horizontal: 20.w);
        }),
      ],
    );
  }
}
