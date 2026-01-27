import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:sireenshaban/core/models/response_data.dart';
import 'package:sireenshaban/core/services/network_caller.dart';
import 'package:sireenshaban/features/stripe/controller/stripe_controller.dart';
import 'package:sireenshaban/features/stripe/model/payment_intent.dart';
import 'package:sireenshaban/features/stripe/service/stripe_service.dart';

// Mock Classes
class MockStripe extends Mock implements Stripe {}

/// Mock class for Network Interaction
class MockNetworkCaller extends Mock implements NetworkCaller {}

class MockStripeService extends Mock implements StripeService {}

void main() {
  late StripeController controller;
  late MockNetworkCaller mockNetwork;
  late MockStripeService mockStripe;

  setUp(() {
    mockNetwork = MockNetworkCaller();
    mockStripe = MockStripeService();

    when(() => mockStripe.initPaymentSheet(any())).thenAnswer((_) async => {});

    controller = Get.put(
      StripeController(networkCaller: mockNetwork, stripeService: mockStripe),
    );
  });

  tearDown(() {
    Get.delete<StripeController>();
  });

  group('StripeController - getSubscriptionPlans', () {
    final mockPlansJson = {
      "success": true,
      "plans": [
        {
          "id": 1,
          "title": "Basic Plan",
          "description": "Trial",
          "price": 10,
          "features": ["Feature 1"],
          "duration_type": "month",
          "duration_value": 1,
          "is_popular": false,
          "status": true,
          "created_at": "2024-01-01T00:00:00Z",
          "updated_at": "2024-01-01T00:00:00Z",
          "deleted_at": null,
        },
      ],
    };

    test('getSubscriptionPlans updates subscriptionPlans on success', () async {
      when(
        () => mockNetwork.getRequest(any(), token: any(named: 'token')),
      ).thenAnswer(
        (_) async => ResponseData(
          isSuccess: true,
          statusCode: 200,
          responseData: mockPlansJson,
          errorMessage: '',
        ),
      );

      // 2. Call the method
      await controller.getSubscriptionPlans();

      // 3. Verify the state
      expect(controller.subscriptionPlans.value, isNotNull);
      expect(
        controller.subscriptionPlans.value!.plans.first.title,
        "Basic Plan",
      );
    });
  });

  group('StripeController - makePayment Flow', () {
    final mockPaymentIntentJson = {
      "success": true,
      "message": "Intent created",
      "amount": 10.0,
      "stripe": {
        "id": "pi_123",
        "client_secret": "secret_123",
        "object": "payment_intent",
        "amount": 1000,
        "currency": "usd",
        "status": "requires_payment_method",
        "payment_method_types": ["card"],
      },
    };

    testWidgets('makePayment handles failed intent fetch correctly', (
      WidgetTester tester,
    ) async {
      when(
        () => mockNetwork.postRequest(
          any(),
          body: any(named: 'body'),
          token: any(named: 'token'),
        ),
      ).thenAnswer(
        (_) async => ResponseData(
          isSuccess: false,
          statusCode: 400,
          responseData: null,
          errorMessage: 'Error',
        ),
      );

      await tester.pumpWidget(GetMaterialApp(home: Container()));

      await controller.makePayment(1);

      expect(controller.isPaymentProcessing.value, isFalse);
      expect(controller.paymentIntent.value, isNull);
    });
  });
}
