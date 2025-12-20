import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sireenshaban/core/common/styles/global_text_style.dart';
import 'package:sireenshaban/core/utils/constants/icon_path.dart';
import 'package:sireenshaban/features/customer/community_event_booking/controller/event_controller.dart';

import '../../../../../core/utils/constants/colors.dart';

class PackageBookingPaymentMethod extends StatelessWidget {
  const PackageBookingPaymentMethod({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: AppColors.cardBackgroundSoftGray,
        borderRadius: BorderRadius.circular(12.r),
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
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
                  'Stripe',
                  style: getTextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.bodyDarkGray
                  ),
                )
              ],
            ),
          ),

          // 12.verticalSpace,

          // cash
          // Container(
          //   height: 50.h,
          //   width: double.maxFinite,
          //   padding: EdgeInsets.all(12.w),
          //   decoration: BoxDecoration(
          //       color: AppColors.primaryDeepBlueLight,
          //       borderRadius: BorderRadius.circular(8.r)
          //   ),
          //
          //   child: Row(
          //     children: [
          //       Image.asset(IconPath.wallet),
          //       13.horizontalSpace,
          //       Text(
          //         'Cash',
          //         style: getTextStyle(
          //             fontSize: 16.sp,
          //             fontWeight: FontWeight.w500,
          //             color: AppColors.bodyDarkGray
          //         ),
          //       )
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }
}
