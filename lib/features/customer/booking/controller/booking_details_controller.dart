import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:sireenshaban/core/services/network_caller.dart';
import 'package:sireenshaban/core/services/storage_service.dart';
import 'package:sireenshaban/core/utils/constants/api_constants.dart';
import 'package:sireenshaban/core/utils/constants/snackbar_constant.dart';
import 'package:sireenshaban/features/vendor/vendor_home/model/vendor_booking_model.dart';

class BookingDetailsController extends GetxController {
  final NetworkCaller _networkCaller = NetworkCaller();

  Rx<Datum?> bookingDetails = Rx<Datum?>(null);
  RxBool isLoading = false.obs;
  RxBool isError = false.obs;

  Future<void> fetchBookingDetails(int bookingId) async {
    isLoading.value = true;
    isError.value = false;

    final token = StorageService.token;
    final endpoint = "${ApiConstants.bookings}/$bookingId";

    debugPrint("📋 [BookingDetails] Fetching booking details from: $endpoint");

    final response = await _networkCaller.getRequest(
      endpoint,
      token: "Bearer $token",
    );

    debugPrint("📋 [BookingDetails] Response success: ${response.isSuccess}");
    debugPrint("📋 [BookingDetails] Response data: ${response.responseData}");

    if (!response.isSuccess) {
      debugPrint("❌ [BookingDetails] Error: ${response.errorMessage}");
      SnackBarConstant.error(response.errorMessage);
      isLoading.value = false;
      isError.value = true;
      return;
    }

    try {
      final data = response.responseData['data'];
      if (data != null) {
        bookingDetails.value = Datum.fromJson(data);
        debugPrint("✅ [BookingDetails] Booking loaded: ID ${bookingDetails.value?.id}");
      }
    } catch (e) {
      debugPrint("❌ [BookingDetails] Parse error: $e");
      isError.value = true;
    }

    isLoading.value = false;
  }
}
