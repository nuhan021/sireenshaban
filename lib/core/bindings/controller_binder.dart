import 'package:get/get.dart';
import 'package:sireenshaban/core/services/storage_service.dart';
import 'package:sireenshaban/features/select_role/controller/select_role_controller.dart';
import 'package:sireenshaban/core/controllers/user_controller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    // Initialize UserController globally (loads profile from StorageService)
    Get.put<UserController>(UserController(), permanent: true);

    Get.lazyPut<SelectRoleController>(
      () => SelectRoleController(),
      fenix: true,
    );
  }
}
