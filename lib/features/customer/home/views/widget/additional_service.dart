import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sireenshaban/features/customer/home/controller/home_controller.dart';

import '../../../../../core/common/styles/global_text_style.dart';
import '../../../../../core/utils/constants/colors.dart';
import '../../../../../core/utils/constants/image_path.dart';
import 'additional_service_card.dart';

class AdditionalService extends StatelessWidget {
  const AdditionalService({super.key, required this.controller});

  final HomeController controller;

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
          return SizedBox(
            height: controller.isAdditionalServicesClose.value
                ? 380.h
                : 120.h,
            child: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Column(
                children: [
                  // 1st row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AdditionalServiceCard(
                        img: ImagePath.doctorImg,
                        title: 'Doctors',
                        onPressed: () {},
                      ),
                      AdditionalServiceCard(
                        img: ImagePath.salonImg,
                        title: 'Salons',
                        onPressed: () {},
                      ),
                      AdditionalServiceCard(
                        img: ImagePath.restaurantImg,
                        title: 'Restaurants',
                        onPressed: () {},
                      ),
                    ],
                  ).paddingSymmetric(horizontal: 20.w),

                  20.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AdditionalServiceCard(
                        img: ImagePath.doctorImg,
                        title: 'Doctors',
                        onPressed: () {},
                      ),
                      AdditionalServiceCard(
                        img: ImagePath.salonImg,
                        title: 'Salons',
                        onPressed: () {},
                      ),
                      AdditionalServiceCard(
                        img: ImagePath.restaurantImg,
                        title: 'Restaurants',
                        onPressed: () {},
                      ),
                    ],
                  ).paddingSymmetric(horizontal: 20.w),
                  20.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AdditionalServiceCard(
                        img: ImagePath.doctorImg,
                        title: 'Doctors',
                        onPressed: () {},
                      ),
                      AdditionalServiceCard(
                        img: ImagePath.salonImg,
                        title: 'Salons',
                        onPressed: () {},
                      ),
                      AdditionalServiceCard(
                        img: ImagePath.restaurantImg,
                        title: 'Restaurants',
                        onPressed: () {},
                      ),
                    ],
                  ).paddingSymmetric(horizontal: 20.w),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }
}
