import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sireenshaban/core/common/widgets/custom_loading.dart';
import 'package:sireenshaban/core/common/widgets/custom_primary_button.dart';
import 'package:sireenshaban/core/utils/logging/logger.dart';
import 'package:sireenshaban/features/customer/confirm_booking/views/widgets/package_booking_payment_method.dart';

import '../../../../../core/common/styles/global_text_style.dart';
import '../../../../../core/utils/constants/colors.dart';
import '../../controller/vendor_setup_screen_controller.dart';

class VendorSetupPage3rd extends StatelessWidget {
  const VendorSetupPage3rd({
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
            'Payment Setup',
            style: getTextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFFF97316),
            ),
          ),

          10.verticalSpace,

          // payment
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Price Type',
                      style: getTextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primaryDeepBlueNormal,
                      ),
                    ),

                    5.verticalSpace,
                    Obx(() {
                      return PopupMenuButton(
                        onSelected: (value) {
                          HapticFeedback.heavyImpact();
                          vendorSetupScreenController.priceType.value = value
                              .toString();
                        },

                        itemBuilder: (context) {
                          return vendorSetupScreenController.priceTypeList.map((
                            item,
                          ) {
                            return PopupMenuItem(
                              value: item,
                              child: Text(
                                item,
                                style: getTextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.primaryDeepBlueNormal,
                                ),
                              ),
                            );
                          }).toList();
                        },

                        child: Container(
                          width: double.maxFinite,
                          height: 50.h,
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          decoration: BoxDecoration(
                            color: AppColors.primaryDeepBlueLight,
                            borderRadius: BorderRadius.circular(4.r),
                            border: Border.all(color: const Color(0xFFE5E5E5)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(vendorSetupScreenController.priceType.value),
                              const Icon(Icons.keyboard_arrow_down_sharp),
                            ],
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),

              18.horizontalSpace,

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start, // Align label left
                  children: [
                    Text(
                      'Travel Fee',
                      style: getTextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primaryDeepBlueNormal,
                      ),
                    ),

                    5.verticalSpace,
                    Container(
                      width: double.maxFinite,
                      height: 50.h,
                      decoration: BoxDecoration(
                        color: AppColors.primaryDeepBlueLight,
                        borderRadius: BorderRadius.circular(4.r),
                        border: Border.all(color: const Color(0xFFE5E5E5)),
                      ),

                      child: TextField(
                        controller:
                            vendorSetupScreenController.travelFeeController,
                        style: getTextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.bodyDarkGray,
                        ),
                        keyboardType: const TextInputType.numberWithOptions(),
                        decoration: InputDecoration(
                          hintText: '100',
                          hintStyle: getTextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w800,
                            color: AppColors.secondaryInfoMediumGrayNormal,
                          ),
                          border: InputBorder.none,
                          disabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),

                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),

                          suffixIcon: const Icon(Icons.attach_money_rounded),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          15.verticalSpace,

          // Maximum Travel Distance
          Text(
            'Maximum Travel Distance',
            style: getTextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.primaryDeepBlueNormal,
            ),
          ),

          5.verticalSpace,
          Obx(() {
            return PopupMenuButton(
              onSelected: (value) {
                HapticFeedback.heavyImpact();
                vendorSetupScreenController.travelDistance.value = value
                    .toString();
              },

              itemBuilder: (context) {
                return vendorSetupScreenController.travelDistanceList.map((
                  item,
                ) {
                  return PopupMenuItem(
                    value: item,
                    child: Text(
                      item,
                      style: getTextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primaryDeepBlueNormal,
                      ),
                    ),
                  );
                }).toList();
              },

              child: Container(
                width: double.maxFinite,
                height: 50.h,
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(vendorSetupScreenController.travelDistance.value),
                    const Icon(Icons.keyboard_arrow_down_sharp),
                  ],
                ),
              ),
            );
          }),

          15.verticalSpace,

          // Maximum Travel Distance
          Text(
            'Travel & Fee Policy (optional)',
            style: getTextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.primaryDeepBlueNormal,
            ),
          ),

          5.verticalSpace,

          Container(
            width: double.maxFinite,
            height: 110.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
            ),

            child: TextField(
              controller: vendorSetupScreenController.travelFeePolicyController,
              maxLines: 5,
              style: getTextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.bodyDarkGray,
              ),
              decoration: InputDecoration(
                hintText: 'Your travel policy',
                hintStyle: getTextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w800,
                  color: AppColors.secondaryInfoMediumGrayNormal,
                ),
                border: InputBorder.none,
                disabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),

                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
              ),
            ),
          ),

          15.verticalSpace,

          // payment method
          Text(
            'Payment Method',
            style: getTextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.primaryDeepBlueNormal,
            ),
          ),

          5.verticalSpace,

          PackageBookingPaymentMethod(),

          20.verticalSpace,

          Obx(() {
            if (vendorSetupScreenController.isSubmitLoading.value) {
              return CustomLoading();
            }
            return CustomPrimaryButton(
              text: 'Submit',
              color: AppColors.primaryDeepBlueNormal,
              onPressed: () => vendorSetupScreenController.submit(),
            );
          }),
          20.verticalSpace,
        ],
      ).paddingSymmetric(horizontal: 20.w),
    );
  }
}
