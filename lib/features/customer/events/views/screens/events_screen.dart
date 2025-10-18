import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sireenshaban/core/common/styles/global_text_style.dart';
import 'package:sireenshaban/core/utils/constants/colors.dart';
import 'package:sireenshaban/features/customer/events/views/widgets/event_card.dart';

import '../../../../../core/utils/constants/icon_path.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F4F4),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            height: 40.h,
            width: 40.w,
            padding: EdgeInsets.all(7.w),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFE9EAEC),
            ),
            child: Image.asset(
              IconPath.arrowBack,
              height: 15.h,
              color: AppColors.bodyDarkGray,
            ),
          ).paddingAll(7.w),
        ),
        title: Text(
          'Events',
          style: getTextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.bodyDarkGray,
          ),
        ),
        actions: [
          IconButton(onPressed: (){}, icon: Container(
            height: 40.h,
            width: 40.w,
            padding: EdgeInsets.all(7.w),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFE9EAEC),
            ),
            child: Image.asset(IconPath.notification),
          ))
        ],
      ),

      body: Column(
        children: [
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

          10.verticalSpace,

          Expanded(
            child: ListView(
              children: [
                EventCard(
                  bannerImage: 'https://img.freepik.com/free-psd/music-event-template-design_23-2151154459.jpg',
                  title: "Beach Party",
                ),

                15.verticalSpace,

                EventCard(
                  bannerImage: 'https://d1csarkz8obe9u.cloudfront.net/posterpreviews/music-event-banner-design-template-f5cee382806952708213245a2657a733_screen.jpg?ts=1738768897',
                  title: "Concert"
                      "",
                )
              ],
            ),
          )
        ],
      ).paddingSymmetric(horizontal: 20.w),
    );
  }
}
