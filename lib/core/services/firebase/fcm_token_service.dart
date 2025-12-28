import 'package:sireenshaban/core/services/network_caller.dart';
import 'package:sireenshaban/core/services/storage_service.dart';
import 'package:sireenshaban/core/utils/constants/api_constants.dart';
import 'package:sireenshaban/core/utils/logging/logger.dart';

class FCMTokenService {
  final NetworkCaller _networkCaller = NetworkCaller();

  Future<bool> sendFCMTokenToBackend() async {
    try {
      final token = StorageService.fcmToken;
      final authToken = StorageService.token;

      if (token == null || token.isEmpty) {
        AppLoggerHelper.error('FCM token is empty');
        return false;
      }

      if (authToken == null || authToken.isEmpty) {
        AppLoggerHelper.error('Auth token is empty');
        return false;
      }

      AppLoggerHelper.info('Sending FCM token to backend: $token');

      final response = await _networkCaller.postRequest(
        ApiConstants.saveFcmToken,
        token: authToken,
        body: {'fcm_token': token},
      );

      if (response.isSuccess) {
        AppLoggerHelper.info('FCM token saved successfully');
        return true;
      } else {
        AppLoggerHelper.error(
          'Failed to save FCM token: ${response.errorMessage}',
        );
        return false;
      }
    } catch (e) {
      AppLoggerHelper.error('Error sending FCM token: $e');
      return false;
    }
  }
}
