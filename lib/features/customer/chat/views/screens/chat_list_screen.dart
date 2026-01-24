import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sireenshaban/core/common/styles/global_text_style.dart';
import 'package:sireenshaban/core/utils/constants/colors.dart';
import 'package:sireenshaban/features/customer/chat/controllers/chat_list_controller.dart';
import 'package:sireenshaban/routes/app_routes.dart';

class ChatListScreen extends StatelessWidget {
  ChatListScreen({super.key});

  final controller = Get.put(ChatListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'Messages',
          style: getTextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.bodyDarkGray,
          ),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value && controller.conversations.isEmpty) {
          return Center(
            child: CircularProgressIndicator(
              color: AppColors.primaryDeepBlueNormal,
            ),
          );
        }

        if (controller.conversations.isEmpty) {
          return RefreshIndicator(
            onRefresh: () => controller.refreshConversations(),
            color: AppColors.primaryDeepBlueNormal,
            child: ListView(
              physics: AlwaysScrollableScrollPhysics(),
              children: [
                SizedBox(height: 150.h),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.chat_bubble_outline,
                        size: 64.sp,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        'No conversations yet',
                        style: getTextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.bodyDarkGray,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () => controller.refreshConversations(),
          color: AppColors.primaryDeepBlueNormal,
          child: ListView.builder(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            itemCount: controller.conversations.length,
            itemBuilder: (context, index) {
              final conversation = controller.conversations[index];
              return ChatListTile(
                conversation: conversation,
                onTap: () {
                  Get.toNamed(
                    AppRoute.chatScreen,
                    arguments: {
                      'receiverId': conversation.userId,
                      'receiverName': conversation.name,
                      'receiverAvatar': conversation.avatar,
                    },
                  );
                },
              );
            },
          ),
        );
      }),
    );
  }
}

class ChatListTile extends StatelessWidget {
  final dynamic conversation;
  final VoidCallback onTap;

  const ChatListTile({
    super.key,
    required this.conversation,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Color(0xFFE5E5E5), width: 0.5),
          ),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28.r,
              backgroundImage:
                  conversation.avatar != null && conversation.avatar!.isNotEmpty
                  ? NetworkImage(conversation.avatar!)
                  : null,
              backgroundColor: Colors.grey[300],
              child:
                  (conversation.avatar == null || conversation.avatar!.isEmpty)
                  ? Icon(Icons.person, color: Colors.grey[600])
                  : null,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          conversation.name,
                          style: getTextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.bodyDarkGray,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        conversation.lastMessageTime,
                        style: getTextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.secondaryInfoMediumGray,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          conversation.lastMessage,
                          style: getTextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.secondaryInfoMediumGray,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (conversation.unreadCount > 0)
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 6.w,
                            vertical: 2.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.success,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Text(
                            conversation.unreadCount.toString(),
                            style: getTextStyle(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
