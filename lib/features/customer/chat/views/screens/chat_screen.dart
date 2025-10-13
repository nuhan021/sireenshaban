import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sireenshaban/core/common/styles/global_text_style.dart';
import 'package:sireenshaban/core/utils/constants/colors.dart';

import '../../../../../core/utils/constants/icon_path.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.avatar, required this.name});

  final String avatar;
  final String name;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  final _chatController = InMemoryChatController();

  @override
  void initState() {
    super.initState();
    _chatController.insertMessage(
      AudioMessage(
        id: '${Random().nextInt(1000) + 1}',
        authorId: 'user1',
        createdAt: DateTime.now().toUtc(),
        source: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
        duration: Duration(seconds: 10),
      ),
    );
  }

  @override
  void dispose() {
    _chatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE9EBF3),
      appBar: AppBar(
        centerTitle: false,
        leading: IconButton(
          onPressed: () {},
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
          leading: CircleAvatar(
            backgroundImage: NetworkImage(widget.avatar),
            backgroundColor: Colors.white,
          ),

          title: Text(
            widget.name,
            style: getTextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.bodyDarkGray,
            ),
          ),

          subtitle: Text(
            'Active',
            style: getTextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.success,
            ),
          ),
        ),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.more_vert_outlined))
        ],
      ),
      body: Chat(
        backgroundColor: Color(0xFFE9EBF3),
        chatController: _chatController,
        currentUserId: 'user1',
        builders: Builders(
          audioMessageBuilder: (
              BuildContext context,
              AudioMessage message,
              int index, {
                MessageGroupStatus? groupStatus,
                required bool isSentByMe,
              }) {
            return Container(
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.symmetric(vertical: 4),
              decoration: BoxDecoration(
                color: isSentByMe ? Colors.blue[100] : Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.play_arrow),
                    onPressed: () {
                      // এখানে অডিও প্লে করার কোড দিতে হবে

                    },
                  ),
                  Expanded(
                    child: Text(
                      'Audio Message',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
            );
          },

        ),

        onMessageSend: (text) {
          _chatController.insertMessage(
            TextMessage(
              // Better to use UUID or similar for the ID - IDs must be unique
              id: '${Random().nextInt(1000) + 1}',
              authorId: 'user1',
              createdAt: DateTime.now().toUtc(),
              text: text,
            ),
          );
        },
        resolveUser: (UserID id) async {
          return User(id: id, name: 'John Doe');
        },
      ),
    );
  }
}
