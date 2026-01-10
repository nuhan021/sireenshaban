import 'package:flutter/foundation.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:sireenshaban/core/utils/constants/api_constants.dart';

class ChatMessage {
  final int id;
  final int senderId;
  final int receiverId;
  final String? message;
  final String? voiceUrl;
  final bool isRead;
  final DateTime createdAt;
  final DateTime? deletedAt;
  final Map<String, dynamic>? senderData;

  ChatMessage({
    required this.id,
    required this.senderId,
    required this.receiverId,
    this.message,
    this.voiceUrl,
    required this.isRead,
    required this.createdAt,
    this.deletedAt,
    this.senderData,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    // Handle receiver_id as both string and int
    int receiverId;
    final receiverIdValue = json['receiver_id'];
    if (receiverIdValue is String) {
      receiverId = int.tryParse(receiverIdValue) ?? 0;
    } else if (receiverIdValue is int) {
      receiverId = receiverIdValue;
    } else {
      receiverId = 0;
    }

    return ChatMessage(
      id: json['id'] as int,
      senderId: json['sender_id'] as int,
      receiverId: receiverId,
      message: json['message'] as String?,
      voiceUrl: json['voice_url'] as String?,
      isRead: json['is_read'] == 1 ? true : false,
      createdAt: DateTime.parse(json['created_at'] as String),
      deletedAt: json['deleted_at'] != null
          ? DateTime.parse(json['deleted_at'] as String)
          : null,
      senderData: json['sender'] as Map<String, dynamic>?,
    );
  }

  types.Message toChatUIMessage() {
    final String? imageUrl = _constructImageUrl(senderData?['image']);

    final user = types.User(
      id: senderId.toString(),
      firstName: senderData?['first_name'] ?? 'User',
      lastName: senderData?['last_name'] ?? '',
      imageUrl: imageUrl,
    );

    final status = isRead ? types.Status.seen : types.Status.sent;

    if (voiceUrl != null && voiceUrl!.isNotEmpty) {
      debugPrint('🎙️ [ChatMessage] Creating audio message:');
      debugPrint('   Voice URL from API: $voiceUrl');
      debugPrint('   Voice URL length: ${voiceUrl!.length}');
      debugPrint(
        '   Voice URL is valid HTTP: ${voiceUrl!.startsWith(RegExp(r'^https?://'))}',
      );

      return types.AudioMessage(
        author: user,
        createdAt: createdAt.millisecondsSinceEpoch,
        id: id.toString(),
        uri: voiceUrl!,
        name: 'Voice Message',
        duration: const Duration(seconds: 0),
        size: 0,
        status: status,
      );
    } else {
      return types.TextMessage(
        author: user,
        createdAt: createdAt.millisecondsSinceEpoch,
        id: id.toString(),
        text: message ?? '',
        status: status,
      );
    }
  }

  /// Construct full image URL from relative path
  String? _constructImageUrl(String? imagePath) {
    if (imagePath == null || imagePath.isEmpty) return null;

    // If already a full URL, return as is
    if (imagePath.startsWith('http://') || imagePath.startsWith('https://')) {
      return imagePath.isNotEmpty ? imagePath : null;
    }

    // Convert relative path to full URL
    // Remove leading slashes if present
    final cleanPath = imagePath.startsWith('/')
        ? imagePath.substring(1)
        : imagePath;

    // Construct full URL
    final fullUrl =
        '${ApiConstants.baseUrl.replaceAll('/api/v1', '')}/storage/$cleanPath';
    return fullUrl.isNotEmpty ? fullUrl : null;
  }
}

class ChatConversation {
  final int userId;
  final String name;
  final String email;
  final String? avatar;
  final bool isOnline;
  final DateTime? lastSeen;
  final String lastMessage;
  final String lastMessageTime;
  final int unreadCount;

  ChatConversation({
    required this.userId,
    required this.name,
    required this.email,
    this.avatar,
    required this.isOnline,
    this.lastSeen,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.unreadCount,
  });

  factory ChatConversation.fromJson(Map<String, dynamic> json) {
    try {
      // Handle avatar URL construction
      String? avatarUrl = json['avatar'] as String?;
      if (avatarUrl != null &&
          avatarUrl.isNotEmpty &&
          !avatarUrl.startsWith('http')) {
        avatarUrl =
            '${ApiConstants.baseUrl.replaceAll('/api/v1', '')}/storage/$avatarUrl';
      }

      // Ensure avatarUrl is never an empty string
      if (avatarUrl != null && avatarUrl.isEmpty) {
        avatarUrl = null;
      }

      return ChatConversation(
        userId: json['user_id'] as int,
        name: json['name'] as String,
        email: json['email'] as String,
        avatar: avatarUrl,
        isOnline: json['is_online'] as bool,
        lastSeen:
            json['last_seen'] != null && json['last_seen'].toString().isNotEmpty
            ? DateTime.parse(json['last_seen'] as String)
            : null,
        lastMessage: json['last_message'] as String? ?? '',
        lastMessageTime: json['last_message_time'] as String? ?? '',
        unreadCount: json['unread_count'] as int? ?? 0,
      );
    } catch (e) {
      debugPrint('❌ [ChatConversation] Error parsing: $e');
      debugPrint('   JSON: $json');
      rethrow;
    }
  }
}

class UserStatus {
  final int id;
  final bool isOnline;
  final DateTime? lastSeen;
  final String statusText;

  UserStatus({
    required this.id,
    required this.isOnline,
    this.lastSeen,
    required this.statusText,
  });

  factory UserStatus.fromJson(Map<String, dynamic> json) {
    final isOnline = json['is_online'] as bool;
    final lastSeenStr = json['last_seen'] as String?;
    DateTime? lastSeen;

    if (lastSeenStr != null && lastSeenStr.isNotEmpty) {
      try {
        lastSeen = DateTime.parse(lastSeenStr);
      } catch (e) {
        lastSeen = null;
      }
    }

    // Always construct status text from last_seen and is_online
    String statusText;
    if (isOnline) {
      statusText = 'Online';
    } else if (lastSeen != null) {
      statusText = _formatLastSeen(lastSeen);
    } else {
      statusText = 'Offline';
    }

    return UserStatus(
      id: json['id'] as int,
      isOnline: isOnline,
      lastSeen: lastSeen,
      statusText: statusText,
    );
  }

  /// Format last seen time in user-friendly way
  static String _formatLastSeen(DateTime lastSeen) {
    final now = DateTime.now();
    final difference = now.difference(lastSeen);

    if (difference.inMinutes < 1) {
      return 'Last seen just now';
    } else if (difference.inMinutes < 60) {
      return 'Last seen ${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return 'Last seen ${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return 'Last seen ${difference.inDays}d ago';
    } else {
      return 'Last seen ${lastSeen.toString().split(' ')[0]}';
    }
  }
}
