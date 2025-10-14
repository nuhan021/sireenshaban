import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../../core/common/styles/global_text_style.dart';
import '../../../../../core/utils/constants/colors.dart';
import '../../../../../core/utils/constants/icon_path.dart';
import '../../../../../routes/app_routes.dart';

class PaymentHistoryScreen extends StatelessWidget {
  const PaymentHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F4F4),
      appBar: AppBar(
        backgroundColor: Color(0xFFF4F4F4),
        title: Text(
          'Payment History',
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

      body: Expanded(
        child: ListView.separated(
          itemCount: 10,
          separatorBuilder: (context, index) => 10.verticalSpace,
          itemBuilder: (context, index) => ListTile(
            isThreeLine: true,
            tileColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r)
            ),

            leading: Container(
              height: 48.h,
              width: 48.w,
              decoration: BoxDecoration(
                color: AppColors.primaryDeepBlueNormal,
                borderRadius: BorderRadius.circular(9.r)
              ),

              alignment: AlignmentGeometry.center,
              child: Image.asset(IconPath.wallet, height: 28.h, color: Colors.white,),
            ),

            title: Text(
              'Payment confirmed',
              style: getTextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.primaryDeepBlueNormal
              ),
            ),

            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // payment method
                Text(
                  'From Visa Card',
                  style: getTextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.primaryDeepBlueNormal
                  ),
                ),

                // transaction ID
                Text(
                  'Transaction ID - 5621456325542',
                  style: getTextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.secondaryInfoMediumGrayNormal
                  ),
                ),
              ],
            ),


            trailing: Column(

              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // amount
                Text(
                  '\$100.00',
                  style: getTextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryDeepBlueNormal
                  ),
                ),

                Text(
                  '17 Sep 2025',
                  style: getTextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.secondaryInfoMediumGrayNormal
                  ),
                ),Text(
                  '10:30 am',
                  style: getTextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.secondaryInfoMediumGrayNormal
                  ),
                ),

              ],
            ),

          ).paddingOnly(top: index == 0 ? 40.h : 0, bottom: index == 9 ? 20.h : 0),
        ),
      ).paddingSymmetric(horizontal: 20.w),
    );
  }
}
