import 'package:get/get.dart';

class LoginController extends GetxController {
  RxBool isObscure = true.obs;

  void togglePasswordVisibility() {
    isObscure.value = !isObscure.value;
  }
}