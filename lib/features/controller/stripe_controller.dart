import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sireenshaban/core/services/network_caller.dart';
import 'package:sireenshaban/core/utils/logging/logger.dart';

import '../../routes/app_routes.dart';

class StripeController extends GetxController {
  RxBool isLoading = false.obs;

  static const String secretKey =
      "sk_test_51RTEbLFT92q9uNcDuSgEqR4kSFs5110mErUxeYlG4s5x4e8vce50MemyLTKak2CmH9RdLqohUoREme7VQ18L3vNQ00v0bOF4kF";

  // ✅ Fixed: Proper URL encoding for Stripe API
  Future<Map<String, dynamic>?> createPaymentIntent({
    required String amount,
    required String currency,
  }) async {
    try {
      // Create proper URL-encoded body
      final body = {
        'amount': amount,
        'currency': currency,
        'payment_method_types[]': 'card',
      };

      print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
      print('Creating Payment Intent...');
      print('Amount: $amount cents');
      print('Currency: $currency');
      print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');

      // Use http package directly for proper encoding
      final response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer $secretKey',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: body, // http package will automatically URL-encode this
      );

      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('✅ Payment Intent Created Successfully');
        print('Client Secret: ${data['client_secret']?.substring(0, 20)}...');
        return {
          'clientSecret': data['client_secret'],
          'id': data['id'],
        };
      } else {
        print('❌ Error: ${response.body}');
        return null;
      }
    } catch (e) {
      print('❌ Exception: $e');
      return null;
    }
  }

  Future<Map<String, dynamic>> makePayment({
    required double amount,
    required String currency,
  }) async {
    try {
      isLoading.value = true;

      // Convert to cents
      String amountInCents = (amount * 100).toInt().toString();
      print('Processing payment of \$${amount.toStringAsFixed(2)}');

      // Step 1: Create Payment Intent
      final paymentIntent = await createPaymentIntent(
        amount: amountInCents,
        currency: currency,
      );

      if (paymentIntent == null) {
        isLoading.value = false;
        return {
          'success': false,
          'message': 'Failed to create payment intent',
        };
      }

      // Step 2: Initialize Payment Sheet
      print('Initializing Payment Sheet...');
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent['clientSecret'],
          merchantDisplayName: 'Demo Store',
          style: ThemeMode.light,
        ),
      );
      print('✅ Payment Sheet Initialized');

      // Step 3: Present Payment Sheet
      print('Presenting Payment Sheet...');
      await Stripe.instance.presentPaymentSheet();
      print('✅ Payment Successful!');

      Get.offAllNamed(AppRoute.vendorSetupScreen);

      isLoading.value = false;
      return {
        'success': true,
        'message': 'Payment successful',
        'paymentIntentId': paymentIntent['id'],
      };
    } on StripeException catch (e) {
      isLoading.value = false;
      print('❌ Stripe Error: ${e.error.localizedMessage}');

      if (e.error.code == FailureCode.Canceled) {
        return {
          'success': false,
          'message': 'Payment canceled',
        };
      }

      return {
        'success': false,
        'message': e.error.localizedMessage ?? 'Payment failed',
      };
    } catch (e) {
      isLoading.value = false;
      print('❌ Error: $e');
      return {
        'success': false,
        'message': 'Payment failed: $e',
      };
    }
  }
}
