import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
              20.verticalSpace,

              // search bar
              HomeSearchBar(
                onTap: () {
                  navBarController.jumpToScreen(1);
                },
              ),

              40.verticalSpace,

              // banner
              SizedBox(
                width: double.maxFinite,
                child: Image.asset(ImagePath.bannerImg, fit: BoxFit.cover),
              ),

              40.verticalSpace,

              // additional service
              Obx(() {
                if (controller.isAdditionalServiceLoading.value) {
                  return Center(
                    child: LoadingAnimationWidget.dotsTriangle(
                      color: AppColors.primaryDeepBlueNormal,
                      size: 25.h,
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

              40.verticalSpace,

              // deals and promotions
              Obx(() {
                if (controller.isDealsAndPromotionLoading.value) {
                  return Center(
                    child: LoadingAnimationWidget.dotsTriangle(
                      color: AppColors.primaryDeepBlueNormal,
                      size: 25.h,
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

              40.verticalSpace,

              // featured vendors
              // FeaturedVendors(),
              //
              // 40.verticalSpace,

              // community events
              Obx(() {
                if (controller.isCommunityEventsLoading.value) {
                  return Center(
                    child: LoadingAnimationWidget.dotsTriangle(
                      color: AppColors.primaryDeepBlueNormal,
                      size: 25.h,
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

              40.verticalSpace,

              // trending nearby
              Obx(() {
                if (controller.isTrendingNearbyLoading.value) {
                  return Center(
                    child: LoadingAnimationWidget.dotsTriangle(
                      color: AppColors.primaryDeepBlueNormal,
                      size: 25.h,
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

              40.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
