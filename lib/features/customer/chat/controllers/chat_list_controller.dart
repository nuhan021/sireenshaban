import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:sireenshaban/features/customer/chat/models/chat_model.dart';
import 'package:sireenshaban/features/customer/chat/services/chat_service.dart';

class ChatListController extends GetxController {
  final ChatService _chatService = ChatService();

  RxList<ChatConversation> conversations = RxList<ChatConversation>();
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadConversations();
  }

  Future<void> _loadConversations() async {
    isLoading.value = true;
    debugPrint('📋 [ChatListController] Loading conversations...');
    try {
      final chats = await _chatService.fetchChatList();
      conversations.value = chats;
      debugPrint('✅ [ChatListController] Loaded ${chats.length} conversations');
      for (var chat in chats) {
        debugPrint('   - ${chat.name} (ID: ${chat.userId}, Unread: ${chat.unreadCount})');
      }
    } catch (e) {
      debugPrint('❌ [ChatListController] Error loading conversations: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshConversations() async {
    await _loadConversations();
  }
}

