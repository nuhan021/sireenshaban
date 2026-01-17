import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
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
              color: Color(0xff3333331a),
              shape: BoxShape.circle,
            ),
            alignment: AlignmentGeometry.center,
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
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert_outlined)),
        ],
      ),

      body: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) => ListTile(
          leading: CircleAvatar(
            radius: 25.r,
            backgroundImage: NetworkImage(
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRBRfNX_1coQjpFuoF1ky07sOzLxPc8SNj2Pg&s",
            ),
            backgroundColor: Colors.white,
          ),

          title: Text(
            "The venue owner wants to contact you.",
            style: getTextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.bodyDarkGray,
            ),
          ),

          subtitle: Text(
            "10 min . Ago",
            overflow: TextOverflow.ellipsis,
            style: getTextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: Color(0xFF8D8D8D),
            ),
          ),
        ),
      ),
    );
  }
}
