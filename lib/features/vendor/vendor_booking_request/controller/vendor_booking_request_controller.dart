import 'package:get/get.dart';
import 'package:sireenshaban/core/utils/constants/enums.dart';

class VendorBookingController extends GetxController {
  var bookingRequest = BookingRequest.newRequest.obs;

  void changeBookingRequest(BookingRequest val) {
    bookingRequest.value = val;
  }

}