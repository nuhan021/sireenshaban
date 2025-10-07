import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sireenshaban/features/customer/home/views/widget/featured_vendors_card.dart';
import 'package:sireenshaban/features/customer/home/views/widget/home_search_bar.dart';

import '../../../../../core/common/styles/global_text_style.dart';
import '../../../../../core/utils/constants/colors.dart';
import '../../controller/vendors_controller.dart';

class VendorsScreen extends StatelessWidget {
  VendorsScreen({super.key});

  final VendorsController controller = Get.put(VendorsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            30.verticalSpace,

            // search bar
            HomeSearchBar(onTap: () {}),

            40.verticalSpace,

            // title and button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Featured Vendors',
                  style: getTextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.secondaryInfoMediumGrayDarker,
                  ),
                ),

                Row(
                  children: [
                    Text(
                      'All',
                      style: getTextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primaryDeepBlueNormal,
                      ),
                    ),

                    Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.primaryDeepBlueNormal,)
                  ],
                ),
              ],
            ).paddingSymmetric(horizontal: 20.sp),

            20.verticalSpace,

            // all vendors
            Expanded(
              child: ListView.separated(
                itemCount: controller.vendors.length,
                separatorBuilder: (context, index) => 10.verticalSpace,
                itemBuilder: (context, index) {
                  final vendor = controller.vendors[index];
                  return FeaturedVendorsCard(
                    image: vendor.image,
                    title: vendor.title,
                    subtitle: vendor.subtitle,
                    service: vendor.service,
                    price: vendor.price,
                    date: vendor.date,
                    location: vendor.location,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
