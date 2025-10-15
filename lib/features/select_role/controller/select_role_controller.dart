import 'package:get/get.dart';
import 'package:sireenshaban/core/utils/constants/enums.dart';

class SelectRoleController extends GetxController {
  var role = UserRole.customer.obs;

  void selectRole({required UserRole userRole}) => role.value = userRole;
}