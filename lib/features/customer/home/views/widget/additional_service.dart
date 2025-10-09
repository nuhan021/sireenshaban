import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sireenshaban/core/common/widgets/IField.dart';
import 'package:sireenshaban/core/utils/constants/icon_path.dart';
import 'package:sireenshaban/core/utils/logging/logger.dart';
import 'package:sireenshaban/features/customer/home/controller/home_controller.dart';
import 'package:sireenshaban/features/customer/home/views/widget/home_search_bar.dart';

import '../../../../../core/common/styles/global_text_style.dart';
import '../../../../../core/utils/constants/colors.dart';
import '../../../../../core/utils/constants/image_path.dart';
import '../../../../../core/utils/helpers/app_helper.dart';
import '../../../vendors/views/screens/vendors_screen.dart';
import 'additional_service_card.dart';

class AdditionalService extends StatelessWidget {
  AdditionalService({super.key, required this.controller});

  final HomeController controller;
  TextEditingController additionalSearchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // additional services title and button
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Additional Services',
              style: getTextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.secondaryInfoMediumGrayDarker,
              ),
            ),

            // explore all button
            GestureDetector(
              onTap: () => controller.changeIsAdditionalServicesClose(
                value: !controller.isAdditionalServicesClose.value,
              ),
              child: Row(
                children: [
                  Text(
                    'Explore All',
                    style: getTextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryDeepBlueNormal,
                    ),
                  ),

                  8.horizontalSpace,

                  Obx(() {
                    return Icon(
                      controller.isAdditionalServicesClose.value
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down_rounded,
                      color: AppColors.primaryDeepBlueNormal,
                    );
                  }),
                ],
              ),
            ),
          ],
        ).paddingSymmetric(horizontal: 20.w),

        26.verticalSpace,

        // additional services
        Obx(() {
          return Container(
            height: controller.isAdditionalServicesClose.value ? 456.h : 120.h,
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: AppColors.primaryDeepBlueLight),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              children: [
                controller.isAdditionalServicesClose.value ? 20.verticalSpace : 0.verticalSpace,
                // search bar
                controller.isAdditionalServicesClose.value ? IField(
                  controller: additionalSearchController,
                  borderColor: AppColors.primaryDeepBlueLight,
                  filled: true,
                  fillColour: AppColors.softGray,
                  hintText: 'Search services provider',
                  hintTextStyle: getTextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),

                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: Image.asset(
                      IconPath.navSearch,
                      height: 24.h,
                      color: Colors.grey.shade800,
                    ),
                  ),
                ) : SizedBox(),

                8.verticalSpace,

                if(controller.isAdditionalServicesClose.value)
                // providers list view
                  Expanded(
                    child: ListView(
                      children: [
                        GestureDetector(
                          onTap: () => AppHelperFunctions.navigateToScreen(context, VendorsScreen()),
                          child: Container(
                            width: double.maxFinite,
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(color: Color(0xFFE9EAEC)),
                              ),
                            ),
                            child: AdditionalServiceCard(
                              img: "https://img.freepik.com/free-photo/restaurant-interior_1127-3394.jpg",
                              title: "Restaurant",
                              isHorizontal: true,
                              onPressed: () {}, // not used since GestureDetector handles tap
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => AppHelperFunctions.navigateToScreen(context, VendorsScreen()),
                          child: Container(
                            width: double.maxFinite,
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(color: Color(0xFFE9EAEC)),
                              ),
                            ),
                            child: AdditionalServiceCard(
                              img: "https://img.freepik.com/free-photo/cyberpunk-dj-illustration_23-2151656004.jpg?w=360",
                              title: "DJ",
                              isHorizontal: true,
                              onPressed: () {},
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => AppHelperFunctions.navigateToScreen(context, VendorsScreen()),
                          child: Container(
                            width: double.maxFinite,
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(color: Color(0xFFE9EAEC)),
                              ),
                            ),
                            child: AdditionalServiceCard(
                              img: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR3SDlFWlQXyO1_sfMyK33r55qYlbw7UgLvUA&s",
                              title: "Photographer",
                              isHorizontal: true,
                              onPressed: () {},
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => AppHelperFunctions.navigateToScreen(context, VendorsScreen()),
                          child: Container(
                            width: double.maxFinite,
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(color: Color(0xFFE9EAEC)),
                              ),
                            ),
                            child: AdditionalServiceCard(
                              img: "https://t4.ftcdn.net/jpg/02/83/46/33/360_F_283463385_mfnrx6RPU3BqObhVuVjYZjeZ5pegE7xq.jpg",
                              title: "Website Developer",
                              isHorizontal: true,
                              onPressed: () {},
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => AppHelperFunctions.navigateToScreen(context, VendorsScreen()),
                          child: Container(
                            width: double.maxFinite,
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(color: Color(0xFFE9EAEC)),
                              ),
                            ),
                            child: AdditionalServiceCard(
                              img: "https://e1.pxfuel.com/desktop-wallpaper/580/502/desktop-wallpaper-best-4-event-planner-backgrounds-on-hip-corporate-event.jpg",
                              title: "Event Planner",
                              isHorizontal: true,
                              onPressed: () {},
                            ),
                          ),
                        ),
                      ],
                    )

                  )
                else
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AdditionalServiceCard(
                        img: "https://img.freepik.com/free-photo/restaurant-interior_1127-3394.jpg",
                        title: "Restaurant",
                        onPressed: () => AppHelperFunctions.navigateToScreen(context, VendorsScreen()),
                      ),

                      AdditionalServiceCard(
                        img: "https://i.pinimg.com/474x/c5/a3/90/c5a3904b38eb241dd03dd30889599dc4.jpg",
                        title: "Doctor",
                        onPressed: () => AppHelperFunctions.navigateToScreen(context, VendorsScreen()),
                      ),
                      AdditionalServiceCard(
                        img: "https://media.istockphoto.com/id/2027278927/photo/young-athletic-woman-exercising-with-barbell-during-sports-training-in-a-gym.jpg?s=612x612&w=0&k=20&c=ifFL7Mqc8NwTj25PAx4ONy1OOQZvc1S_kVOofsbLgFw=",
                        title: "Gym",
                        onPressed: () => AppHelperFunctions.navigateToScreen(context, VendorsScreen()),
                      )
                    ],
                  )
              ],
            ),
          ).paddingSymmetric(horizontal: 20.w);
        }),
      ],
    );
  }
}
