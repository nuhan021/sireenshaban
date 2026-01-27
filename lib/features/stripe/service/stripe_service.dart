import 'package:flutter_stripe/flutter_stripe.dart';

class StripeService {
  Future<void> initPaymentSheet(SetupPaymentSheetParameters params) async {
    await Stripe.instance.initPaymentSheet(paymentSheetParameters: params);
  }
  Future<void> presentPaymentSheet() async {
    await Stripe.instance.presentPaymentSheet();
  }
}