import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sireenshaban/core/common/widgets/custom_primary_button.dart';
import 'package:sireenshaban/features/vendor/vendor_home/model/vendor_booking_model.dart';

import '../../../../../core/common/styles/global_text_style.dart';
import '../../../../../core/utils/constants/colors.dart';
import '../../../../../core/utils/constants/icon_path.dart';
import '../../../../../routes/app_routes.dart';

class VendorRequestStatusScreen extends StatelessWidget {
  const VendorRequestStatusScreen({super.key, this.data});

  final Datum? data;


  String formatMyDate(DateTime? date) {
    if (date == null) return "N/A";

    List<String> months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];

    return "${date.day} ${months[date.month - 1]}, ${date.year}";
  }

  String calculateRemainingTime(DateTime targetDate) {
    DateTime now = DateTime.now(); // বর্তমান সময়

    // দুই সময়ের ব্যবধান বের করা
    Duration difference = targetDate.difference(now);

    if (difference.isNegative) {
      return "Time left";
    } else {
      int days = difference.inDays;
      int hours = difference.inHours % 24;
      int minutes = difference.inMinutes % 60;

      return"$days days and $hours hour left";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F4F4),
      appBar: AppBar(
        backgroundColor: Color(0xFFF4F4F4),
        title: Text(
          'Service request  status',
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

      body: SingleChildScrollView(
        child: Column(
          children: [
            20.verticalSpace,

            // booking id, data and time
            Container(
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 20.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14.r),
                color: AppColors.cardBackgroundSoftGray
              ),

              child: Column(
                children: [
                  // booking id
                  Row(
                    children: [
                      Text(
                        'Booking ID',
                        style: getTextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.accentNormal,
                        ),
                      ),

                      5.horizontalSpace,

                      Text(
                        '#${data!.id}',
                        style: getTextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.bodyDarkGray,
                        ),
                      ),
                    ],
                  ),
                  
                  30.verticalSpace,
                  
                  // date and time
                  Row(
                    children: [
                      Image.asset(IconPath.navCalendar, height: 25.h, color: AppColors.bodyDarkGray,),
                      5.horizontalSpace,
                      Text(
                          formatMyDate(data!.date),
                        style: getTextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.bodyDarkGray
                        ),
                      )
                    ],
                  ),
                  15.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // date
                      Expanded(child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Date',
                            style: getTextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.bodyDarkGray
                            ),
                          ),
                          10.verticalSpace,
                          Container(

                            height: 37.h,
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                              color: AppColors.primaryDeepBlueLight,
                              borderRadius: BorderRadius.circular(4.r),
                            ),

                            alignment: AlignmentGeometry.center,
                            child: Text(
                                formatMyDate(data!.date),
                              style: getTextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: AppColors.bodyDarkGray
                              ),
                            ),
                          ),
                        ],
                      )),

                      18.horizontalSpace,

                      // date
                      Expanded(child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Time',
                            style: getTextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.bodyDarkGray
                            ),
                          ),
                          10.verticalSpace,
                          Container(

                            height: 37.h,
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                              color: AppColors.primaryDeepBlueLight,
                              borderRadius: BorderRadius.circular(4.r),
                            ),

                            alignment: AlignmentGeometry.center,
                            child: Text(
                              data!.time,
                              style: getTextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.bodyDarkGray
                              ),
                            ),
                          ),
                        ],
                      )),
                    ],
                  )
                ],
              ),
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
                    'Project Scope',
                    style: getTextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.bodyDarkGray,
                    ),
                  ),

                  12.verticalSpace,

                  Text(
                    data?.specialConcerns ?? '',
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
                        'Duration:',
                        style: getTextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.bodyDarkGray,
                        ),
                      ),

                      20.horizontalSpace,

                      Expanded(
                        child: Text(
                          calculateRemainingTime(data!.date),
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
                        'Event Type:',
                        style: getTextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.bodyDarkGray,
                        ),
                      ),

                      20.horizontalSpace,

                      Expanded(
                        child: Text(
                          data?.package?.title ?? '',
                          style: getTextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.bodyDarkGray
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),

            20.verticalSpace,

            // vendor final quote
            Container(
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 20.h),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14.r),
                  color: AppColors.secondaryTealLight,
                border: Border.all(
                  color: AppColors.secondaryAquaNormal,
                )
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          'Vendor Final Quote',
                          overflow: TextOverflow.ellipsis,
                          style: getTextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.secondaryAquaNormal
                          ),
                        ),
                      ),

                      Text(
                        '\$${data!.total}',
                        style: getTextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.secondaryAquaNormal
                        ),
                      ),
                    ],
                  ),

                  12.verticalSpace,

                  Text(
                    'Based on your request details',
                    style: getTextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.secondaryAquaNormal
                    ),
                  )
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
                        'Vendor Total',
                        style: getTextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.primaryDeepBlueNormal,
                        ),
                      ),

                      Text(
                        data!.vendorTotal,
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
                        data!.platformFee,
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
                        data!.total,
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

            CustomPrimaryButton(text: data!.status == "Pending"? "Send Quote" : data!.status == "Confirmed" ? "Make Complete" : "Cancel", color: AppColors.primaryDeepBlueNormal, onPressed: (){}),

            20.verticalSpace,

          ],
        ).paddingSymmetric(horizontal: 20.w,),
      )
    );
  }
}
