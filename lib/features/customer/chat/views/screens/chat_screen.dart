import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sireenshaban/core/common/styles/global_text_style.dart';
import 'package:sireenshaban/core/utils/constants/colors.dart';
import 'package:sireenshaban/core/utils/constants/icon_path.dart';
import 'package:sireenshaban/features/customer/chat/controllers/chat_controller.dart';
import 'package:sireenshaban/features/customer/chat/widgets/audio_player_widget.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    super.key,
    required this.receiverId,
    required this.receiverName,
    this.receiverAvatar,
  });

  final int receiverId;
  final String receiverName;
  final String? receiverAvatar;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late ChatController controller;
  late TextEditingController _messageController;

  @override
  void initState() {
    super.initState();
    _messageController = TextEditingController();
    controller = Get.put(ChatController());
    // Initialize chat with receiver data
    controller.initializeChat(
      widget.receiverId,
      widget.receiverName,
      widget.receiverAvatar,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9FAFB),
      appBar: AppBar(
        centerTitle: false,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Container(
            height: 40.h,
            width: 40.w,
            decoration: BoxDecoration(
              color: Color(0xFF3333331A),
              shape: BoxShape.circle,
            ),
            alignment: AlignmentGeometry.center,
            child: Image.asset(IconPath.arrowBack, height: 24.h),
          ),
        ),
        titleSpacing: 0,
        title: ListTile(
          contentPadding: EdgeInsets.zero,
          leading: CircleAvatar(
            backgroundImage: widget.receiverAvatar != null && widget.receiverAvatar!.isNotEmpty
                ? NetworkImage(widget.receiverAvatar!)
                : null,
            backgroundColor: Colors.grey[300],
            child: (widget.receiverAvatar == null || widget.receiverAvatar!.isEmpty) ? Icon(Icons.person) : null,
          ),
          title: Obx(() {
            return Text(
              controller.receiverName.value,
              style: getTextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.bodyDarkGray,
              ),
            );
          }),
          subtitle: Obx(() {
            return Text(
              controller.lastSeenText.value,
              style: getTextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: controller.isOnline.value ? AppColors.success : AppColors.secondaryInfoMediumGray,
              ),
            );
          }),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(
              color: AppColors.primaryDeepBlueNormal,
            ),
          );
        }

        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                reverse: true,
                itemCount: controller.messages.length,
                itemBuilder: (context, index) {
                  final message = controller.messages[index];
                  final isCurrentUser = message.author.id == controller.currentUser.value?.id;

                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    child: Row(
                      mainAxisAlignment:
                          isCurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
                      children: [
                        if (!isCurrentUser)
                          CircleAvatar(
                            backgroundImage: message.author.imageUrl != null && message.author.imageUrl!.isNotEmpty
                                ? NetworkImage(message.author.imageUrl!)
                                : null,
                            backgroundColor: Colors.grey[300],
                            radius: 20.r,
                            child: (message.author.imageUrl == null || message.author.imageUrl!.isEmpty)
                                ? Icon(Icons.person)
                                : null,
                          ),
                        SizedBox(width: 8.w),
                        Flexible(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: 8.h,
                            ),
                            decoration: BoxDecoration(
                              color: isCurrentUser
                                  ? AppColors.primaryDeepBlueNormal
                                  : Colors.grey[300],
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Column(
                              crossAxisAlignment: isCurrentUser
                                  ? CrossAxisAlignment.end
                                  : CrossAxisAlignment.start,
                              children: [
                                if (message is types.TextMessage)
                                  Text(
                                    message.text,
                                    style: getTextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                      color: isCurrentUser ? Colors.white : Colors.black87,
                                    ),
                                  ),
                                if (message is types.AudioMessage)
                                  AudioPlayerWidget(
                                    audioUrl: message.uri,
                                    isCurrentUser: isCurrentUser,
                                  ),
                                SizedBox(height: 4.h),
                                Text(
                                  _formatTime(
                                      DateTime.fromMillisecondsSinceEpoch(
                                          message.createdAt ?? DateTime.now().millisecondsSinceEpoch)),
                                  style: getTextStyle(
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w400,
                                    color: isCurrentUser
                                        ? Colors.white70
                                        : Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (isCurrentUser) SizedBox(width: 8.w),
                        if (isCurrentUser)
                          CircleAvatar(
                            backgroundImage: message.author.imageUrl != null && message.author.imageUrl!.isNotEmpty
                                ? NetworkImage(message.author.imageUrl!)
                                : null,
                            backgroundColor: Colors.grey[300],
                            radius: 20.r,
                            child: (message.author.imageUrl == null || message.author.imageUrl!.isEmpty)
                                ? Icon(Icons.person)
                                : null,
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        hintText: 'Type a message...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24.r),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey[100],
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 12.h,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  GestureDetector(
                    onTap: () {
                      if (_messageController.text.isNotEmpty) {
                        controller.handleSendTextMessage(
                          types.PartialText(text: _messageController.text),
                        );
                        _messageController.clear();
                      }
                    },
                    child: CircleAvatar(
                      backgroundColor: AppColors.primaryDeepBlueNormal,
                      radius: 22.r,
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 20.sp,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  GestureDetector(
                    onTap: controller.toggleVoiceRecording,
                    child: Obx(() {
                      return CircleAvatar(
                        backgroundColor: controller.isRecording.value
                            ? Colors.red
                            : AppColors.primaryDeepBlueNormal,
                        radius: 22.r,
                        child: Icon(
                          controller.isRecording.value
                              ? Icons.stop_circle
                              : Icons.mic,
                          color: Colors.white,
                          size: 20.sp,
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }

  String _formatTime(DateTime dateTime) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final messageDate = DateTime(dateTime.year, dateTime.month, dateTime.day);

    if (messageDate == today) {
      return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    } else if (messageDate == yesterday) {
      return 'Yesterday';
    } else {
      return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    Get.delete<ChatController>();
    super.dispose();
  }
}
