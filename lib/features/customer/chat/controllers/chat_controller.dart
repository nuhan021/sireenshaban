import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:uuid/uuid.dart';
import 'package:sireenshaban/core/services/storage_service.dart';
import 'package:sireenshaban/features/customer/chat/services/chat_service.dart';

class ChatController extends GetxController {
  final ChatService _chatService = ChatService();
  final AudioRecorder _audioRecorder = AudioRecorder();

  RxInt receiverId = RxInt(0);
  RxString receiverName = RxString('');
  Rx<String?> receiverAvatar = Rx<String?>(null);

  RxList<types.Message> messages = RxList<types.Message>();
  RxBool isLoading = false.obs;
  RxBool isRecording = false.obs;
  RxBool isOnline = false.obs;
  RxString lastSeenText = 'Offline'.obs;
  Rx<types.User?> currentUser = Rx<types.User?>(null);

  String? _recordingPath;

  @override
  void onInit() {
    super.onInit();
    _initCurrentUser();
    _setupPusher();
  }

  void initializeChat(int id, String name, String? avatar) {
    debugPrint('🎯 [ChatController] Initializing chat with receiver:');
    debugPrint('   ID: $id');
    debugPrint('   Name: $name');
    debugPrint('   Avatar: $avatar');

    receiverId.value = id;
    receiverName.value = name;
    receiverAvatar.value = avatar;

    debugPrint('✅ [ChatController] Chat initialized, loading data...');
    _loadChatHistory();
    _loadUserStatus();
  }

  void _initCurrentUser() {
    final userId = StorageService.userId;
    if (userId != null) {
      currentUser.value = types.User(id: userId);
      debugPrint('✅ [ChatController] Current user ID set: $userId');
    } else {
      debugPrint('⚠️ [ChatController] No user ID found in storage');
    }
  }

  Future<void> _loadChatHistory() async {
    if (receiverId.value == 0) {
      debugPrint('⚠️ [ChatController] Cannot load history - receiver ID is 0');
      return;
    }

    isLoading.value = true;
    debugPrint('📥 [ChatController] Loading chat history');
    debugPrint('   Current user: ${currentUser.value?.id}');
    debugPrint('   Receiver: ${receiverId.value}');

    try {
      final chatMessages = await _chatService.fetchChatHistory(
        receiverId.value,
      );
      messages.value = chatMessages
          .map((msg) {
            debugPrint(
              '   Message ID: ${msg.id}, From: ${msg.senderId}, To: ${msg.receiverId}, Text: "${msg.message}"',
            );
            return msg.toChatUIMessage();
          })
          .toList()
          .reversed
          .toList();

      debugPrint('✅ [ChatController] Loaded ${messages.length} messages');
      await _chatService.markMessagesAsRead(receiverId.value);
      debugPrint('✅ [ChatController] Messages marked as read');
    } catch (e) {
      debugPrint('❌ [ChatController] Error loading chat history: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _loadUserStatus() async {
    if (receiverId.value == 0) {
      debugPrint('⚠️ [ChatController] Cannot load status - receiver ID is 0');
      return;
    }

    debugPrint(
      '👤 [ChatController] Loading user status for receiver: ${receiverId.value}',
    );

    try {
      final status = await _chatService.getUserStatus(receiverId.value);
      if (status != null) {
        isOnline.value = status.isOnline;
        lastSeenText.value = status.statusText;
        debugPrint('✅ [ChatController] User status: ${status.statusText}');
      } else {
        debugPrint('⚠️ [ChatController] Could not fetch user status');
      }
    } catch (e) {
      debugPrint('❌ [ChatController] Error loading user status: $e');
    }
  }

  void handleSendTextMessage(types.PartialText message) async {
    if (message.text.trim().isEmpty) {
      debugPrint('⚠️ [ChatController] Ignoring empty message');
      return;
    }

    debugPrint('📤 [ChatController] Sending text message:');
    debugPrint('   From: ${currentUser.value?.id}');
    debugPrint('   To: ${receiverId.value}');
    debugPrint('   Text: "${message.text}"');

    final optimisticMessage = types.TextMessage(
      author: currentUser.value!,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: message.text,
      status: types.Status.sending,
    );

    messages.insert(0, optimisticMessage);
    debugPrint(
      '💬 [ChatController] Added optimistic message with ID: ${optimisticMessage.id}',
    );

    try {
      final sentMessage = await _chatService.sendTextMessage(
        receiverId.value,
        message.text,
      );
      if (sentMessage != null) {
        debugPrint('✅ [ChatController] Server confirmed message');
        debugPrint('   Message ID: ${sentMessage.id}');
        debugPrint('   From: ${sentMessage.senderId}');
        debugPrint('   To: ${sentMessage.receiverId}');

        messages.removeWhere((msg) => msg.id == optimisticMessage.id);
        messages.insert(0, sentMessage.toChatUIMessage());
        debugPrint('✅ [ChatController] Message sent and UI updated');
      } else {
        _updateMessageStatus(optimisticMessage.id, types.Status.error);
        debugPrint(
          '❌ [ChatController] Server returned null - message not sent',
        );
      }
    } catch (e) {
      _updateMessageStatus(optimisticMessage.id, types.Status.error);
      debugPrint('❌ [ChatController] Error sending message: $e');
    }
  }

  Future<void> toggleVoiceRecording() async {
    if (isRecording.value) {
      debugPrint('🎤 [ChatController] Stopping voice recording...');
      await _stopRecordingAndSend();
    } else {
      debugPrint('🎤 [ChatController] Starting voice recording...');
      await _startRecording();
    }
  }

  Future<void> _startRecording() async {
    try {
      if (await _audioRecorder.hasPermission()) {
        final directory = await getApplicationDocumentsDirectory();
        _recordingPath = '${directory.path}/${const Uuid().v4()}.m4a';

        debugPrint('🎤 [ChatController] Recording to: $_recordingPath');

        await _audioRecorder.start(const RecordConfig(), path: _recordingPath!);

        isRecording.value = true;
        debugPrint('✅ [ChatController] Voice recording started');
      } else {
        debugPrint('❌ [ChatController] No microphone permission');
      }
    } catch (e) {
      debugPrint('❌ [ChatController] Error starting recording: $e');
    }
  }

  Future<void> _stopRecordingAndSend() async {
    try {
      final path = await _audioRecorder.stop();
      isRecording.value = false;

      if (path != null) {
        debugPrint('✅ [ChatController] Recording stopped at: $path');
        await _sendVoiceMessage(File(path));
      } else {
        debugPrint('⚠️ [ChatController] Recording returned null path');
      }
    } catch (e) {
      debugPrint('❌ [ChatController] Error stopping recording: $e');
    }
  }

  Future<void> _sendVoiceMessage(File voiceFile) async {
    debugPrint('📤 [ChatController] Sending voice message:');
    debugPrint('   To: ${receiverId.value}');
    debugPrint('   File size: ${voiceFile.lengthSync()} bytes');

    final optimisticMessage = types.AudioMessage(
      author: currentUser.value!,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      name: 'Voice Message',
      duration: const Duration(seconds: 0),
      size: voiceFile.lengthSync(),
      uri: voiceFile.path,
      status: types.Status.sending,
    );

    messages.insert(0, optimisticMessage);
    debugPrint(
      '🎤 [ChatController] Added optimistic voice message with ID: ${optimisticMessage.id}',
    );

    try {
      final sentMessage = await _chatService.sendVoiceMessage(
        receiverId.value,
        voiceFile,
      );
      if (sentMessage != null) {
        messages.removeWhere((msg) => msg.id == optimisticMessage.id);
        messages.insert(0, sentMessage.toChatUIMessage());
        debugPrint('✅ [ChatController] Voice message sent and UI updated');
      } else {
        _updateMessageStatus(optimisticMessage.id, types.Status.error);
        debugPrint(
          '❌ [ChatController] Server returned null - voice message not sent',
        );
      }
    } catch (e) {
      _updateMessageStatus(optimisticMessage.id, types.Status.error);

    }
  }

  void _updateMessageStatus(String messageId, types.Status status) {
    final index = messages.indexWhere((msg) => msg.id == messageId);
    if (index != -1) {
      messages[index] = messages[index].copyWith(status: status);
      debugPrint(
        '📝 [ChatController] Updated message $messageId status to: $status',
      );
    }
  }

  void _setupPusher() {
  
  }






  @override
  void onClose() {
    _audioRecorder.dispose();
    _chatService.disconnectPusher();
    super.onClose();
  }
}
