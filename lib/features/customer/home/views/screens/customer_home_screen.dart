import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sireenshaban/core/utils/constants/icon_path.dart';
import 'package:sireenshaban/core/utils/constants/image_path.dart';
import 'package:sireenshaban/features/customer/home/views/widget/additional_service.dart';
import 'package:sireenshaban/features/customer/home/views/widget/additional_service_card.dart';
import 'package:sireenshaban/features/customer/home/views/widget/community_events.dart';
import 'package:sireenshaban/features/customer/home/views/widget/deals_and_promotions.dart';
import 'package:sireenshaban/features/customer/home/views/widget/featured_vendors.dart';
import 'package:sireenshaban/features/customer/home/views/widget/home_search_bar.dart';
import 'package:sireenshaban/features/customer/home/views/widget/trending_nearby.dart';

import '../../../../../core/common/styles/global_text_style.dart';
import '../../../../../core/utils/constants/colors.dart';
import '../../controller/home_controller.dart';

class CustomerHomeScreen extends StatelessWidget {
  CustomerHomeScreen({super.key});

  final controller = Get.put(HomeController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              36.verticalSpace,

              // search bar
              HomeSearchBar(onTap: () {},),

              40.verticalSpace,

              // banner
              SizedBox(
                height: 230.h,
                width: double.maxFinite,
                child: Image.asset(ImagePath.bannerImg, fit: BoxFit.cover),
              ),

              40.verticalSpace,

             // additional service
              AdditionalService(controller: controller),


              40.verticalSpace,

              // deals and promotions
              DealsAndPromotions(controller: controller,),

              40.verticalSpace,

              // featured vendors
              FeaturedVendors(),

              40.verticalSpace,

              // community events
              CommunityEvents(),

              40.verticalSpace,

              // trending nearby
              TrendingNearby(),

              40.verticalSpace,
              
            ],
          ),
        ),
      ),
    );
  }
}
