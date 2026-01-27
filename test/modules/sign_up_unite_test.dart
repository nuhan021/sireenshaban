import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';

// Project Imports
import 'package:sireenshaban/core/models/response_data.dart';
import 'package:sireenshaban/core/services/network_caller.dart';
import 'package:sireenshaban/features/authentication/controllers/sign_up_screen_controller.dart';
import 'package:sireenshaban/routes/app_routes.dart';

/// Mock class for Network Interaction
class MockNetworkCaller extends Mock implements NetworkCaller {}

void main() {
  late SignUpScreenController controller;
  late MockNetworkCaller mockNetwork;

  Future<void> setupTestWidget(WidgetTester tester) async {
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(360, 690),
        builder: (context, child) => GetMaterialApp(
          initialRoute: '/',
          getPages: [
            GetPage(name: '/', page: () => const Scaffold()),
            GetPage(name: AppRoute.signUpScreen, page: () => const Scaffold()),
            GetPage(
              name: AppRoute.verificationCodeSendSuccessScreen,
              page: () => const Scaffold(),
            ),
            GetPage(name: AppRoute.loginScreen, page: () => const Scaffold()),
          ],
        ),
      ),
    );
  }

  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    Get.testMode = true;

    mockNetwork = MockNetworkCaller();
    // Injecting the mock dependency
    controller = SignUpScreenController(networkCaller: mockNetwork);
    Get.put(controller);
  });

  tearDown(() {
    Get.reset();
  });

  group('SignUpScreenController - UI Logic', () {
    test('Password visibility toggles should update reactive variables', () {
      expect(controller.isObscurePassword.value, isTrue);
      controller.togglePasswordVisibility();
      expect(controller.isObscurePassword.value, isFalse);

      expect(controller.isObscureRetypePassword.value, isTrue);
      controller.toggleRetypePasswordVisibility();
      expect(controller.isObscureRetypePassword.value, isFalse);
    });
  });

  group('SignUpScreenController - Form Validation', () {
    testWidgets('Should prevent API call if any field is empty', (
      tester,
    ) async {
      await setupTestWidget(tester);

      controller.emailController.text = ''; // Empty field
      await controller.signUp('UserRole.vendor');

      await tester.pumpAndSettle(const Duration(seconds: 5));

      expect(controller.isSignUpLoading.value, isFalse);

      verifyNever(
        () => mockNetwork.postRequest(any(), body: any(named: 'body')),
      );
    });

    testWidgets('Should prevent API call if passwords do not match', (
      tester,
    ) async {
      await setupTestWidget(tester);

      controller.emailController.text = 'test@example.com';
      controller.passwordController.text = 'password123';
      controller.retypePasswordController.text = 'mismatch456';

      await controller.signUp('UserRole.vendor');
      await tester.pumpAndSettle(const Duration(seconds: 5));

      expect(controller.isSignUpLoading.value, isFalse);
    });
  });

  group('SignUpScreenController - API & Navigation', () {
    testWidgets(
      'Successful signUp should set loading and navigate to Success Screen',
      (tester) async {
        // 1. Arrange
        when(
          () => mockNetwork.postRequest(any(), body: any(named: 'body')),
        ).thenAnswer(
          (_) async => ResponseData(
            isSuccess: true,
            statusCode: 200,
            responseData: {"success": true},
            errorMessage: '',
          ),
        );

        await setupTestWidget(tester);
        controller.emailController.text = 'newuser@test.com';
        controller.passwordController.text = 'password123';
        controller.retypePasswordController.text = 'password123';

        // 2. Act
        final signUpFuture = controller.signUp('UserRole.vendor');

        // Assert loading state mid-flight
        expect(controller.isSignUpLoading.value, isTrue);

        await signUpFuture;

        // 3. Assert
        expect(controller.isSignUpLoading.value, isFalse);

        expect(Get.currentRoute, AppRoute.verificationCodeSendSuccessScreen);

        await tester.pumpAndSettle(const Duration(seconds: 4));
      },
    );

    testWidgets('verifyOtp should navigate to Login on success', (
      tester,
    ) async {
      // 1. Arrange
      controller.otp = '123456';
      controller.emailController.text = 'test@example.com';

      when(
        () => mockNetwork.postRequest(any(), body: any(named: 'body')),
      ).thenAnswer(
        (_) async => ResponseData(
          isSuccess: true,
          statusCode: 200,
          responseData: {"success": true},
          errorMessage: '',
        ),
      );

      await setupTestWidget(tester);

      // 2. Act
      await controller.verifyOtp(true); // From Sign Up

      // 3. Assert
      expect(Get.currentRoute, AppRoute.loginScreen);
      await tester.pumpAndSettle(const Duration(seconds: 4));
    });
  });
}
