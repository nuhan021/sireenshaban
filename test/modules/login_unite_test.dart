import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';

// Internal Project Imports
import 'package:sireenshaban/core/models/response_data.dart';
import 'package:sireenshaban/core/services/network_caller.dart';
import 'package:sireenshaban/features/authentication/controllers/login_controller.dart';

/// Mocks for External Dependencies
class MockNetworkCaller extends Mock implements NetworkCaller {}

void main() {
  late LoginController controller;
  late MockNetworkCaller mockNetwork;

  /// Helper to wrap widgets with ScreenUtil and GetX for consistent test environments.
  Future<void> setupTestWidget(WidgetTester tester, {List<GetPage>? routes}) async {
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(360, 690),
        builder: (context, child) => GetMaterialApp(
          initialRoute: '/',
          getPages: routes ?? [GetPage(name: '/', page: () => const Scaffold())],
        ),
      ),
    );
  }

  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    Get.testMode = true;
    
    mockNetwork = MockNetworkCaller();
    // Inject the mock network caller into the controller
    controller = LoginController(networkCaller: mockNetwork);
    Get.put(controller);
  });

  tearDown(() {
    Get.reset();
  });

  group('LoginController Unit Tests', () {
    test('Initial states should be correctly initialized', () {
      expect(controller.isObscure.value, isTrue);
      expect(controller.isLogInLoading.value, isFalse);
      expect(controller.loginModel.value, isNull);
    });

    test('togglePasswordVisibility should flip isObscure boolean', () {
      controller.togglePasswordVisibility();
      expect(controller.isObscure.value, isFalse);
      controller.togglePasswordVisibility();
      expect(controller.isObscure.value, isTrue);
    });
  });

  group('LoginController Integration/Logic Tests', () {
  
    
    testWidgets('Should show warning and return early if fields are empty', (tester) async {
      await setupTestWidget(tester);

      controller.emailController.text = '';
      controller.passwordController.text = '';

      await controller.login();

      // Wait for GetX Snackbars/Animations to settle to avoid Ticker leaks
      await tester.pumpAndSettle(const Duration(seconds: 4));

      expect(controller.isLogInLoading.value, isFalse);
    });

    testWidgets('Should succeed login and navigate when valid credentials provided', (tester) async {
      // 1. Arrange: Define routes and mock API behavior
      final mockPages = [
        GetPage(name: '/', page: () => const Scaffold()),
        GetPage(name: '/vendorBottomNavBar', page: () => const Scaffold(body: Text('Home'))),
      ];

      final successResponseMap = {
        "success": true,
        "message": "Login successful",
        "data": {
          "token": "fake_token",
          "token_type": "Bearer",
          "user": {
            "id": 1,
            "email": "test@example.com",
            "role": "Vendor",
            "is_first_time": false,
            "subscription_type": null,
          },
          "vendor": {"id": 123},
        },
      };

      when(() => mockNetwork.postRequest(any(), body: any(named: 'body')))
          .thenAnswer((_) async => ResponseData(
                isSuccess: true,
                statusCode: 200,
                responseData: successResponseMap,
                errorMessage: '',
              ));

      // 2. Act: Build UI and trigger login
      await setupTestWidget(tester, routes: mockPages);
      controller.emailController.text = 'test@example.com';
      controller.passwordController.text = 'password123';

      final loginProcess = controller.login();
      
      // Verify immediate loading state
      expect(controller.isLogInLoading.value, isTrue);

      await loginProcess;

      // 3. Assert: Verify state changes and navigation
      expect(controller.isLogInLoading.value, isFalse);
      expect(controller.loginModel.value!.data.token, "fake_token");
      
      // Wait for Get.offAllNamed navigation animation
      await tester.pumpAndSettle(); 
      expect(Get.currentRoute, '/vendorBottomNavBar');
    });
  });


  
}