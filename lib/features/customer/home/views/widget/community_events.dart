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

        SizedBox(
          height: 305.h,
          width: double.maxFinite,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: controller.communityEvents.value!.data.length,
            itemBuilder: (context, index) {
              final item = controller.communityEvents.value!.data[index];
              return CommunityEventsCard(
                image: item.image ?? '',
                title: item.title ?? '',
                date: "${item.eventDate.day}-${item.eventDate.month}-${item.eventDate.year}",
                location: item.location ?? '',
              );
            },
          ),
        ),
      ],
    );
  }
}
