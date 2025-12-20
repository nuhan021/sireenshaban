import 'package:get/get.dart';

class EventController extends GetxController {
  RxInt ticketNumber = 1.obs;
  RxString stringPrice = ''.obs;

  void increaseTicketNumber(String price) {
    ticketNumber.value++;
    _calculatePrice(price);
  }

  void decreaseTicketNumber(String price) {
    if (ticketNumber.value > 1) {
      ticketNumber.value--;
      _calculatePrice(price);
    }
  }

  void _calculatePrice(String price) {
    try {
      double basePrice = double.parse(price);
      double totalPrice = basePrice * ticketNumber.value;

      // ডাইনামিকালি স্ট্রিং আপডেট
      stringPrice.value = totalPrice.toStringAsFixed(2);
    } catch (e) {
      stringPrice.value = '0.00';
    }
  }
}