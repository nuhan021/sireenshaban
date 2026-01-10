import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sireenshaban/core/services/storage_service.dart';
import 'package:sireenshaban/core/utils/constants/api_constants.dart';
import 'package:sireenshaban/core/utils/constants/snackbar_constant.dart';
import 'package:sireenshaban/features/stripe/model/payment_intent.dart'
    hide Stripe;
import 'package:sireenshaban/features/subscription/model/subscription_plans_model.dart';
import '../../../../core/services/network_caller.dart';
import '../../../../routes/app_routes.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class StripeController extends GetxController {
  final NetworkCaller _networkCaller = NetworkCaller();

  RxBool isSubscriptionPlanLoading = false.obs;
  RxBool isSubscriptionPlanError = false.obs;
  RxBool isPaymentProcessing = false.obs;

  Rx<SubscriptionPlansModel?> subscriptionPlans = Rx<SubscriptionPlansModel?>(
    null,
  );
  Rx<PaymentIntentModel?> paymentIntent = Rx<PaymentIntentModel?>(null);

  @override
  void onInit() {
    super.onInit();
    getSubscriptionPlans();
  }

  Future<void> getSubscriptionPlans() async {
    isSubscriptionPlanLoading.value = true;
    isSubscriptionPlanError.value = false;

    final response = await _networkCaller.getRequest(
      ApiConstants.subscriptionPlans,
      token: 'Bearer ${StorageService.token}',
    );

    if (response.isSuccess) {
      subscriptionPlans.value = SubscriptionPlansModel.fromJson(
        response.responseData,
      );
    } else {
      isSubscriptionPlanError.value = true;
      SnackBarConstant.error('Failed to load subscription plans');
    }
    isSubscriptionPlanLoading.value = false;
  }

  Future<void> makePayment(int planId) async {
    try {
      isPaymentProcessing.value = true;

      bool success = await _fetchPaymentIntent(planId);

      if (!success || paymentIntent.value == null) {
        SnackBarConstant.error("Could not initialize payment with server");
        return;
      }

      final String clientSecret = paymentIntent.value!.stripe.clientSecret;

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          merchantDisplayName: 'Sireen Shaban',
          style: ThemeMode.light,
        ),
      );

      await Stripe.instance.presentPaymentSheet();

      SnackBarConstant.success('Subscription successful!');
      Get.offAllNamed(AppRoute.vendorBottomNavBar);
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

  Future<bool> _fetchPaymentIntent(int planId) async {
    final result = await _networkCaller.postRequest(
      ApiConstants.subscriptionPayment,
      body: {"plan_id": planId},
      token: 'Bearer ${StorageService.token}',
    );

    if (result.isSuccess) {
      paymentIntent.value = PaymentIntentModel.fromJson(result.responseData);
      return true;
    }
    return false;
  }
}
