import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sireenshaban/core/utils/constants/colors.dart';
import 'package:sireenshaban/core/utils/constants/image_path.dart';
import 'package:sireenshaban/features/customer/home/views/widget/additional_service.dart';
import 'package:sireenshaban/features/customer/home/views/widget/community_events.dart';
import 'package:sireenshaban/features/customer/home/views/widget/deals_and_promotions.dart';
import 'package:sireenshaban/features/customer/home/views/widget/home_search_bar.dart';
import 'package:sireenshaban/features/customer/home/views/widget/trending_nearby.dart';
import '../../../customer_bottom_nav_bar/controller/customer_bottom_nav_bar_controller.dart';
import '../../controller/home_controller.dart';

// ignore: must_be_immutable
class CustomerHomeScreen extends StatelessWidget {
  CustomerHomeScreen({super.key});

  final controller = Get.put(HomeController());
  CustomerBottomNavBarController navBarController =
      Get.find<CustomerBottomNavBarController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9FAFB),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              // search bar
              HomeSearchBar(
                onTap: () {
                  navBarController.jumpToScreen(1);
                },
                controller: controller,
              ),

              const SizedBox(height: 40),

              // banner
              SizedBox(
                width: double.maxFinite,
                child: Image.asset(ImagePath.bannerImg, fit: BoxFit.cover),
              ),

              const SizedBox(height: 40),

              // additional service
              Obx(() {
                if (controller.isAdditionalServiceLoading.value) {
                  return Center(
                    child: LoadingAnimationWidget.dotsTriangle(
                      color: AppColors.primaryDeepBlueNormal,
                      size: 25,
                    ),
                  );
                }

                if (controller.isAdditionalServiceError.value) {
                  return Center(
                    child: IconButton(
                      onPressed: () => controller.getAdditionalService(),
                      icon: Icon(
                        Icons.refresh,
                        color: AppColors.primaryDeepBlueNormal,
                      ),
                    ),
                  );
                }
                return AdditionalService(controller: controller);
              }),

              const SizedBox(height: 40),

              // deals and promotions
              Obx(() {
                if (controller.isDealsAndPromotionLoading.value) {
                  return Center(
                    child: LoadingAnimationWidget.dotsTriangle(
                      color: AppColors.primaryDeepBlueNormal,
                      size: 25,
                    ),
                  );
                }

                if (controller.isDealsAndPromotionError.value) {
                  return Center(
                    child: IconButton(
                      onPressed: () => controller.getDealsAndPromotions(),
                      icon: Icon(
                        Icons.refresh,
                        color: AppColors.primaryDeepBlueNormal,
                      ),
                    ),
                  );
                }
                return DealsAndPromotions(controller: controller);
              }),

              const SizedBox(height: 40),

              // community events
              Obx(() {
                if (controller.isCommunityEventsLoading.value) {
                  return Center(
                    child: LoadingAnimationWidget.dotsTriangle(
                      color: AppColors.primaryDeepBlueNormal,
                      size: 25,
                    ),
                  );
                }

                if (controller.isCommunityEventsError.value) {
                  return Center(
                    child: IconButton(
                      onPressed: () => controller.getCommunityEvents(),
                      icon: Icon(
                        Icons.refresh,
                        color: AppColors.primaryDeepBlueNormal,
                      ),
                    ),
                  );
                }
                return CommunityEvents(controller: controller);
              }),

              const SizedBox(height: 40),

              // trending nearby
              Obx(() {
                if (controller.isTrendingNearbyLoading.value) {
                  return Center(
                    child: LoadingAnimationWidget.dotsTriangle(
                      color: AppColors.primaryDeepBlueNormal,
                      size: 25,
                    ),
                  );
                }

                if (controller.isTrendingNearbyError.value) {
                  return Center(
                    child: IconButton(
                      onPressed: () => controller.getTrendingNearby(),
                      icon: Icon(
                        Icons.refresh,
                        color: AppColors.primaryDeepBlueNormal,
                      ),
                    ),
                  );
                }
                return TrendingNearby(controller: controller);
              }),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
