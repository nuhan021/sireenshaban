import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sireenshaban/core/common/styles/global_text_style.dart';
import 'package:sireenshaban/core/utils/constants/colors.dart';
import 'package:sireenshaban/features/customer/events/views/widgets/event_card.dart';

import '../../../../../core/utils/constants/icon_path.dart';

class EventsScreen extends StatelessWidget {
  EventsScreen({super.key});

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
          IconButton(
            onPressed: () {},
            icon: Container(
              height: 40.h,
              width: 40.w,
              padding: EdgeInsets.all(7.w),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFE9EAEC),
              ),
              child: Image.asset(IconPath.notification),
            ),
          ),
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

                child: Image.asset(
                  IconPath.calenderMonth,
                  color: AppColors.secondaryInfoMediumGrayNormal,
                ),
              ),
            ],
          ),

          10.verticalSpace,

          Expanded(
            child: ListView(
              children: [
                EventCard(
                  bannerImage:
                      'https://img.freepik.com/free-psd/music-event-template-design_23-2151154459.jpg',
                  title: "Beach Party",
                ),

                15.verticalSpace,

                EventCard(
                  bannerImage:
                      'https://market-resized.envatousercontent.com/previews/files/241505163/preview.jpg?w=590&h=590&cf_fit=crop&crop=top&format=auto&q=85&s=8b9b351447b230ec03ff0b6e5b0f320d959aadcb31e2248378c22f2872dd1556',
                  title: "Concert",
                ),

                15.verticalSpace,

                EventCard(
                  bannerImage:
                      'https://media.istockphoto.com/id/622215586/photo/psychedelic-concert-crowd.jpg?s=612x612&w=0&k=20&c=4iF7Qq_buiJtI9Iz3d-XRRM-FTyhKj2umcoQC_cjc_8=',
                  title: "Concert",
                ),

                15.verticalSpace,
                EventCard(
                  bannerImage:
                      'https://img.freepik.com/free-vector/stand-up-comedy-banner-with-red-curtains-background_1308-84986.jpg',
                  title: "Concert",
                ),

                15.verticalSpace,
                EventCard(
                  bannerImage:
                      'https://www.funflicks.com/wp-content/uploads/2024/01/movie-licensing-guide.jpg',
                  title: "Concert",
                ),

                15.verticalSpace,
              ],
            ),
          ),
        ],
      ).paddingSymmetric(horizontal: 20.w),
    );
  }
}
