import 'package:get/get.dart';

class SelectRoleController extends GetxController {
  RxString role = 'business'.obs;

  void selectRole({required String userRole}) => role.value = userRole;
}