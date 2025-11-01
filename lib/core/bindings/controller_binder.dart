import 'package:get/get.dart';
import 'package:sireenshaban/core/services/storage_service.dart';
import 'package:sireenshaban/features/select_role/controller/select_role_controller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    // Get.putAsync<StorageService>(() async {
    //   await StorageService.init();
    //   return StorageService();
    // });

    Get.lazyPut<SelectRoleController>(
      () => SelectRoleController(),
      fenix: true,
    );
  }
}
