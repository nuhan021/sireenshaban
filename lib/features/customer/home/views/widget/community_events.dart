import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sireenshaban/features/customer/home/controller/home_controller.dart';
import 'package:sireenshaban/features/customer/home/views/widget/community_events_card.dart';

import '../../../../../core/common/styles/global_text_style.dart';
import '../../../../../core/utils/constants/colors.dart';

class CommunityEvents extends StatelessWidget {
  CommunityEvents({super.key, required this.controller});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // title
        Text(
          'Community Events',
          style: getTextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.secondaryInfoMediumGrayDarker,
          ),
        ).paddingSymmetric(horizontal: 20.w),

        20.verticalSpace,

        // community events card
        // SingleChildScrollView(
        //   scrollDirection: Axis.horizontal,
        //   child: Row(
        //     children: [
        //       CommunityEventsCard(
        //         image:  "https://www.skylakes.org/wp-content/uploads/2023/12/healthfair2023-scaled.jpg",
        //         title: "Community Health Fair",
        //         date: "15 March,2025",
        //         location: "Near you",
        //       ),
        //       CommunityEventsCard(
        //         image:  "https://bestinteriordesign.com.bd/wp-content/uploads/2022/08/software-company-inteiror-deisgn.png",
        //         title: "Local Business Expo",
        //         date: "15 March,2025",
        //         location: "Near you",
        //       ),
        //     ],
        //   ),
        // )
        SizedBox(
          height: 305.h,
          width: double.maxFinite,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: controller.communityEvents.length,
            itemBuilder: (context, index) => CommunityEventsCard(
              image: controller.communityEvents[index].image,
              title: controller.communityEvents[index].title,
              date: controller.communityEvents[index].date,
              location: controller.communityEvents[index].location,
            ),
          ),
        ),
      ],
    );
  }
}
