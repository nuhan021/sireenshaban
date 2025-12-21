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
      backgroundColor: const Color(0xFFF4F4F4),
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
      body: Obx(() {
        // --- 1. Handle Loading State ---
        if (controller.isBookingLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        // --- 2. Handle Error State ---
        if (controller.isBookingError.value) {
          return Center(
            child: IconButton(
              onPressed: () => controller.getBooking(),
              icon: const Icon(Icons.refresh),
            ),
          );
        }

        final dataList = controller.filteredBookings;

        return Column(
          children: [
            10.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  // Show "Today" if today, otherwise show formatted date
                  controller.selectedDate.value.day == DateTime.now().day
                      ? 'Today'
                      : "${controller.selectedDate.value.day}/${controller.selectedDate.value.month}/${controller.selectedDate.value.year}",
                  style: getTextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryDeepBlueNormal,
                  ),
                ),

                // --- 3. Calendar Trigger ---
                GestureDetector(
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: controller.selectedDate.value,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    if (pickedDate != null) {
                      controller.updateSelectedDate(pickedDate);
                    }
                  },
                  child: Container(
                    height: 40.h, width: 40.w,
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE9EAEC),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Image.asset(IconPath.calenderMonth, color: AppColors.secondaryInfoMediumGrayNormal,),
                  ),
                )
              ],
            ),
            20.verticalSpace,

            // --- 4. Handle Empty State ---
            Expanded(
              child: dataList.isEmpty
                  ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.event_busy, size: 50.sp, color: Colors.grey),
                    10.verticalSpace,
                    Text("No schedules for this date", style: TextStyle(color: Colors.grey)),
                  ],
                ),
              )
                  : ListView.separated(
                itemCount: dataList.length,
                separatorBuilder: (context, index) => 10.verticalSpace,
                itemBuilder: (context, index) => VendorScheduleCard(data: dataList[index]),
              ),
            )
          ],
        ).paddingSymmetric(horizontal: 20.w);
      }),
    );
  }
}