import 'package:get/get.dart';
import 'package:sireenshaban/core/services/storage_service.dart';
import 'package:sireenshaban/features/customer/home/controller/home_controller.dart';

class UserController extends GetxController {
  // Reactive profile fields
  final RxString firstName = ''.obs;
  final RxString lastName = ''.obs;
  final RxString email = ''.obs;
  final RxString profileImage = ''.obs;
  final RxString coverImage = ''.obs;
  final RxString city = ''.obs;
  final RxString address = ''.obs;
  final RxString country = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadFromStorage();
  }



  /// Load all profile fields from StorageService
  void loadFromStorage() {
    final profile = StorageService.userProfile;
    if (profile != null) {
      firstName.value = StorageService.firstName ?? '';
      lastName.value = StorageService.lastName ?? '';
      email.value = StorageService.email ?? '';
      profileImage.value = StorageService.profileImage ?? '';
      coverImage.value = StorageService.coverImage ?? '';
      city.value = StorageService.city ?? '';
      address.value = StorageService.address ?? '';
      country.value = profile['country'] ?? '';
    }
  }

  void refreshFromStorage() {
    loadFromStorage();
  }

  String get fullName => '${firstName.value} ${lastName.value}'.trim();
}
