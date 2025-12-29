import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sireenshaban/core/services/storage_service.dart';
import 'package:sireenshaban/core/utils/constants/api_constants.dart';
import 'package:sireenshaban/core/utils/constants/snackbar_constant.dart';
import 'package:sireenshaban/core/utils/logging/logger.dart';
import 'package:sireenshaban/features/customer/interest/categori_model.dart'
    hide Datum;

import '../../../../../core/services/network_caller.dart';
import '../../../../../core/utils/helpers/app_helper.dart';
import '../../../booking_confirmed/views/screens/booking_confirmed_screen.dart';
import '../../../home/model/packages_model.dart';
import 'package:sireenshaban/features/stripe/model/payment_intent.dart'
    hide Stripe;
import 'package:flutter_stripe/flutter_stripe.dart';

class ConfirmBookingController extends GetxController {
  final NetworkCaller _networkCaller = NetworkCaller();

  RxBool isConfirmBookingLoading = false.obs;

  Rx<CategoriModel?> catagoris = Rx<CategoriModel?>(null);

  RxBool isPaymentProcessing = false.obs;

  final TextEditingController specialConcernController =
      TextEditingController();
  late int timeSlotId = 0;
  Rx<PaymentIntentModel?> paymentIntent = Rx<PaymentIntentModel?>(null);

  Future<void> confirmBooking({
    required BuildContext context,
    required Datum datum,
    required double totalPrice,
  }) async {
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

      "subtotal": datum.pricePerEvent,
      "tax": 0.0,

      //   "platform_fee": 10,
      //   "total": 130.00,
      "status": "Confirmed",
      "confirmed_at": null,
      "cancelled_at": null,
      "completed_at": null,
    };

    final token = StorageService.token;

    final response = await _networkCaller.postRequest(
      ApiConstants.bookings,
      body: data,
      token: "Bearer $token",
    );

    if (!response.isSuccess) {
      isConfirmBookingLoading.value = false;
      SnackBarConstant.error(response.errorMessage);
    }

    // Successfully received response from backend containing Payment Intent
    paymentIntent.value = PaymentIntentModel.fromJson(response.responseData);

    // EXECUTING THE PAYMENT
    await processEventPayment(
      paymentIntent.value!.stripe.clientSecret,
      context,
    );

    isConfirmBookingLoading.value = false;
  }

  Future<void> processEventPayment(
    String clientSecret,
    BuildContext context,
  ) async {
    try {
      isPaymentProcessing.value = true;

      // Step 1: Initialize Payment Sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          merchantDisplayName: 'Sireen Shaban',
          style: ThemeMode.light,
        ),
      );

      // Step 2: Present the Sheet
      await Stripe.instance.presentPaymentSheet();

      // Success logic
      SnackBarConstant.success('Booking and Payment successful!');
      AppHelperFunctions.navigateToScreen(context, BookingConfirmedScreen());
      // Get.offAllNamed(AppRoute.vendorBottomNavBar);
    } on StripeException catch (e) {
      if (e.error.code == FailureCode.Canceled) {
        SnackBarConstant.error('Payment Canceled');
      } else {
        SnackBarConstant.error(e.error.localizedMessage ?? 'Payment Failed');
      }
    } catch (e) {
      SnackBarConstant.error('An unexpected error occurred: $e');
    } finally {
      isPaymentProcessing.value = false;
    }
  }
}
