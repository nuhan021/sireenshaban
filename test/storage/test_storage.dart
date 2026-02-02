import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sireenshaban/core/services/storage_service.dart';

import 'helpers/dummydata.dart';

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await StorageService.init();
  });

  group('StorageService - Token', () {
    test('saveToken & hasToken', () async {
      await StorageService.saveToken(
        StorageDummyData.token,
        StorageDummyData.userId,
      );

      expect(StorageService.hasToken(), isTrue);
      expect(StorageService.token, StorageDummyData.token);
      expect(StorageService.userId, StorageDummyData.userId);
    });
  });

  group('StorageService - Role & Vendor', () {
    test('saveRole', () async {
      await StorageService.saveRole(StorageDummyData.role);
      expect(StorageService.role, StorageDummyData.role);
    });

    test('saveVendorId', () async {
      await StorageService.saveVendorId(StorageDummyData.vendorId);
      expect(StorageService.vendorId, StorageDummyData.vendorId.toString());
    });
  });

  group('StorageService - Profile', () {
    test('saveUserProfile & getters', () async {
      await StorageService.saveUserProfile(StorageDummyData.userProfile);

      expect(StorageService.userProfile, isNotNull);
      expect(StorageService.firstName, 'Jihad');
      expect(StorageService.lastName, 'Mugdho');
      expect(StorageService.email, 'jihadmugdho1236@gmail.com');
      expect(StorageService.city, 'Dhaka');
      expect(StorageService.address, 'Test Address 123');
    });

    test('userProfile null safety', () {
      expect(StorageService.userProfile, isNull);
      expect(StorageService.firstName, isNull);
    });
  });

  group('StorageService - FCM Token', () {
    test('set & clear FCM token', () async {
      await StorageService.setFCMToken(StorageDummyData.fcmToken);
      expect(StorageService.fcmToken, StorageDummyData.fcmToken);

      await StorageService.clearFCMToken();
      expect(StorageService.fcmToken, isNull);
    });
  });

  group('StorageService - Logout', () {
    test('logoutUser clears auth data', () async {
      await StorageService.saveToken(
        StorageDummyData.token,
        StorageDummyData.userId,
      );
      await StorageService.saveRole(StorageDummyData.role);

      await StorageService.logoutUser();

      expect(StorageService.token, isNull);
      expect(StorageService.userId, isNull);
      expect(StorageService.role, isNull);
      expect(StorageService.hasToken(), isFalse);
    });
  });
}
