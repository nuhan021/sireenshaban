import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sireenshaban/core/common/widgets/IField.dart';
import 'package:sireenshaban/features/vendor/vendor_booking_request/controller/vendor_booking_request_controller.dart';
import 'package:sireenshaban/features/vendor/vendor_booking_request/model/service_request_model.dart';
import 'package:sireenshaban/features/vendor/vendor_booking_request/views/widgets/client_profile_section.dart';

import '../../../../../core/common/styles/global_text_style.dart';
import '../../../../../core/common/widgets/custom_primary_button.dart';
import '../../../../../core/utils/constants/colors.dart';
import '../../../../../core/utils/constants/icon_path.dart';
import '../../../../../routes/app_routes.dart';

class VendorBookingRequestDetailsScreen extends StatefulWidget {
  const VendorBookingRequestDetailsScreen({
    super.key,
    required this.requestId,
  });

  final int requestId;

  @override
  State<VendorBookingRequestDetailsScreen> createState() =>
      _VendorBookingRequestDetailsScreenState();
}

class _VendorBookingRequestDetailsScreenState
    extends State<VendorBookingRequestDetailsScreen> {
  late final VendorBookingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Get.isRegistered<VendorBookingController>()
        ? Get.find<VendorBookingController>()
        : Get.put(VendorBookingController());
    _controller.getServiceRequestDetails(requestId: widget.requestId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F4F4),
      appBar: AppBar(
        backgroundColor: Color(0xFFF4F4F4),
        title: Text(
          'Booking Request',
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

      body: Obx(() {
        if (_controller.isServiceRequestDetailsLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (_controller.isServiceRequestDetailsError.value ||
            _controller.serviceRequestDetails.value == null) {
          return Center(
            child: Text(
              "Failed to load request details",
              style: getTextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.bodyDarkGray,
              ),
            ),
          );
        }

        final ServiceRequestDetail request =
            _controller.serviceRequestDetails.value!;

        return SingleChildScrollView(
          child: Column(
            children: [
              20.verticalSpace,

              // client profile section
              ClientProfileSection(
                request: request,
              ),

              20.verticalSpace,

              // request details
              Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 20.h),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14.r),
                    color: AppColors.cardBackgroundSoftGray
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Request Details',
                      style: getTextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.bodyDarkGray,
                      ),
                    ),

                    20.verticalSpace,

                    Text(
                      'Project Details',
                      style: getTextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.bodyDarkGray,
                      ),
                    ),

                    12.verticalSpace,

                    Text(
                      request.projectDetails.isEmpty
                          ? "-"
                          : request.projectDetails,
                      textAlign: TextAlign.start,
                      style: getTextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.bodyDarkGray
                      ),
                    ),

                    20.verticalSpace,

                    Row(
                      children: [
                        Text(
                          'Service Type:',
                          style: getTextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.bodyDarkGray,
                          ),
                        ),

                        20.horizontalSpace,

                        Expanded(
                          child: Text(
                            request.serviceType.isEmpty
                                ? "-"
                                : request.serviceType.join(", "),
                            style: getTextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: AppColors.bodyDarkGray
                            ),
                          ),
                        )
                      ],
                    ),

                    10.verticalSpace,

                    Row(
                      children: [
                        Text(
                          'Payment Method:',
                          style: getTextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.bodyDarkGray,
                          ),
                        ),

                        20.horizontalSpace,

                        Text(
                          request.paymentMethod.isEmpty
                              ? "-"
                              : request.paymentMethod,
                          style: getTextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.bodyDarkGray
                          ),
                        )
                      ],
                    ),

                    10.verticalSpace,

                    Row(
                      children: [
                        Text(
                          'Status:',
                          style: getTextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.bodyDarkGray,
                          ),
                        ),

                        20.horizontalSpace,

                        Text(
                          request.status.isEmpty ? "-" : request.status,
                          style: getTextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.bodyDarkGray
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),

            20.verticalSpace,

            // quote
            Container(
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 20.h),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14.r),
                  color: AppColors.cardBackgroundSoftGray
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Provide Your Quote',
                    style: getTextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.bodyDarkGray
                    ),
                  ),

                  20.verticalSpace,

                  Text(
                    'Final Quote Price',
                    style: getTextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.secondaryAquaNormal
                    ),
                  ),

                  10.verticalSpace,

                  // // final quote price
                  IField(
                    controller: TextEditingController(),
                    filled: true,
                    fillColour: Color(0xFFE8F8F6),
                    borderColor: Color(0xFFB6E9E3),
                    hintText: "\$600.00",
                    hintTextStyle: getTextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.secondaryAquaNormal,
                    ),
                  ),

                  20.verticalSpace,

                  Text(
                    'Final Terms/Notes',
                    style: getTextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.secondaryAquaNormal
                    ),
                  ),

                  10.verticalSpace,

                  // final Terms
                  IField(
                    controller: TextEditingController(),
                    filled: true,
                    fillColour: Color(0xFFE8F8F6),
                    borderColor: Color(0xFFB6E9E3),
                    maxLine: 5,
                  )
                ],
              ),
            ),

            20.verticalSpace,

            // payment summary
            Container(
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 20.h),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14.r),
                  color: AppColors.cardBackgroundSoftGray
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Payment Summary',
                    style: getTextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.bodyDarkGray
                    ),
                  ),

                  30.verticalSpace,

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Services fee',
                        style: getTextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.primaryDeepBlueNormal,
                        ),
                      ),

                      Text(
                        '60.00',
                        style: getTextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.bodyDarkGray,
                        ),
                      ),

                    ],
                  ),
                  10.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Platform fee',
                        style: getTextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.primaryDeepBlueNormal,
                        ),
                      ),

                      Text(
                        '205.00',
                        style: getTextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.bodyDarkGray,
                        ),
                      ),

                    ],
                  ),

                  12.verticalSpace,

                  Divider(color: Color(0xFFB9C2DB),),

                  12.verticalSpace,

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total',
                        style: getTextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryDeepBlueNormal,
                        ),
                      ),

                      Text(
                        '274.60',
                        style: getTextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.bodyDarkGray,
                        ),
                      ),

                    ],
                  ),
                ],
              ),
            ),

            20.verticalSpace,

            // payment method
            Container(
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 20.h),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14.r),
                  color: AppColors.cardBackgroundSoftGray
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Payment Method',
                    style: getTextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.bodyDarkGray
                    ),
                  ),

                  10.verticalSpace,

                  // stripe
                  Container(
                    height: 50.h,
                    width: double.maxFinite,
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                        color: AppColors.primaryDeepBlueLight,
                        borderRadius: BorderRadius.circular(8.r)
                    ),

                    child: Row(
                      children: [
                        Image.asset(IconPath.mobile),
                        13.horizontalSpace,
                        Text(
                          request.paymentMethod.isEmpty
                              ? "Payment method"
                              : request.paymentMethod,
                          style: getTextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.bodyDarkGray
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),

            20.verticalSpace,

            CustomPrimaryButton(text: 'Quote & Accept', color: AppColors.primaryDeepBlueNormal, onPressed: (){}),

            20.verticalSpace,
          ],
        ).paddingSymmetric(horizontal: 15.w),
      );
  }));
  }
}
