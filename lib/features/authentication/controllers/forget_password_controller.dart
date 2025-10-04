import 'package:get/get.dart';

class ForgetPasswordController extends GetxController {
  RxString forgetPasswordMethod = 'email'.obs;

  void changeForgetPasswordMethod({required String method}) {
    forgetPasswordMethod.value = method;
  }
}