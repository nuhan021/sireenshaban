import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sireenshaban/core/common/styles/global_text_style.dart';
import 'package:sireenshaban/core/utils/constants/colors.dart';

import '../../../../../core/utils/constants/icon_path.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Container(
            height: 40.h,
            width: 40.w,
            decoration: BoxDecoration(
              color: const Color(0xff3333331a),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Image.asset(IconPath.arrowBack, height: 24.h),
          ),
        ),
        title: Text(
          'Notification',
          style: getTextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.bodyDarkGray,
          ),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert_outlined)),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.notifications_none_outlined,
              size: 80.sp,
              color: Colors.grey.withOpacity(0.5),
            ),
            SizedBox(height: 16.h),
            Text(
              "No notifications right now",
              style: getTextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
