import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sireenshaban/features/customer/home/controller/home_controller.dart';
import 'package:sireenshaban/features/customer/home/views/widget/community_events_card.dart';

import '../../../../../core/common/styles/global_text_style.dart';
import '../../../../../core/utils/constants/colors.dart';

class CommunityEvents extends StatelessWidget {
  const CommunityEvents({
    super.key,
    required this.controller,
    this.isFromVendor = false,
  });

  final HomeController controller;
  final bool? isFromVendor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // title
        Text(
          controller.communityEvents.value!.data.isEmpty
              ? 'No Community Events'
              : 'Community Events',
          style: getTextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.secondaryInfoMediumGrayDarker,
          ),
        ).paddingSymmetric(horizontal: 20),

        const SizedBox(height: 20),

        SizedBox(
          height: controller.communityEvents.value!.data.isEmpty ? 0 : 360,
          width: double.maxFinite,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: controller.communityEvents.value!.data.length,
            itemBuilder: (context, index) {
              final item = controller.communityEvents.value!.data[index];
              return CommunityEventsCard(
                id: item.id,
                image: item.image,
                title: item.title,
                date:
                    "${item.eventDate.day}-${item.eventDate.month}-${item.eventDate.year}",
                location: item.location,
                isFromVendor: isFromVendor,
              );
            },
          ),
        ),
      ],
    );
  }
}
