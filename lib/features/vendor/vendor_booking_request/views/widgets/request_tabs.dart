import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sireenshaban/core/utils/constants/enums.dart';
import 'package:sireenshaban/features/vendor/vendor_booking_request/controller/vendor_booking_request_controller.dart';

import '../../../../../core/common/styles/global_text_style.dart';
import '../../../../../core/utils/constants/colors.dart';

class RequestTabs extends StatelessWidget {
  const RequestTabs({super.key, required this.controller});

  final VendorBookingController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
            () {
        return Row(
          children: [
            Expanded(child: GestureDetector(
              onTap: () => controller.changeBookingRequest(BookingRequest.newRequest),
              child: Container(
                height: 40.h,
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  color: controller.bookingRequest.value == BookingRequest.newRequest ? AppColors.primaryDeepBlueNormal : AppColors.cardBackgroundSoftGray,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          'New',
                          overflow: TextOverflow.ellipsis,
                          style: getTextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color:controller.bookingRequest.value == BookingRequest.newRequest ? AppColors.cardBackgroundSoftGray : AppColors.primaryDeepBlueNormal
                          ),
                        ),
                      ),
                    ),

                    5.horizontalSpace,

                    Container(
                      height: 20.h,
                      width: 20.w,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: controller.bookingRequest.value == BookingRequest.newRequest ? AppColors.cardBackgroundSoftGray : AppColors.primaryDeepBlueNormal
                      ),
                      alignment: AlignmentGeometry.center,
                      child: Text(
                        '3',
                        style: getTextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: controller.bookingRequest.value == BookingRequest.newRequest ? AppColors.primaryDeepBlueNormal : AppColors.cardBackgroundSoftGray
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )),

            10.horizontalSpace,

            Expanded(child: GestureDetector(
              onTap: () => controller.changeBookingRequest(BookingRequest.quotedRequest),
              child: Container(
                height: 40.h,
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  color: controller.bookingRequest.value == BookingRequest.quotedRequest ? AppColors.primaryDeepBlueNormal : AppColors.cardBackgroundSoftGray,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          'Quoted',
                          overflow: TextOverflow.ellipsis,
                          style: getTextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color:controller.bookingRequest.value == BookingRequest.quotedRequest ? AppColors.cardBackgroundSoftGray : AppColors.primaryDeepBlueNormal
                          ),
                        ),
                      ),
                    ),

                    5.horizontalSpace,

                    // Container(
                    //   height: 20.h,
                    //   width: 20.w,
                    //   decoration: BoxDecoration(
                    //       shape: BoxShape.circle,
                    //       color: controller.bookingRequest.value == BookingRequest.quotedRequest ? AppColors.cardBackgroundSoftGray : AppColors.primaryDeepBlueNormal
                    //   ),
                    //   alignment: AlignmentGeometry.center,
                    //   child: Text(
                    //     '3',
                    //     style: getTextStyle(
                    //         fontSize: 12.sp,
                    //         fontWeight: FontWeight.w400,
                    //         color: controller.bookingRequest.value == BookingRequest.quotedRequest ? AppColors.primaryDeepBlueNormal : AppColors.cardBackgroundSoftGray
                    //     ),
                    //   ),
                    // )
                  ],
                ),
              ),
            )),

            10.horizontalSpace,

            Expanded(child: GestureDetector(
              onTap: () => controller.changeBookingRequest(BookingRequest.rejectedRequest),
              child: Container(
                height: 40.h,
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  color: controller.bookingRequest.value == BookingRequest.rejectedRequest ? AppColors.primaryDeepBlueNormal : AppColors.cardBackgroundSoftGray,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          'Rejected',
                          overflow: TextOverflow.ellipsis,
                          style: getTextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color:controller.bookingRequest.value == BookingRequest.rejectedRequest ? AppColors.cardBackgroundSoftGray : AppColors.primaryDeepBlueNormal
                          ),
                        ),
                      ),
                    ),

                    5.horizontalSpace,

                    // Container(
                    //   height: 20.h,
                    //   width: 20.w,
                    //   decoration: BoxDecoration(
                    //       shape: BoxShape.circle,
                    //       color: controller.bookingRequest.value == BookingRequest.rejectedRequest ? AppColors.cardBackgroundSoftGray : AppColors.primaryDeepBlueNormal
                    //   ),
                    //   alignment: AlignmentGeometry.center,
                    //   child: Text(
                    //     '3',
                    //     style: getTextStyle(
                    //         fontSize: 12.sp,
                    //         fontWeight: FontWeight.w400,
                    //         color: controller.bookingRequest.value == BookingRequest.rejectedRequest ? AppColors.primaryDeepBlueNormal : AppColors.cardBackgroundSoftGray
                    //     ),
                    //   ),
                    // )
                  ],
                ),
              ),
            )),
          ],
        );
      }
    );
  }
}
