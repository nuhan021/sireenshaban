import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sireenshaban/features/vendor/vendor_booking_request/controller/vendor_booking_request_controller.dart';
import 'package:sireenshaban/features/vendor/vendor_booking_request/views/widgets/booking_request_card.dart';
import 'package:sireenshaban/features/vendor/vendor_booking_request/views/widgets/request_tabs.dart';

import '../../../../../core/common/styles/global_text_style.dart';
import '../../../../../core/utils/constants/colors.dart';
import '../../../../../core/utils/constants/icon_path.dart';
import '../../../../../routes/app_routes.dart';

class VendorBookingRequestScreen extends StatelessWidget {
  VendorBookingRequestScreen({super.key});

  VendorBookingController controller = Get.put(VendorBookingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F4F4),
      appBar: AppBar(
        backgroundColor: Color(0xFFF4F4F4),
        centerTitle: false,
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

      body: Column(
        children: [
          20.verticalSpace,
          // request tab
          RequestTabs(controller: controller,),

          20.verticalSpace,


          // requests
          Expanded(
            child: ListView.separated(
              itemCount: 10,
              separatorBuilder: (context, index) => 10.verticalSpace,
              itemBuilder: (context, index) => BookingRequestCard(),
            ),
          )
        ],
      ).paddingSymmetric(horizontal: 20.w),
    );
  }
}
