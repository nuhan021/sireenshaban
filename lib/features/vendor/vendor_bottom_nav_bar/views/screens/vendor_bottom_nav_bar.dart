import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:sireenshaban/core/common/styles/global_text_style.dart';
import 'package:sireenshaban/core/utils/constants/colors.dart';
import 'package:sireenshaban/features/customer/chat/views/screens/chat_list_screen.dart';
import 'package:sireenshaban/features/vendor/vendor_booking_request/views/screens/vendor_booking_request_screen.dart';
import 'package:sireenshaban/features/vendor/vendor_bottom_nav_bar/controller/vendor_bottom_nav_bar_controller.dart';
import 'package:sireenshaban/features/vendor/vendor_home/views/screens/vendor_home_screen.dart';
import 'package:sireenshaban/features/vendor/vendor_profile/views/screens/vendor_profile_screen.dart';
import 'package:sireenshaban/features/vendor/vendor_schedule/views/screens/vendor_schedule_screen.dart';

import '../../../../../core/utils/constants/icon_path.dart';

class VendorBottomNavBar extends StatelessWidget {
  VendorBottomNavBar({super.key});

  final VendorBottomNavBarController navaberController = Get.put(VendorBottomNavBarController());

  List<Widget> _buildScreens() {
    return [
      VendorHomeScreen(),
      VendorBookingRequestScreen(),
      VendorScheduleScreen(),
      ChatListScreen(),
      VendorProfileScreen(),
    ];
  }


  List<PersistentTabConfig> _tabs() => [
    PersistentTabConfig(
      screen: _buildScreens()[0],
      item: ItemConfig(
        icon: Obx(
                () {
              return Image.asset(
                width: 20.w,
                navaberController.currentIndex.value == 0 ? IconPath.navFillHome :IconPath.navHome,
              );
            }
        ),
        title: "Home",
        textStyle: getTextStyle(fontSize: 10.sp, fontWeight: FontWeight.w500),
        activeForegroundColor: AppColors.primaryDeepBlueNormal,
        inactiveForegroundColor: AppColors.secondaryInfoMediumGrayNormal,
      ),
    ),

    PersistentTabConfig(
      screen: _buildScreens()[1],
      item: ItemConfig(
        icon: Obx(
                () {
              return Image.asset(
                width: 20.w,
                navaberController.currentIndex.value == 1 ? IconPath.ticketFill :IconPath.ticket,
              );
            }
        ),
        title: "Request",
        textStyle: getTextStyle(fontSize: 10.sp, fontWeight: FontWeight.w500),
        activeForegroundColor: AppColors.primaryDeepBlueNormal,
        inactiveForegroundColor: AppColors.secondaryInfoMediumGrayNormal,
      ),
    ),

    PersistentTabConfig(
      screen: _buildScreens()[2],
      item: ItemConfig(
        icon: Obx(
                () {
              return Image.asset(
                width: 20.w,
                navaberController.currentIndex.value == 2 ? IconPath.navFillCalendar :IconPath.navCalendar,
              );
            }
        ),
        title: "Schedule",
        textStyle: getTextStyle(fontSize: 10.sp, fontWeight: FontWeight.w500),
        activeForegroundColor: AppColors.primaryDeepBlueNormal,
        inactiveForegroundColor: AppColors.secondaryInfoMediumGrayNormal,
      ),
    ),

    PersistentTabConfig(
      screen: _buildScreens()[3],
      item: ItemConfig(
        icon: Obx(
                () {
              return Image.asset(
                width: 20.w,
                navaberController.currentIndex.value == 3 ? IconPath.navFillMessage :IconPath.navMessage,
              );
            }
        ),
        title: "Chat",
        textStyle: getTextStyle(fontSize: 10.sp, fontWeight: FontWeight.w500),
        activeForegroundColor: AppColors.primaryDeepBlueNormal,
        inactiveForegroundColor: AppColors.secondaryInfoMediumGrayNormal,
      ),
    ),

    PersistentTabConfig(
      screen: _buildScreens()[4],
      item: ItemConfig(
        icon: Obx(
                () {
              return Image.asset(
                width: 20.w,
                navaberController.currentIndex.value == 4 ? IconPath.navFillProfile :IconPath.navProfile,
              );
            }
        ),
        title: "Profile",
        textStyle: getTextStyle(fontSize: 10.sp, fontWeight: FontWeight.w500),
        activeForegroundColor: AppColors.primaryDeepBlueNormal,
        inactiveForegroundColor: AppColors.secondaryInfoMediumGrayNormal,
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      controller: navaberController.controller,

      tabs: _tabs(),
      navBarBuilder: (navBarConfig) => Style1BottomNavBar(navBarConfig: navBarConfig, height: 60.h),
      onTabChanged: (index) {
        navaberController.changeCurrentIndex(index);
      },
    );
  }
}
