import 'package:get/get.dart';
import 'package:sireenshaban/core/services/storage_service.dart';
import 'package:sireenshaban/features/select_role/controller/select_role_controller.dart';
import 'package:sireenshaban/core/controllers/user_controller.dart';
import 'package:sireenshaban/features/stripe/controller/stripe_controller.dart';
import 'package:sireenshaban/features/vendor/vendor_profile_info/views/controller/vendor_profile_info_map_controller.dart';
// Import your vendor setup controller
import 'package:sireenshaban/features/vendor/vendor_setup/controller/vendor_setup_screen_controller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    // 1. Initialize UserController globally
    Get.put<UserController>(UserController(), permanent: true);

    // 2. Add VendorSetupScreenController HERE
    // It must be initialized before or alongside the map controller
    // if the map controller calls Get.find() immediately.
    Get.put<VendorSetupScreenController>(VendorSetupScreenController(), permanent: true);

    // 3. Initialize Map Controller
    Get.put<VendorProfileInfoMapController>(VendorProfileInfoMapController(), permanent: true);

    Get.lazyPut<SelectRoleController>(
          () => SelectRoleController(),
      fenix: true,
    );

    Get.lazyPut<StripeController>(
          () => StripeController(),
      fenix: true,
    );
  }
}