import 'package:get/get.dart';
import 'package:sireenshaban/core/services/storage_service.dart';
import 'package:sireenshaban/core/utils/constants/snackbar_constant.dart';
import 'package:sireenshaban/features/customer/profile/models/user_model.dart';
import 'package:sireenshaban/features/customer/profile/services/profile_services.dart';

class ProfileController extends GetxController {
  final ProfileServices _profileServices = ProfileServices();

  RxBool isProfileLoading = false.obs;
  RxBool isProfileError = false.obs;
  Rx<UserModel?> user = Rx<UserModel?>(null);

  @override
  void onInit() {
    super.onInit();
    getProfile();
  }

  Future<void> getProfile() async {
    isProfileLoading.value = true;
    final token = StorageService.token;

    if (token == null) {
      isProfileLoading.value = false;
      isProfileError.value = true;
      SnackBarConstant.error("Unauthorized");
      return;
    }

    final response = await _profileServices.getProfile(token: "Bearer $token");

    if (response.statusCode == 401) {
      isProfileLoading.value = false;
      isProfileError.value = true;
      SnackBarConstant.error("Unauthorized");
      return;
    }

    if (!response.isSuccess) {
      isProfileLoading.value = false;
      isProfileError.value = true;
      SnackBarConstant.error(response.errorMessage);
      return;
    }

    user.value = UserModel.fromJson(response.responseData["data"]);
    isProfileLoading.value = false;
    isProfileError.value = false;
  }
}
