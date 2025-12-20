import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sireenshaban/core/services/storage_service.dart';
import 'package:sireenshaban/core/utils/constants/api_constants.dart';
import 'package:sireenshaban/core/utils/constants/snackbar_constant.dart';
import 'package:sireenshaban/core/utils/logging/logger.dart';
import 'package:sireenshaban/features/customer/interest/categori_model.dart' hide Datum;

import '../../../../../core/services/network_caller.dart';
import '../../../../../core/utils/helpers/app_helper.dart';
import '../../../booking_confirmed/views/screens/booking_confirmed_screen.dart';
import '../../../home/model/packages_model.dart';

class ConfirmBookingController extends GetxController {
  final NetworkCaller _networkCaller = NetworkCaller();

  RxBool isConfirmBookingLoading = false.obs;

  Rx<CategoriModel?> catagoris = Rx<CategoriModel?>(null);

  final TextEditingController specialConcernController = TextEditingController();
  late int timeSlotId = 0;


  Future<void> confirmBooking({required BuildContext context, required Datum datum, required double totalPrice}) async {
    isConfirmBookingLoading.value = true;
    final data = {
      "vendor_id": datum.vendor.id,

      "package_id": datum.id,
      "event_id": null,
      "quote_id": null,

      "time_slot_id": timeSlotId,

      "booking_date": null,
      "booking_time": null,
      "guests": 1,


      "special_concerns": specialConcernController.text.trim(),

      "subtotal": totalPrice,
      "tax": 0.0,
//   "platform_fee": 10,
//   "total": 130.00,

      "status": "Pending",
      "confirmed_at": null,
      "cancelled_at": null,
      "completed_at": null
    };

    final token = StorageService.token;

    final response = await _networkCaller.postRequest(
      ApiConstants.bookings,
      body: data,
      token: "Bearer $token"
    );

    if(!response.isSuccess) {
      isConfirmBookingLoading.value = false;
      SnackBarConstant.error(response.errorMessage);
    }


    isConfirmBookingLoading.value = false;
    SnackBarConstant.success('Booking confirmed');

    AppHelperFunctions.navigateToScreen(
      context,
      BookingConfirmedScreen(),
    );

  }

}