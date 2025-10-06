

import 'package:get/get.dart';
import 'package:sireenshaban/features/select_role/controller/select_role_controller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SelectRoleController>(
          () => SelectRoleController(),
      fenix: true,
    );

  }
}