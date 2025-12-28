import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sireenshaban/core/utils/logging/logger.dart';
import 'package:sireenshaban/features/vendor/vendor_setup/views/widgets/business_hours.dart';
import 'package:sireenshaban/features/vendor/vendor_setup/views/widgets/service_type.dart';
import 'package:sireenshaban/features/vendor/vendor_setup/views/widgets/team_size.dart';
import 'package:sireenshaban/features/vendor/vendor_setup/views/widgets/virtual_meeting.dart';

import '../../../../../core/common/styles/global_text_style.dart';
import '../../../../../core/common/widgets/IField.dart';
import '../../../../../core/utils/constants/colors.dart';
import '../../../../../core/utils/constants/enums.dart';
import '../../controller/vendor_setup_screen_controller.dart';
import '../../../../customer/interest/categori_model.dart';

class VendorSetupPage2nd extends StatelessWidget {
  const VendorSetupPage2nd({
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
            'Business setup:',
            style: getTextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Color(0xFFF97316),
            ),
          ),

          10.verticalSpace,

          // business name
          Text(
            'Service/Business Name',
            style: getTextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.primaryDeepBlueNormal,
            ),
          ),

          5.verticalSpace,

          // first name text field
          IField(
            controller: vendorSetupScreenController.businessNameController,
            hintText: 'Your business name',
            filled: true,
            fillColour: Colors.white,
            borderColor: Color(0xFFEBEBEB),
          ),

          15.verticalSpace,

          Text(
            'Select Account Type',
            style: getTextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.primaryDeepBlueNormal,
            ),
          ),

          5.verticalSpace,

          Obx(() {
            return PopupMenuButton<ServicesGroup>(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
              onSelected: (ServicesGroup value) {
                HapticFeedback.heavyImpact();
                vendorSetupScreenController.selectedServiceGroup.value = value;
              },
              itemBuilder: (context) {
                return ServicesGroup.values.map((ServicesGroup group) {
                  return PopupMenuItem<ServicesGroup>(
                    value: group,
                    child: Text(
                      vendorSetupScreenController.getServiceGroupName(group),
                      style: getTextStyle(
                        fontSize: 14.sp,
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
                  border: Border.all(color: const Color(0xFFEBEBEB)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      vendorSetupScreenController.getServiceGroupName(
                        vendorSetupScreenController.selectedServiceGroup.value,
                      ),
                      style: getTextStyle(
                        fontSize: 14.sp,
                        color: AppColors.bodyDarkGray,
                      ),
                    ),
                    const Icon(Icons.keyboard_arrow_down_sharp, color: AppColors.bodyDarkGray),
                  ],
                ),
              ),
            );
          }),

          20.verticalSpace,

          // business category
          Text(
            'Service/Business Category',
            style: getTextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.primaryDeepBlueNormal,
            ),
          ),

          5.verticalSpace,
          Obx(() {
            if (vendorSetupScreenController.isCategoriLoading.value) {
              return const SizedBox(
                height: 50,
                child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
              );
            }

            final List<Datum> categories =
                vendorSetupScreenController.categoriModel.value?.data ?? [];

            return PopupMenuButton<dynamic>(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              onSelected: (value) {
                final selectedDatum = value as Datum;

                HapticFeedback.heavyImpact();
                vendorSetupScreenController.selectedCategoryId.value =
                    selectedDatum.id;
                vendorSetupScreenController.selectedCategoryName.value =
                    selectedDatum.name;

                AppLoggerHelper.info(selectedDatum.id.toString());
              },
              itemBuilder: (context) {
                return categories.map((Datum item) {
                  return PopupMenuItem<dynamic>(
                    value: item,
                    child: Text(
                      item.name,
                      style: getTextStyle(
                        fontSize: 14.sp,
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
                  border: Border.all(color: const Color(0xFFEBEBEB)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      vendorSetupScreenController.selectedCategoryName.value,
                      style: getTextStyle(
                        fontSize: 14.sp,
                        color: AppColors.bodyDarkGray,
                      ),
                    ),
                    const Icon(
                      Icons.keyboard_arrow_down_sharp,
                      color: AppColors.bodyDarkGray,
                    ),
                  ],
                ),
              ),
            );
          }),

          20.verticalSpace,

          // business hours
          Text(
            'Your Business Hours',
            style: getTextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.primaryDeepBlueNormal,
            ),
          ),

          5.verticalSpace,

          BusinessHours(
            vendorSetupScreenController: vendorSetupScreenController,
          ),

          20.verticalSpace,

          // service type
          Text(
            'Service Type',
            style: getTextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.primaryDeepBlueNormal,
            ),
          ),

          5.verticalSpace,
          ServiceType(controller: vendorSetupScreenController),

          20.verticalSpace,

          // virtual meeting
          VirtualMeeting(controller: vendorSetupScreenController),

          20.verticalSpace,

          // service type
          Text(
            'What\' our team size?',
            style: getTextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.primaryDeepBlueNormal,
            ),
          ),

          5.verticalSpace,

          TeamSize(controller: vendorSetupScreenController),
        ],
      ).paddingSymmetric(horizontal: 20.w),
    );
  }
}
