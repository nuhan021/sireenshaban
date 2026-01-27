import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sireenshaban/core/models/response_data.dart';
import 'package:sireenshaban/core/services/network_caller.dart';
import 'package:sireenshaban/features/customer/home/controller/home_controller.dart';
import 'package:sireenshaban/core/utils/constants/api_constants.dart';

class MockNetworkCaller extends Mock implements NetworkCaller {}

void main() {
  late HomeController controller;
  late MockNetworkCaller mockNetwork;

  setUp(() {
    // CRITICAL: Initialize the Flutter binding for testing
    TestWidgetsFlutterBinding.ensureInitialized();
    Get.testMode = true;
    mockNetwork = MockNetworkCaller();

    // Injecting the mock
    controller = HomeController(networkCaller: mockNetwork);
  });

  tearDown(() {
    Get.reset();
  });

  group('HomeController - getAdditionalService Tests', () {
    final mockCategoryJson = {
      "success": true,
      "data": [
        {
          "id": 1,
          "name": "Catering",
          "slug": "catering",
          "image": "image.jpg",
          "status": true,
          "created_at": "2024-01-01T00:00:00.000Z",
          "updated_at": "2024-01-01T00:00:00.000Z",
          "deleted_at": null,
        },
      ],
    };

    testWidgets('getAdditionalService sets category data successfully', (
      tester,
    ) async {
      // Arrange
      when(
        () => mockNetwork.getRequest(
          ApiConstants.categories,
          token: any(named: 'token'),
        ),
      ).thenAnswer(
        (_) async => ResponseData(
          isSuccess: true,
          statusCode: 200,
          responseData: mockCategoryJson,
          errorMessage: '',
        ),
      );

      // Act
      final future = controller.getAdditionalService();

      // Assert loading state mid-flight
      expect(controller.isAdditionalServiceLoading.value, isTrue);

      await future;

      // Assert final states
      expect(controller.isAdditionalServiceLoading.value, isFalse);
      expect(controller.isAdditionalServiceError.value, isFalse);
      expect(controller.categorys.value, isNotNull);
      expect(controller.categorys.value!.data.first.name, 'Catering');
    });

    testWidgets(
      'getAdditionalService sets error state and handles snackbar on API failure',
      (tester) async {
        // Arrange
        when(
          () => mockNetwork.getRequest(
            ApiConstants.categories,
            token: any(named: 'token'),
          ),
        ).thenAnswer(
          (_) async => ResponseData(
            isSuccess: false,
            statusCode: 500,
            responseData: null,
            errorMessage: 'Server Error',
          ),
        );

        await tester.pumpWidget(GetMaterialApp(home: Container()));

        // Act
        await controller.getAdditionalService();

        // Assert
        expect(controller.isAdditionalServiceLoading.value, isFalse);
        expect(controller.isAdditionalServiceError.value, isTrue);
        expect(controller.categorys.value, isNull);

        // Clean up any pending snackbar timers
        await tester.pumpAndSettle();
      },
    );
  });

  group('HomeController - getDealsAndPromotions Tests', () {
    final mockPackagesJson = {
      "success": true,
      "data": [
        {
          "id": 1,
          "vendor_id": 10,
          "category_id": 1,
          "title": "Summer Deal",
          "slug": "summer-deal",
          "description": "Great deal",
          "service_group": "Group A",
          "valid_until": "2026-12-31",
          "subtitle": "Limited time",
          "price_per_event": "100.00",
          "capacity": 50,
          "venue_type": "Indoor",
          "location": "Dhaka",
          "available_slots": null,
          "image": null,
          "is_active": 1,
          "category_subtype": null,
          "tags": null,
          "duration": 60,
          "latitude": "23.8103",
          "longitude": "90.4125",
          "is_featured": 1,
          "created_at": "2024-01-01T00:00:00.000Z",
          "updated_at": "2024-01-01T00:00:00.000Z",
          "deleted_at": null,
          "reviews_sum_rating": 5,
          "available_dates": [],
          "vendor": {
            "id": 10,
            "user_id": 5,
            "business_name": "Test Vendor",
            "category_id": 1,
            "account_balance": "0.00",
            "latitude": null,
            "longitude": null,
            "status": 1,
            "created_at": "2024-01-01T00:00:00.000Z",
            "updated_at": "2024-01-01T00:00:00.000Z",
            "deleted_at": null,
          },
          "category": {
            "id": 1,
            "name": "Catering",
            "slug": "catering",
            "image": null,
            "status": true,
            "created_at": "2024-01-01T00:00:00.000Z",
            "updated_at": "2024-01-01T00:00:00.000Z",
            "deleted_at": null,
          },
          "reviews": [],
        },
      ],
    };

    testWidgets(
      'getDealsAndPromotions fetches data for regular user correctly',
      (tester) async {
        // Arrange: Use regular controller
        final userController = HomeController(
          networkCaller: mockNetwork,
          isFromVendor: false,
        );

        when(
          () => mockNetwork.getRequest(
            ApiConstants.dealsAndPromotions,
            token: any(named: 'token'),
          ),
        ).thenAnswer(
          (_) async => ResponseData(
            isSuccess: true,
            statusCode: 200,
            responseData: mockPackagesJson,
            errorMessage: '',
          ),
        );

        // Act
        await userController.getDealsAndPromotions();

        // Assert
        expect(userController.isDealsAndPromotionLoading.value, isFalse);
        expect(userController.packages.value, isNotNull);
        expect(userController.packages.value!.data.first.title, 'Summer Deal');
        verify(
          () => mockNetwork.getRequest(
            ApiConstants.dealsAndPromotions,
            token: any(named: 'token'),
          ),
        ).called(1);
      },
    );

    testWidgets(
      'getDealsAndPromotions fetches data for vendor with correct query param',
      (tester) async {
        // Arrange: Use vendor controller
        final vendorController = HomeController(
          networkCaller: mockNetwork,
          isFromVendor: true,
        );

        // We expect the URL to have /?vendor_id=...
        when(
          () => mockNetwork.getRequest(
            any(that: contains('vendor_id=')),
            token: any(named: 'token'),
          ),
        ).thenAnswer(
          (_) async => ResponseData(
            isSuccess: true,
            statusCode: 200,
            responseData: mockPackagesJson,
            errorMessage: '',
          ),
        );

        // Act
        await vendorController.getDealsAndPromotions();

        // Assert
        expect(vendorController.isDealsAndPromotionError.value, isFalse);
        expect(vendorController.packages.value!.data.isNotEmpty, isTrue);
      },
    );

    testWidgets('getDealsAndPromotions sets error state on API failure', (
      tester,
    ) async {
      final userController = HomeController(networkCaller: mockNetwork);

      when(
        () => mockNetwork.getRequest(any(), token: any(named: 'token')),
      ).thenAnswer(
        (_) async => ResponseData(
          isSuccess: false,
          statusCode: 400,
          responseData: null,
          errorMessage: 'Bad Request',
        ),
      );

      // Provide GetMaterialApp for the error snackbar
      await tester.pumpWidget(GetMaterialApp(home: Container()));

      await userController.getDealsAndPromotions();

      expect(userController.isDealsAndPromotionError.value, isTrue);
      expect(userController.isDealsAndPromotionLoading.value, isFalse);

      await tester.pumpAndSettle();
    });
  });

  group('HomeController - getCommunityEvents Tests', () {
    final mockEventJson = {
      "success": true,
      "data": [
        {
          "id": 1,
          "vendor_id": 101,
          "category_id": 2,
          "title": "Community Gala",
          "slug": "community-gala",
          "description": "An evening of celebration.",
          "event_date": "2026-05-20",
          "event_time": "18:00",
          "venue_type": "Outdoor",
          "location": "Central Park",
          "image": null,
          "duration": 120,
          "ticket_price": "25.00",
          "max_attendees": 200,
          "organizer_contact": "0123456789",
          "is_public": 1,
          "created_at": "2024-01-01T10:00:00Z",
          "updated_at": "2024-01-01T10:00:00Z",
          "deleted_at": null,
          "vendor": {
            "id": 101,
            "user_id": 50,
            "business_name": "Event Masters",
            "category_id": 2,
            "account_balance": "500.00",
            "latitude": null,
            "longitude": null,
            "status": 1,
            "created_at": "2024-01-01T10:00:00Z",
            "updated_at": "2024-01-01T10:00:00Z",
            "deleted_at": null,
          },
          "category": {
            "id": 2,
            "name": "Social",
            "slug": "social",
            "image": null,
            "status": true,
            "created_at": "2024-01-01T10:00:00Z",
            "updated_at": "2024-01-01T10:00:00Z",
            "deleted_at": null,
          },
        },
      ],
    };

    testWidgets(
      'getCommunityEvents fetches data correctly for a regular user',
      (tester) async {
        final userController = HomeController(
          networkCaller: mockNetwork,
          isFromVendor: false,
        );

        when(
          () => mockNetwork.getRequest(
            ApiConstants.communityEvents,
            token: any(named: 'token'),
          ),
        ).thenAnswer(
          (_) async => ResponseData(
            isSuccess: true,
            statusCode: 200,
            responseData: mockEventJson,
            errorMessage: '',
          ),
        );

        await userController.getCommunityEvents();

        expect(userController.isCommunityEventsLoading.value, isFalse);
        expect(userController.communityEvents.value, isNotNull);
        expect(
          userController.communityEvents.value!.data.first.title,
          'Community Gala',
        );
        verify(
          () => mockNetwork.getRequest(
            ApiConstants.communityEvents,
            token: any(named: 'token'),
          ),
        ).called(1);
      },
    );

    testWidgets('getCommunityEvents handles error state correctly', (
      tester,
    ) async {
      final userController = HomeController(networkCaller: mockNetwork);

      when(
        () => mockNetwork.getRequest(any(), token: any(named: 'token')),
      ).thenAnswer(
        (_) async => ResponseData(
          isSuccess: false,
          statusCode: 404,
          responseData: null,
          errorMessage: 'Events not found',
        ),
      );

      // Provide GetMaterialApp for the snackbar
      await tester.pumpWidget(GetMaterialApp(home: Container()));

      await userController.getCommunityEvents();

      expect(userController.isCommunityEventsError.value, isTrue);
      expect(userController.isCommunityEventsLoading.value, isFalse);

      await tester.pumpAndSettle();
    });
  });

  group('HomeController - getTrendingNearby Tests', () {
    final mockTrendingJson = {
      "success": true,
      "message": "Trending vendors fetched successfully",
      "data": [
        {
          "id": 1,
          "vendor_user_id": 50,
          "business_name": "Elite Catering",
          "image": "thumb.jpg",
          "background_image": "cover.jpg",
          "rating": 5,
          "bookings": 120,
          "services_group": "Food & Beverage",
        },
      ],
      "meta": {"current_page": 1, "last_page": 5, "per_page": 10, "total": 50},
    };

    testWidgets(
      'getTrendingNearby updates trending data and shows success snackbar',
      (tester) async {
        // Arrange
        when(
          () => mockNetwork.getRequest(
            ApiConstants.trendingNearby,
            token: any(named: 'token'),
          ),
        ).thenAnswer(
          (_) async => ResponseData(
            isSuccess: true,
            statusCode: 200,
            responseData: mockTrendingJson,
            errorMessage: '',
          ),
        );

        await tester.pumpWidget(GetMaterialApp(home: Container()));

        // Act
        await controller.getTrendingNearby();

        // Assert
        expect(controller.isTrendingNearbyLoading.value, isFalse);
        expect(controller.isTrendingNearbyError.value, isFalse);
        expect(controller.trending.value, isNotNull);
        expect(
          controller.trending.value!.data.first.businessName,
          "Elite Catering",
        );
        expect(controller.trending.value!.meta.total, 50);

        // Verify snackbar was triggered
        await tester.pumpAndSettle();
        expect(Get.isSnackbarOpen, isFalse);
      },
    );

    testWidgets('getTrendingNearby sets error flags on API failure', (
      tester,
    ) async {
      // Arrange
      when(
        () => mockNetwork.getRequest(
          ApiConstants.trendingNearby,
          token: any(named: 'token'),
        ),
      ).thenAnswer(
        (_) async => ResponseData(
          isSuccess: false,
          statusCode: 401,
          responseData: null,
          errorMessage: 'Unauthorized',
        ),
      );

      await tester.pumpWidget(GetMaterialApp(home: Container()));

      // Act
      await controller.getTrendingNearby();

      // Assert
      expect(controller.isTrendingNearbyLoading.value, isFalse);
      expect(controller.isTrendingNearbyError.value, isTrue);
      expect(controller.trending.value, isNull);

      await tester.pumpAndSettle();
    });
  });

  group('HomeController - getBooking Tests', () {
    final mockBookingJson = {
      "success": true,
      "data": [
        {
          "id": 101,
          "user_id": 1,
          "vendor_id": 5,
          "guests": 4,
          "product_type": "package",
          "total": "150.00",
          "status": "confirmed",
          "date": "2026-01-27",
          "time": "14:00",
          "user": {"id": 1, "email": "user@test.com"},
          "vendor": {"id": 5, "business_name": "Test Vendor"},
          "time_slot": {"id": 1, "date_id": 1, "time": "14:00", "period": "PM"},
          "payment": {
            "id": 1,
            "booking_id": 101,
            "amount": "150.00",
            "status": "paid",
          },
        },
      ],
    };

    testWidgets('getBooking fetches vendor bookings when isFromVendor is true', (
      tester,
    ) async {
      // Arrange: Set controller as vendor
      final vendorController = HomeController(
        networkCaller: mockNetwork,
        isFromVendor: true,
      );

      when(
        () => mockNetwork.getRequest(
          any(that: contains('booking-list-by-vendor')),
          token: any(named: 'token'),
        ),
      ).thenAnswer(
        (_) async => ResponseData(
          isSuccess: true,
          statusCode: 200,
          responseData: mockBookingJson,
          errorMessage: '',
        ),
      );

      // Act
      await vendorController.getBooking();

      // Assert
      expect(vendorController.isBookingLoading.value, isFalse);
      expect(vendorController.bookings.value, isNotNull);
      expect(vendorController.bookings.value!.data.first.id, 101);

      // Check that the filteredBookings getter works (Status is confirmed/not pending)
      expect(vendorController.filteredBookings.isNotEmpty, isTrue);
    });

    testWidgets('getBooking fetches user bookings for regular customers', (
      tester,
    ) async {
      // Arrange: Default is customer
      final userController = HomeController(
        networkCaller: mockNetwork,
        isFromVendor: false,
      );

      when(
        () => mockNetwork.getRequest(
          any(that: contains('booking-list-by-user')),
          token: any(named: 'token'),
        ),
      ).thenAnswer(
        (_) async => ResponseData(
          isSuccess: true,
          statusCode: 200,
          responseData: mockBookingJson,
          errorMessage: '',
        ),
      );

      // Act
      await userController.getBooking();

      // Assert
      expect(userController.bookings.value, isNotNull);
      expect(userController.bookings.value!.data.length, 1);

      verify(
        () => mockNetwork.getRequest(
          any(that: contains('booking-list-by-user')),
          token: any(named: 'token'),
        ),
      ).called(1);
    });

    testWidgets('getBooking handles API failure and toggles error state', (
      tester,
    ) async {
      final userController = HomeController(networkCaller: mockNetwork);

      when(
        () => mockNetwork.getRequest(any(), token: any(named: 'token')),
      ).thenAnswer(
        (_) async => ResponseData(
          isSuccess: false,
          statusCode: 500,
          responseData: null,
          errorMessage: 'Internal Server Error',
        ),
      );

      await tester.pumpWidget(GetMaterialApp(home: Container()));

      await userController.getBooking();

      expect(userController.isBookingError.value, isTrue);
      expect(userController.isBookingLoading.value, isFalse);

      await tester.pumpAndSettle();
    });
  });

  group('HomeController - getVendorProfile Tests', () {
    final mockVendorProfileJson = {
      "success": true,
      "vendor": {
        "id": 10,
        "user_id": 5,
        "business_name": "Pro Events",
        "category_id": 1,
        "account_balance": "250.00",
        "latitude": "23.8",
        "longitude": "90.4",
        "services_group": "Catering",
        "payment_information": null,
        "payment_type": null,
        "status": 1,
        "created_at": "2024-01-01T00:00:00Z",
        "updated_at": "2024-01-01T00:00:00Z",
        "deleted_at": null,
        "category_name": "Events",
        "user": {
          "id": 5,
          "first_name": "John",
          "last_name": "Doe",
          "phone_number": "123456",
          "email": "john@test.com",
          "email_verified_at": "2024-01-01T00:00:00Z",
          "image": "user.png",
          "background_image": "bg.png",
          "country": "USA",
          "city": "NY",
          "address": "Street 1",
          "subscription_plan_id": null,
          "is_first_time": false,
          "otp": null,
          "otp_expire_at": null,
          "last_seen": "2024-01-01T00:00:00Z",
          "fcm_token": null,
          "created_at": "2024-01-01T00:00:00Z",
          "updated_at": "2024-01-01T00:00:00Z",
          "deleted_at": null,
        },
        "category": {
          "id": 1,
          "name": "Events",
          "slug": "events",
          "image": null,
          "status": true,
          "created_at": "2024-01-01T00:00:00Z",
          "updated_at": "2024-01-01T00:00:00Z",
          "deleted_at": null,
        },
        "settings": {
          "id": 1,
          "vendor_id": 10,
          "service_type": ["In-person"],
          "offers_virtual": false,
          "team_size": ["1-5"],
          "max_travel_distance": "50km",
          "travel_policy": "Fixed rate",
          "payment_method": "Cash",
          "created_at": "2024-01-01T00:00:00Z",
          "updated_at": "2024-01-01T00:00:00Z",
        },
        "vendor_earning": [],
        "business_hours": [
          {
            "id": 1,
            "vendor_id": 10,
            "day": "Monday",
            "is_closed": 0,
            "open_time": "09:00",
            "close_time": "17:00",
            "created_at": "2024-01-01T00:00:00Z",
            "updated_at": "2024-01-01T00:00:00Z",
          },
        ],
      },
    };

    testWidgets(
      'getVendorProfile successfully fetches and parses vendor data',
      (tester) async {
        // Arrange
        when(
          () => mockNetwork.getRequest(any(), token: any(named: 'token')),
        ).thenAnswer(
          (_) async => ResponseData(
            isSuccess: true,
            statusCode: 200,
            responseData: mockVendorProfileJson,
            errorMessage: '',
          ),
        );

        // Act
        await controller.getVendorProfile();

        // Assert
        expect(controller.isVendorProfileLoading.value, isFalse);
        expect(controller.vendorUser.value, isNotNull);
        expect(controller.vendorUser.value!.vendor.businessName, "Pro Events");
        expect(controller.vendorUser.value!.vendor.user.email, "john@test.com");
        expect(
          controller.vendorUser.value!.vendor.businessHours.first.day,
          "Monday",
        );
      },
    );

    testWidgets('getVendorProfile sets error state on network failure', (
      tester,
    ) async {
      // Arrange
      when(
        () => mockNetwork.getRequest(any(), token: any(named: 'token')),
      ).thenAnswer(
        (_) async => ResponseData(
          isSuccess: false,
          statusCode: 404,
          responseData: null,
          errorMessage: 'Profile not found',
        ),
      );

      await tester.pumpWidget(
        GetMaterialApp(
          initialRoute: '/',
          getPages: [
            GetPage(name: '/', page: () => const Scaffold()),
            GetPage(
              name: '/vendorProfileInfo',
              page: () => const Scaffold(),
            ), // Add this!
          ],
        ),
      );

      // Act
      await controller.getVendorProfile();

      // Assert
      expect(controller.isVendorProfileLoading.value, isFalse);
      expect(controller.vendorUser.value, isNull);

      expect(Get.currentRoute, '/vendorProfileInfo');

      await tester.pumpAndSettle();
    });
  });

  group('HomeController - getDealsAndPromotions Tests', () {
    final mockDealsJson = {
      "success": true,
      "data": [
        {
          "id": 1,
          "vendor_id": 10,
          "category_id": 2,
          "title": "Summer Special",
          "slug": "summer-special",
          "description": "50% off all catering",
          "service_group": "Food",
          "valid_until": "2026-12-31",
          "subtitle": "Limited time",
          "price_per_event": "100.00",
          "capacity": 50,
          "venue_type": "Indoor",
          "location": "Downtown",
          "available_slots": null,
          "image": null,
          "is_active": 1,
          "category_subtype": null,
          "tags": null,
          "duration": 60,
          "is_featured": 1,
          "latitude": "40.7128",
          "longitude": "-74.0060",
          "created_at": "2024-01-01T00:00:00Z",
          "updated_at": "2024-01-01T00:00:00Z",
          "deleted_at": null,
          "reviews_sum_rating": 5,
          "available_dates": [
            {
              "id": 1,
              "package_id": 1,
              "event_id": null,
              "date": "2026-06-01",
              "created_at": "2024-01-01T00:00:00Z",
              "updated_at": "2024-01-01T00:00:00Z",
              "time_slots": [
                {
                  "id": 1,
                  "date_id": 1,
                  "time": "10:00",
                  "period": "AM",
                  "is_booked": 0,
                  "created_at": "2024-01-01T00:00:00Z",
                  "updated_at": "2024-01-01T00:00:00Z",
                },
              ],
            },
          ],
          "vendor": {
            "id": 10,
            "user_id": 5,
            "business_name": "Test Vendor",
            "category_id": 2,
            "account_balance": "0.00",
            "latitude": null,
            "longitude": null,
            "status": 1,
            "created_at": "2024-01-01T00:00:00Z",
            "updated_at": "2024-01-01T00:00:00Z",
            "deleted_at": null,
          },
          "category": {
            "id": 2,
            "name": "Catering",
            "slug": "catering",
            "image": null,
            "status": true,
            "created_at": "2024-01-01T00:00:00Z",
            "updated_at": "2024-01-01T00:00:00Z",
            "deleted_at": null,
          },
          "reviews": [],
        },
      ],
    };

    testWidgets(
      'getDealsAndPromotions success fetches and parses deep nested objects',
      (tester) async {
        when(
          () => mockNetwork.getRequest(any(), token: any(named: 'token')),
        ).thenAnswer(
          (_) async => ResponseData(
            isSuccess: true,
            statusCode: 200,
            responseData: mockDealsJson,
            errorMessage: '',
          ),
        );

        await controller.getDealsAndPromotions();

        expect(controller.isDealsAndPromotionLoading.value, isFalse);
        expect(controller.isDealsAndPromotionError.value, isNotNull);

        // Verify Deep Nesting
        final deal = controller.packages.value!.data.first;
        expect(deal.title, "Summer Special");
        expect(deal.availableDates.first.timeSlots.first.time, "10:00");
        expect(deal.vendor.businessName, "Test Vendor");
      },
    );

    testWidgets('getDealsAndPromotions failure sets error flag', (
      tester,
    ) async {
      when(
        () => mockNetwork.getRequest(any(), token: any(named: 'token')),
      ).thenAnswer(
        (_) async => ResponseData(
          isSuccess: false,
          statusCode: 500,
          responseData: null,
          errorMessage: 'Server Error',
        ),
      );

      // Pump GetMaterialApp for the snackbar call in your controller
      await tester.pumpWidget(GetMaterialApp(home: Container()));

      await controller.getDealsAndPromotions();

      expect(controller.isDealsAndPromotionError.value, isTrue);
      expect(controller.isDealsAndPromotionLoading.value, isFalse);

      await tester.pumpAndSettle();
    });
  });
}
