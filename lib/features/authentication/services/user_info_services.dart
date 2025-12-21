import 'package:sireenshaban/core/services/network_caller.dart';
import 'package:sireenshaban/core/services/storage_service.dart';
import 'package:sireenshaban/core/utils/constants/api_constants.dart';
import 'package:sireenshaban/core/utils/logging/logger.dart';

class UserInfoService {
  UserInfoService._();

  /// Fetches the current user's profile from the server (requires token in StorageService)
  /// If successful, saves the `data` map into `StorageService.saveUserProfile`.
  static Future<bool> fetchAndStoreProfile() async {
    try {
      if (!StorageService.hasToken()) return false;

      final caller = NetworkCaller();
      final resp = await caller.getRequest(
        ApiConstants.editProfile,
        token: 'Bearer ${StorageService.token}',
      );

      AppLoggerHelper.info('UserInfo fetched: ${resp.responseData}');

      if (resp.isSuccess && resp.responseData != null) {
        final data = resp.responseData['data'];
        if (data != null && data is Map<String, dynamic>) {
          await StorageService.saveUserProfile(data);
          return true;
        }
      }
    } catch (e) {
      AppLoggerHelper.error('UserInfoService.fetchAndStoreProfile error: $e');
    }
    return false;
  }
}
