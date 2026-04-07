import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sireenshaban/core/common/styles/global_text_style.dart';
import 'package:sireenshaban/core/utils/constants/colors.dart';
import 'package:sireenshaban/features/customer/events/views/widgets/event_card.dart';
import 'package:sireenshaban/features/customer/home/controller/home_controller.dart';

import '../../../../../core/utils/constants/icon_path.dart';

class EventsScreen extends StatelessWidget {
  EventsScreen({super.key});

  final HomeController _homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            height: 40,
            width: 40,
            padding: const EdgeInsets.all(7),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFE9EAEC),
            ),
            child: Image.asset(
              IconPath.arrowBack,
              height: 15,
              color: AppColors.bodyDarkGray,
            ),
          ).paddingAll(7),
        ),
        title: Text(
          'Events',
          style: getTextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: AppColors.bodyDarkGray,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Container(
              height: 40,
              width: 40,
              padding: const EdgeInsets.all(7),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFE9EAEC),
              ),
              child: Image.asset(IconPath.notification),
            ),
          ),
        ],
      ),

      body: Obx(() {
        if (_homeController.isCommunityEventsLoading.value) {
          return Center(
            child: LoadingAnimationWidget.dotsTriangle(
              color: AppColors.primaryDeepBlueNormal,
              size: 25,
            ),
          );
        }

        if (_homeController.isCommunityEventsError.value) {
          return Center(
            child: IconButton(
              onPressed: () => _homeController.getAdditionalService(),
              icon: Icon(Icons.refresh, color: AppColors.primaryDeepBlueNormal),
            ),
          );
        }
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Today',
                  style: getTextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryDeepBlueNormal,
                  ),
                ),

                Container(
                  height: 40,
                  width: 40,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE9EAEC),
                    borderRadius: BorderRadius.circular(8),
                  ),

                  child: Image.asset(
                    IconPath.calenderMonth,
                    color: AppColors.secondaryInfoMediumGrayNormal,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            Expanded(
              child: ListView.separated(
                itemCount: _homeController.communityEvents.value!.data.length,
                separatorBuilder: (context, index) => const SizedBox(height: 15),
                itemBuilder: (context, index) {
                  final item =
                      _homeController.communityEvents.value!.data[index];
                  return EventCard(
                    bannerImage: item.image ?? '',
                    title: item.title,
                    date:
                        "${item.eventDate.day}-${item.eventDate.month}-${item.eventDate.year}",
                    location: item.location,
                    ticketPrice: item.ticketPrice,
                  );
                },
              ),
            ),
          ],
        ).paddingSymmetric(horizontal: 20);
      }),
    );
  }
}
