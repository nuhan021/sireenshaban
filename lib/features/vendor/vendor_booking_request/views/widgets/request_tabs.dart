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
            Expanded(
              child: GestureDetector(
                onTap: () => controller.changeBookingRequest(BookingRequest.newRequest),
                child: Container(
                  height: 40.h,
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    color: AppColors.primaryDeepBlueNormal,
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
                                color: AppColors.cardBackgroundSoftGray),
                          ),
                        ),
                      ),
                      5.horizontalSpace,
                      Container(
                        height: 20.h,
                        width: 20.w,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.cardBackgroundSoftGray),
                        alignment: AlignmentGeometry.center,
                        child: Text(
                          controller.serviceRequests.length.toString(),
                          style: getTextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.primaryDeepBlueNormal),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      }
    );
  }
}
