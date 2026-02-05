import 'package:flutter_stripe/flutter_stripe.dart' as flutter_stripe;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:sireenshaban/core/models/response_data.dart';
import 'package:sireenshaban/core/services/network_caller.dart';
import 'package:sireenshaban/features/stripe/controller/stripe_controller.dart';
import 'package:sireenshaban/features/stripe/service/stripe_service.dart';

class MockStripe extends Mock implements flutter_stripe.Stripe {}

class MockNetworkCaller extends Mock implements NetworkCaller {}

class MockStripeService extends Mock implements StripeService {}

class FakeSetupPaymentSheetParameters extends Fake
    implements flutter_stripe.SetupPaymentSheetParameters {}

void main() {
  late StripeController controller;
  late MockNetworkCaller mockNetwork;
  late MockStripeService mockStripe;

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

  setUpAll(() {
    registerFallbackValue(FakeSetupPaymentSheetParameters());
  });

  setUp(() {
    mockNetwork = MockNetworkCaller();
    mockStripe = MockStripeService();

    when(() => mockStripe.initPaymentSheet(any())).thenAnswer((_) async => {});

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

    controller = Get.put(
      StripeController(networkCaller: mockNetwork,),
    );
  });

  tearDown(() {
    Get.delete<StripeController>();
  });

  group('StripeController - getSubscriptionPlans', () {
    test('getSubscriptionPlans updates subscriptionPlans on success', () async {
      await controller.getSubscriptionPlans();

      expect(controller.subscriptionPlans.value, isNotNull);
      expect(
        controller.subscriptionPlans.value!.plans.first.title,
        "Basic Plan",
      );
    });
  });

  group('StripeController - makePayment Flow', () {
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

      await tester.pumpAndSettle();

      expect(controller.isPaymentProcessing.value, isFalse);
      expect(controller.paymentIntent.value, isNull);

      if (Get.isSnackbarOpen) {
        await Get.closeCurrentSnackbar();
        await tester.pumpAndSettle();
      }
    });
  });
}
