import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sireenshaban/core/common/styles/global_text_style.dart';
import 'package:sireenshaban/core/utils/constants/colors.dart';
import 'package:sireenshaban/core/utils/constants/icon_path.dart';
import 'package:sireenshaban/core/utils/helpers/app_helper.dart';
import 'package:sireenshaban/features/customer/chat/controller/chat_controller.dart';
import 'package:sireenshaban/features/customer/chat/views/screens/chat_screen.dart';

import '../../../../../routes/app_routes.dart';

class ChatListScreen extends StatelessWidget {
  ChatListScreen({super.key});

  ChatController controller = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'Chat',
          style: getTextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.bodyDarkGray,
          ),
        ),

        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed(AppRoute.getNotificationScreen());
            },
            icon: Container(
              height: 40.h,
              width: 40.w,
              decoration: BoxDecoration(
                color: Color(0xFF3333331A),
                shape: BoxShape.circle,
              ),
              alignment: AlignmentGeometry.center,
              child: Image.asset(IconPath.notification, height: 24.h),
            ),
          ),
        ],
      ),

      body: Expanded(
        child: ListView.builder(
          itemCount: controller.chats.length,
          itemBuilder: (context, index) => ListTile(
            onTap: () {
              Get.to(ChatScreen(avatar: controller.chats[index].avatar, name: controller.chats[index].name));
            },
            leading: CircleAvatar(
              radius: 25.r,
              backgroundImage: NetworkImage(controller.chats[index].avatar),
              backgroundColor: Colors.white,
            ),

            title: Text(
              controller.chats[index].name,
              style: getTextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.bodyDarkGray,
              ),
            ),

            subtitle: Text(
              controller.chats[index].lastMessage,
              overflow: TextOverflow.ellipsis,
              style: getTextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: Color(0xFF25282D),
              ),
            ),

            trailing: Text(
              controller.chats[index].time,
              style: getTextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.secondaryInfoMediumGrayNormal,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
