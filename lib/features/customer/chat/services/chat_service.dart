import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:sireenshaban/core/services/pusher/pusher_service.dart';
import 'package:sireenshaban/core/services/storage_service.dart';
import 'package:sireenshaban/core/utils/constants/api_constants.dart';
import 'package:sireenshaban/features/customer/chat/models/chat_model.dart';

class ChatService {
  final String token = StorageService.token ?? '';
  final PusherService _pusherService = PusherService();

  Map<String, String> get _headers => {
    'Authorization': 'Bearer $token',
    'Accept': 'application/json',
    'Content-Type': 'application/json',
  };

  Future<List<ChatMessage>> fetchChatHistory(int receiverId) async {
    try {
      debugPrint('📱 [Chat] Fetching history with receiver ID: $receiverId');
      final response = await http.get(
        Uri.parse('${ApiConstants.chatHistory}/$receiverId'),
        headers: _headers,
      ).timeout(const Duration(seconds: 30));

      debugPrint('📱 [Chat] History fetch status: ${response.statusCode}');
      debugPrint('📱 [Chat] History response: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        if (data['success'] == true) {
          final messages = (data['messages'] as List)
              .map((msg) => ChatMessage.fromJson(msg as Map<String, dynamic>))
              .toList();
          debugPrint('✅ [Chat] Successfully loaded ${messages.length} messages');
          return messages;
        }
      }
      debugPrint('❌ [Chat] Failed to fetch history: ${response.statusCode}');
      return [];
    } catch (e) {
      debugPrint('❌ [Chat] Error fetching chat history: $e');
      return [];
    }
  }

  Future<ChatMessage?> sendTextMessage(int receiverId, String text) async {
    try {
      final senderId = StorageService.userId;
      debugPrint('📱 [Chat] Sending text message');
      debugPrint('   From: $senderId');
      debugPrint('   To: $receiverId');
      debugPrint('📱 [Chat] Message text: "$text"');

      final body = jsonEncode({
        'receiver_id': receiverId.toString(),
        'message': text,
      });
      debugPrint('📱 [Chat] Request body: $body');

      final response = await http.post(
        Uri.parse(ApiConstants.sendMessage),
        headers: _headers,
        body: body,
      ).timeout(const Duration(seconds: 30));

      debugPrint('📱 [Chat] Send message status: ${response.statusCode}');
      debugPrint('📱 [Chat] Send message response: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        if (data['success'] == true) {
          final message = ChatMessage.fromJson(data['message'] as Map<String, dynamic>);
          debugPrint('✅ [Chat] Message sent successfully');
          debugPrint('   Message ID: ${message.id}');
          debugPrint('   From: ${message.senderId}');
          debugPrint('   To: ${message.receiverId}');
          debugPrint('   Text: "${message.message}"');
          return message;
        }
      }
      debugPrint('❌ [Chat] Failed to send message: ${response.statusCode}');
      return null;
    } catch (e) {
      debugPrint('❌ [Chat] Error sending text message: $e');
      return null;
    }
  }

  Future<ChatMessage?> sendVoiceMessage(int receiverId, File voiceFile) async {
    try {
      final senderId = StorageService.userId;
      debugPrint('📱 [Chat] Sending voice message');
      debugPrint('   From: $senderId');
      debugPrint('   To: $receiverId');
      debugPrint('📱 [Chat] Voice file path: ${voiceFile.path}');
      debugPrint('📱 [Chat] Voice file size: ${voiceFile.lengthSync()} bytes');
      debugPrint('📱 [Chat] Voice file exists: ${voiceFile.existsSync()}');

      final request = http.MultipartRequest('POST', Uri.parse(ApiConstants.sendMessage));
      request.headers.addAll({
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      });

      request.fields['receiver_id'] = receiverId.toString();
      request.files.add(
        await http.MultipartFile.fromPath('voice', voiceFile.path),
      );

      debugPrint('📱 [Chat] Sending voice request...');
      final streamedResponse = await request.send().timeout(const Duration(seconds: 30));
      final response = await http.Response.fromStream(streamedResponse);

      debugPrint('📱 [Chat] Voice send status: ${response.statusCode}');
      debugPrint('📱 [Chat] Voice send response: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        if (data['success'] == true) {
          final message = ChatMessage.fromJson(data['message'] as Map<String, dynamic>);
          debugPrint('✅ [Chat] Voice message sent successfully with ID: ${message.id}');
          debugPrint('   Voice URL: ${message.voiceUrl}');
          return message;
        }
      }
      debugPrint('❌ [Chat] Failed to send voice message: ${response.statusCode}');
      return null;
    } catch (e) {
      debugPrint('❌ [Chat] Error sending voice message: $e');
      return null;
    }
  }

  Future<bool> markMessagesAsRead(int senderId) async {
    try {
      debugPrint('📱 [Chat] Marking messages from sender $senderId as read');
      final response = await http.post(
        Uri.parse(ApiConstants.markRead),
        headers: _headers,
        body: jsonEncode({'sender_id': senderId}),
      ).timeout(const Duration(seconds: 30));

      debugPrint('📱 [Chat] Mark read status: ${response.statusCode}');
      debugPrint('📱 [Chat] Mark read response: ${response.body}');

      if (response.statusCode == 200) {
        debugPrint('✅ [Chat] Messages marked as read');
        return true;
      }
      return false;
    } catch (e) {
      debugPrint('❌ [Chat] Error marking messages as read: $e');
      return false;
    }
  }

  Future<UserStatus?> getUserStatus(int contactId) async {
    try {
      debugPrint('📱 [Chat] Fetching user status for contact: $contactId');
      final response = await http.get(
        Uri.parse('${ApiConstants.userStatus}/$contactId/status'),
        headers: _headers,
      ).timeout(const Duration(seconds: 30));

      debugPrint('📱 [Chat] User status fetch: ${response.statusCode}');
      debugPrint('📱 [Chat] User status response: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        if (data['success'] == true) {
          final status = UserStatus.fromJson(data['receiver'] as Map<String, dynamic>);
          debugPrint('✅ [Chat] User status: ${status.statusText}');
          return status;
        }
      }
      return null;
    } catch (e) {
      debugPrint('❌ [Chat] Error fetching user status: $e');
      return null;
    }
  }

  Future<List<ChatConversation>> fetchChatList() async {
    try {
      debugPrint('📱 [Chat] Fetching chat list...');
      final response = await http.get(
        Uri.parse(ApiConstants.chatList),
        headers: _headers,
      ).timeout(const Duration(seconds: 30));

      debugPrint('📱 [Chat] Chat list fetch: ${response.statusCode}');
      debugPrint('📱 [Chat] Chat list response: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        debugPrint('📱 [Chat] Parsing response...');
        
        if (data['success'] == true) {
          final messagesData = data['messages'];
          debugPrint('📱 [Chat] Messages type: ${messagesData.runtimeType}');
          debugPrint('📱 [Chat] Messages count: ${(messagesData as List?)?.length ?? 0}');
          
          if (messagesData is List && messagesData.isNotEmpty) {
            try {
              final conversations = messagesData
                  .map((msg) {
                    debugPrint('📱 [Chat] Parsing conversation:');
                    debugPrint('   User ID: ${msg['user_id']}');
                    debugPrint('   Name: ${msg['name']}');
                    debugPrint('   Last Message: ${msg['last_message']}');
                    return ChatConversation.fromJson(msg as Map<String, dynamic>);
                  })
                  .toList();
              debugPrint('✅ [Chat] Successfully loaded ${conversations.length} conversations');
              return conversations;
            } catch (e) {
              debugPrint('❌ [Chat] Error parsing conversations: $e');
              return [];
            }
          } else {
            debugPrint('⚠️ [Chat] Messages is empty or not a list');
            return [];
          }
        } else {
          debugPrint('⚠️ [Chat] Success is false');
          return [];
        }
      }
      debugPrint('❌ [Chat] Chat list fetch failed: ${response.statusCode}');
      return [];
    } catch (e) {
      debugPrint('❌ [Chat] Error fetching chat list: $e');
      return [];
    }
  }

  Future<bool> saveFcmToken(String fcmToken) async {
    try {
      debugPrint('📱 [Chat] Saving FCM token: ${fcmToken.substring(0, 20)}...');
      final response = await http.post(
        Uri.parse(ApiConstants.saveFcmToken),
        headers: _headers,
        body: jsonEncode({'fcm_token': fcmToken}),
      ).timeout(const Duration(seconds: 30));

      debugPrint('📱 [Chat] FCM token save: ${response.statusCode}');
      debugPrint('📱 [Chat] FCM response: ${response.body}');

      if (response.statusCode == 200) {
        debugPrint('✅ [Chat] FCM token saved successfully');
        return true;
      }
      return false;
    } catch (e) {
      debugPrint('❌ [Chat] Error saving FCM token: $e');
      return false;
    }
  }

  // PUSHER INTEGRATION METHODS
  
  /// Setup Pusher for real-time chat
  Future<bool> setupPusherForChat(int userId, String pusherKey, String pusherCluster) async {
    try {
      debugPrint('🔌 [Chat] Setting up Pusher for user: $userId');
      
      final initialized = await _pusherService.initialize(
        key: pusherKey,
        cluster: pusherCluster,
        userId: userId.toString(),
      );
      
      if (!initialized) {
        debugPrint('❌ [Chat] Failed to initialize Pusher');
        return false;
      }
      
      final connected = await _pusherService.connect();
      if (!connected) {
        debugPrint('❌ [Chat] Failed to connect Pusher');
        return false;
      }
      
      debugPrint('✅ [Chat] Pusher setup completed');
      return true;
    } catch (e) {
      debugPrint('❌ [Chat] Error setting up Pusher: $e');
      return false;
    }
  }

  /// Subscribe to private chat channel for real-time messages
  /// Pattern: private-chat-{userId}-{otherUserId}
  Future<bool> subscribeToPrivateChatChannel({
    required int userId,
    required int otherUserId,
    required Function(dynamic) onNewMessage,
    required Function(dynamic) onStatusChange,
  }) async {
    try {
      // Sort IDs to create consistent channel name regardless of direction
      final ids = [userId, otherUserId]..sort();
      final channelName = 'private-chat-${ids[0]}-${ids[1]}';
      
      debugPrint('🔐 [Chat] Subscribing to private channel: $channelName');
      
      final subscribed = await _pusherService.subscribeToPrivateChannel(
        channelName: channelName,
        authorizationUrl: '${ApiConstants.baseUrl}/pusher/auth',
        onEvent: (event) {
          debugPrint('📬 [Chat] Event on $channelName: ${event.eventName}');
          
          if (event.eventName == 'new-message') {
            onNewMessage(event.data);
          } else if (event.eventName == 'user-status-changed') {
            onStatusChange(event.data);
          }
        },
      );
      
      if (subscribed) {
        debugPrint('✅ [Chat] Successfully subscribed to $channelName');
      }
      return subscribed;
    } catch (e) {
      debugPrint('❌ [Chat] Error subscribing to chat channel: $e');
      return false;
    }
  }

  /// Subscribe to user presence channel for online/offline status
  /// Pattern: presence-user-{userId}
  Future<bool> subscribeToUserPresenceChannel({
    required int userId,
    required Function(dynamic) onStatusChange,
  }) async {
    try {
      final channelName = 'presence-user-$userId';
      
      debugPrint('👤 [Chat] Subscribing to presence channel: $channelName');
      
      // Note: Presence channels require special auth, using public channel as fallback
      final subscribed = await _pusherService.subscribeToChannel(
        channelName: channelName,
        onEvent: (event) {
          debugPrint('👥 [Chat] Presence event: ${event.eventName}');
          onStatusChange(event.data);
        },
      );
      
      if (subscribed) {
        debugPrint('✅ [Chat] Successfully subscribed to $channelName');
      }
      return subscribed;
    } catch (e) {
      debugPrint('❌ [Chat] Error subscribing to presence channel: $e');
      return false;
    }
  }

  /// Unsubscribe from chat channel
  Future<bool> unsubscribeFromChatChannel(int userId, int otherUserId) async {
    try {
      final ids = [userId, otherUserId]..sort();
      final channelName = 'private-chat-${ids[0]}-${ids[1]}';
      
      debugPrint('🔌 [Chat] Unsubscribing from channel: $channelName');
      
      return await _pusherService.unsubscribe(channelName: channelName);
    } catch (e) {
      debugPrint('❌ [Chat] Error unsubscribing: $e');
      return false;
    }
  }

  /// Disconnect Pusher connection (cleanup)
  Future<bool> disconnectPusher() async {
    try {
      debugPrint('🔌 [Chat] Disconnecting Pusher...');
      return await _pusherService.disconnect();
    } catch (e) {
      debugPrint('❌ [Chat] Error disconnecting Pusher: $e');
      return false;
    }
  }
}

