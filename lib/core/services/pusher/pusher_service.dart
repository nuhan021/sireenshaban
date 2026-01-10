import 'package:flutter/foundation.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

class PusherService {
  static final PusherService _instance = PusherService._internal();

  factory PusherService() {
    return _instance;
  }

  PusherService._internal();

  final PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();
  bool _isInitialized = false;

  Future<bool> initialize({
    required String key,
    required String cluster,
    required String userId,
  }) async {
    try {
      if (_isInitialized) {
        debugPrint('✅ [Pusher] Already initialized');
        return true;
      }

      debugPrint(
        '🔌 [Pusher] Initializing with key: ${key.substring(0, 10)}..., cluster: $cluster',
      );

      await pusher.init(apiKey: key, cluster: cluster, useTLS: true);

      debugPrint('✅ [Pusher] Initialization complete');
      _isInitialized = true;
      return true;
    } catch (e) {
      debugPrint('❌ [Pusher] Initialization failed: $e');
      return false;
    }
  }

  Future<bool> subscribeToChannel({
    required String channelName,
    required Function(dynamic) onEvent,
    String? onSubscriptionSucceeded,
    String? onSubscriptionError,
  }) async {
    try {
      debugPrint('📢 [Pusher] Subscribing to channel: $channelName');

      await pusher.subscribe(
        channelName: channelName,
        onEvent: (event) {
          debugPrint(
            '📬 [Pusher] Event received on $channelName: ${event.eventName}',
          );
          onEvent(event);
        },
        onSubscriptionSucceeded: onSubscriptionSucceeded != null
            ? (subscription) {
                debugPrint('✅ [Pusher] Subscription to $channelName succeeded');
              }
            : null,
        onSubscriptionError: onSubscriptionError != null
            ? (error) {
                debugPrint(
                  '❌ [Pusher] Subscription to $channelName error: $error',
                );
              }
            : null,
      );

      debugPrint('✅ [Pusher] Successfully subscribed to $channelName');
      return true;
    } catch (e) {
      debugPrint('❌ [Pusher] Error subscribing to channel: $e');
      return false;
    }
  }

  Future<bool> subscribeToPrivateChannel({
    required String channelName,
    required String authorizationUrl,
    required Function(dynamic) onEvent,
  }) async {
    try {
      debugPrint('🔐 [Pusher] Subscribing to private channel: $channelName');

      await pusher.subscribe(
        channelName: channelName,
        onEvent: (event) {
          debugPrint('📬 [Pusher] Private event received: ${event.eventName}');
          onEvent(event);
        },
        onSubscriptionSucceeded: (subscription) {
          debugPrint(
            '✅ [Pusher] Private subscription to $channelName succeeded',
          );
        },
        onSubscriptionError: (error) {
          debugPrint(
            '❌ [Pusher] Private subscription to $channelName error: $error',
          );
        },
      );

      debugPrint(
        '✅ [Pusher] Successfully subscribed to private channel $channelName',
      );
      return true;
    } catch (e) {
      debugPrint('❌ [Pusher] Error subscribing to private channel: $e');
      return false;
    }
  }

  Future<bool> unsubscribe({required String channelName}) async {
    try {
      debugPrint('🔌 [Pusher] Unsubscribing from channel: $channelName');
      await pusher.unsubscribe(channelName: channelName);
      debugPrint('✅ [Pusher] Unsubscribed from $channelName');
      return true;
    } catch (e) {
      debugPrint('❌ [Pusher] Error unsubscribing: $e');
      return false;
    }
  }

  Future<bool> connect() async {
    try {
      if (!_isInitialized) {
        debugPrint('⚠️ [Pusher] Cannot connect - not initialized');
        return false;
      }

      debugPrint('🔗 [Pusher] Connecting...');
      await pusher.connect();
      debugPrint('✅ [Pusher] Connected successfully');
      return true;
    } catch (e) {
      debugPrint('❌ [Pusher] Connection error: $e');
      return false;
    }
  }

  Future<bool> disconnect() async {
    try {
      debugPrint('🔌 [Pusher] Disconnecting...');
      await pusher.disconnect();
      debugPrint('✅ [Pusher] Disconnected');
      return true;
    } catch (e) {
      debugPrint('❌ [Pusher] Disconnection error: $e');
      return false;
    }
  }

  bool get isInitialized => _isInitialized;
}
