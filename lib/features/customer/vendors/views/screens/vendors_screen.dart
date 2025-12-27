// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sireenshaban/core/utils/helpers/app_helper.dart';
import 'package:sireenshaban/features/customer/home/controller/home_controller.dart';
import 'package:sireenshaban/features/customer/home/model/packages_model.dart';
import 'package:sireenshaban/features/customer/home/views/widget/featured_vendors_card.dart';
import '../../../../../core/common/styles/global_text_style.dart';
import '../../../../../core/utils/constants/colors.dart';

class VendorsScreen extends StatefulWidget {
  const VendorsScreen({super.key, this.categorySlug = ''});

  final String categorySlug;

  @override
  State<VendorsScreen> createState() => _VendorsScreenState();
}

class _VendorsScreenState extends State<VendorsScreen> {
  final HomeController controller = Get.isRegistered<HomeController>()
      ? Get.find<HomeController>()
      : Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    if (widget.categorySlug.isNotEmpty) {
      controller.getPackagesByCategory(categorySlug: widget.categorySlug);
    }
  }

  String _getPackageDate(
    DateTime? validUntil,
    List<AvailableDate> availableDates,
  ) {
    if (availableDates.isNotEmpty) {
      return AppHelperFunctions.getFormattedDate(availableDates.first.date);
    }
    if (validUntil != null) {
      return AppHelperFunctions.getFormattedDate(validUntil);
    }
    return '-';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            30.verticalSpace,

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

                Text(
                  'Doctors',
                  style: getTextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryDeepBlueNormal,
                  ),
                ),
              ],
            ).paddingSymmetric(horizontal: 20.sp),

            20.verticalSpace,

            // all vendors
            Expanded(
              child: Obx(() {
                if (controller.isCategoryPackagesLoading.value) {
                  return Center(
                    child: LoadingAnimationWidget.dotsTriangle(
                      color: AppColors.primaryDeepBlueNormal,
                      size: 25.h,
                    ),
                  );
                }

                if (controller.isCategoryPackagesError.value) {
                  return Center(
                    child: IconButton(
                      onPressed: () => controller.getPackagesByCategory(
                        categorySlug: widget.categorySlug,
                      ),
                      icon: Icon(
                        Icons.refresh,
                        color: AppColors.primaryDeepBlueNormal,
                      ),
                    ),
                  );
                }

                final packages = controller.categoryPackages.value?.data ?? [];
                if (packages.isEmpty) {
                  return Center(
                    child: Text(
                      'No packages found',
                      style: getTextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.secondaryInfoMediumGrayNormal,
                      ),
                    ),
                  );
                }

                return ListView.separated(
                  itemCount: packages.length,
                  separatorBuilder: (context, index) => 10.verticalSpace,
                  itemBuilder: (context, index) {
                    final package = packages[index];
                    return FeaturedVendorsCard(
                      image: package.image?.toString() ?? '',
                      title: package.title,
                      subtitle: package.subtitle ?? package.category.name,
                      service: package.vendor.businessName,
                      price: "\$${package.pricePerEvent}",
                      date: _getPackageDate(
                        package.validUntil,
                        package.availableDates,
                      ),
                      location: package.location.isNotEmpty
                          ? package.location
                          : 'Near you',
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
