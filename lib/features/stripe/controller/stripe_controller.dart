import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:sireenshaban/core/services/storage_service.dart';
import 'package:sireenshaban/core/utils/constants/api_constants.dart';
import 'package:sireenshaban/core/utils/constants/snackbar_constant.dart';
import 'package:sireenshaban/core/utils/logging/logger.dart';
import 'package:sireenshaban/routes/app_routes.dart';
import 'package:sireenshaban/features/stripe/model/payment_intent.dart' hide Stripe;
import 'package:sireenshaban/features/subscription/model/subscription_plans_model.dart';
import '../../../../core/services/network_caller.dart';

class StripeController extends GetxController {
  final NetworkCaller _networkCaller;

  StripeController({NetworkCaller? networkCaller})
      : _networkCaller = networkCaller ?? NetworkCaller();

  RxBool isSubscriptionPlanLoading = false.obs;
  RxBool isPaymentProcessing = false.obs;
  Rx<SubscriptionPlansModel?> subscriptionPlans = Rx<SubscriptionPlansModel?>(null);
  Rx<PaymentIntentModel?> paymentIntent = Rx<PaymentIntentModel?>(null);

  @override
  void onInit() {
    super.onInit();
    getSubscriptionPlans();
  }

  /// Fetch available plans
  Future<void> getSubscriptionPlans() async {
    isSubscriptionPlanLoading.value = true;
    try {
      final response = await _networkCaller.getRequest(
        ApiConstants.subscriptionPlans,
        token: 'Bearer ${StorageService.token}',
      );

      if (response.isSuccess && response.responseData != null) {
        subscriptionPlans.value = SubscriptionPlansModel.fromJson(response.responseData);
      } else {
        SnackBarConstant.error('Failed to load subscription plans');
      }
    } catch (e) {
      AppLoggerHelper.error("Error fetching plans: $e");
    } finally {
      isSubscriptionPlanLoading.value = false;
    }
  }

  /// Main payment flow
  Future<void> makePayment(int planId) async {
    if (!StorageService.hasToken()) {
      SnackBarConstant.error("Session expired. Please log in again.");
      return;
    }

    if(planId <= 0) {
      SnackBarConstant.error("Invalid Plan Id");
      return;
    }

    try {
      isPaymentProcessing.value = true;

      // 1. Get Intent from backend
      bool success = await _fetchPaymentIntent(planId);

      if (!success || paymentIntent.value == null) {
        SnackBarConstant.error("Could not initialize payment with server");
        return;
      }

      final String clientSecret = paymentIntent.value!.stripe.clientSecret;

      // 2. Initialize Payment Sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          merchantDisplayName: 'Sireen Shaban',
          style: ThemeMode.light,
        ),
      );

      // 3. Present Sheet
      await Stripe.instance.presentPaymentSheet();

      // 4. Success handling (Navigation based on Role)
      SnackBarConstant.success('Subscription successful!');

      if (StorageService.role == 'Vendor') {
        Get.offAllNamed(AppRoute.vendorBottomNavBar);
      } else {
        Get.offAllNamed(AppRoute.customerBottomNavBar);
      }

    } on StripeException catch (e) {
      if (e.error.code == FailureCode.Canceled) {
        AppLoggerHelper.info('Payment canceled by user');
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

    if (result.isSuccess && result.responseData != null) {
      paymentIntent.value = PaymentIntentModel.fromJson(result.responseData);
      return true;
    }
    return false;
  }
}