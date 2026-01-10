import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sireenshaban/core/services/storage_service.dart';
import 'package:sireenshaban/core/utils/constants/api_constants.dart';
import 'package:sireenshaban/core/utils/constants/snackbar_constant.dart';
import 'package:sireenshaban/features/stripe/model/payment_intent.dart'
    hide Stripe;
import '../../../../core/services/network_caller.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import '../../home/model/eventModel.dart';

class EventController extends GetxController {
  final NetworkCaller _networkCaller = NetworkCaller();
  RxInt ticketNumber = 1.obs;
  RxString stringPrice = ''.obs;
  RxBool isEventLoading = false.obs;
  RxBool isPaymentProcessing = false.obs;

  Rx<PaymentIntentModel?> paymentIntent = Rx<PaymentIntentModel?>(null);

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

      stringPrice.value = totalPrice.toStringAsFixed(2);
    } catch (e) {
      stringPrice.value = '0.00';
    }
  }

  Future<void> confirmBooking(Datum datum) async {
    isEventLoading.value = true;

    String formattedDate = DateFormat('yyyy-MM-dd').format(datum.eventDate);

    DateTime tempTime = DateFormat("hh:mm a").parse(datum.eventTime);
    String formattedTime = DateFormat("HH:mm").format(tempTime);

    final data = {
      "vendor_id": datum.vendor.id,

      "package_id": null,
      "event_id": datum.id,
      "quote_id": null,

      "time_slot_id": 1,

      "booking_date": formattedDate,
      "booking_time": formattedTime,
      "guests": ticketNumber.value,

      "special_concerns": "",

      "subtotal": double.parse(stringPrice.value),
      "tax": 0.0,

      //   "platform_fee": 10,
      //   "total": 130.00,
      "status": "Confirmed",
      "confirmed_at": "2025-12-11 10:00:00",
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
      isEventLoading.value = false;
      SnackBarConstant.error(response.errorMessage);
    }

    // Successfully received response from backend containing Payment Intent
    paymentIntent.value = PaymentIntentModel.fromJson(response.responseData);

    // EXECUTING THE PAYMENT
    await processEventPayment(paymentIntent.value!.stripe.clientSecret);

    isEventLoading.value = false;
  }

  Future<void> processEventPayment(String clientSecret) async {
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
