import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sireenshaban/features/customer/home/controller/home_controller.dart';
import 'package:sireenshaban/features/vendor/vendor_schedule/views/widgets/vendor_schedule_card.dart';

import '../../../../../core/common/styles/global_text_style.dart';
import '../../../../../core/utils/constants/colors.dart';
import '../../../../../core/utils/constants/icon_path.dart';
import '../../../../../routes/app_routes.dart';

class VendorScheduleScreen extends StatelessWidget {
  VendorScheduleScreen({super.key});

  final HomeController controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F4F4),
      appBar: AppBar(
        backgroundColor: Color(0xFFF4F4F4),
        centerTitle: false,
        title: Text(
          'Schedule',
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
          10.verticalSpace,

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Today',
                style: getTextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryDeepBlueNormal,
                ),
              ),
              
              Container(
                height: 40.h,
                width: 40.w,
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: Color(0xFFE9EAEC),
                  borderRadius: BorderRadius.circular(8.r),
                ),

                child: Image.asset(IconPath.calenderMonth, color: AppColors.secondaryInfoMediumGrayNormal,),
              )
            ],
          ),


          20.verticalSpace,


          Expanded(
            child: ListView.separated(
              itemCount: controller.bookings.value!.data.length,
              separatorBuilder: (context , index) => 10.verticalSpace,
              itemBuilder: (context, index) => VendorScheduleCard(data: controller.bookings.value!.data[index],),
            ),
          )
        ],
      ).paddingSymmetric(horizontal: 20.w),
    );
  }
}
