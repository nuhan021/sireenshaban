import 'package:get/get.dart';

class HomeController extends GetxController {
  RxBool isAdditionalServicesClose = false.obs;
  RxInt carouselCurrentIndex = 1.obs;

  void changeIsAdditionalServicesClose({required bool value}){
    isAdditionalServicesClose.value = value;
  }

  void changeCarouselCurrentIndex({required int value}){
    carouselCurrentIndex.value = value;
  }
}