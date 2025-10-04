import 'package:get/get.dart';

class ChangePasswordController extends GetxController {
  RxBool isObscurePassword = true.obs;
  RxBool isObscureRetypePassword = true.obs;

  void togglePasswordVisibility() {
    isObscurePassword.value = !isObscurePassword.value;
  }

  void toggleRetypePasswordVisibility() {
    isObscureRetypePassword.value = !isObscureRetypePassword.value;
  }
}