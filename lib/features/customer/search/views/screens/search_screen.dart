import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sireenshaban/core/common/widgets/IField.dart';
import 'package:sireenshaban/features/customer/home/controller/home_controller.dart';

import '../../../../../core/common/styles/global_text_style.dart';
import '../../../../../core/utils/constants/colors.dart';
import '../../../../../core/utils/constants/icon_path.dart';
import '../../../../../core/utils/helpers/app_helper.dart';
import '../../../vendors/views/screens/vendors_screen.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  HomeController controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F4F4),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: false,
        title: Text(
          'Search',
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
          10.verticalSpace,

          // search bar
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: const Color.fromRGBO(13, 10, 44, 0.06),
                  offset: const Offset(0, 3),
                  blurRadius: 10,
                  spreadRadius: 0,
                ),
              ],
              borderRadius: BorderRadius.circular(12),
            ),
            child: IField(
              controller: TextEditingController(),
              onChanged: (value) {
                controller.searchQuery.value = value;
              },
              filled: true,
              fillColour: AppColors.cardBackgroundSoftGray,
              hintText: "Search Services",
              hintTextStyle: getTextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.secondaryInfoMediumGrayNormal,
              ),
              borderColor: Colors.transparent,
              suffixIcon: GestureDetector(
                onTap: () {},
                child: Padding(
                  padding: EdgeInsets.all(10.w),
                  child: Image.asset(
                    IconPath.navSearch,
                    height: 24.h,
                    color: AppColors.primaryDeepBlueNormal,
                  ),
                ),
              ),
            ),
          ),

          10.verticalSpace,

          Expanded(
            child: Obx(() {
              final list = controller.filteredCategories;

              if (list.isEmpty) {
                return const Center(child: Text("No categories found"));
              }

              return ListView.builder(
                itemCount: list.length,
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                itemBuilder: (context, index) {
                  final e = list[index];
                  return GestureDetector(
                    onTap: () => AppHelperFunctions.navigateToScreen(
                      context,
                      VendorsScreen(categorySlug: e.slug),
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          IconPath.navSearch,
                          height: 25.h,
                          color: AppColors.primaryDeepBlueNormal,
                        ),
                        10.horizontalSpace,
                        Text(
                          e.name ?? '',
                          style: getTextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.bodyDarkGray,
                          ),
                        ),
                      ],
                    ).paddingSymmetric(vertical: 10.h),
                  );
                },
              );
            }),
          ),
        ],
      ).paddingSymmetric(horizontal: 20.w),
    );
  }
}
