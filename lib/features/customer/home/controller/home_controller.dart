import 'package:get/get.dart';
import 'package:sireenshaban/core/controllers/user_controller.dart';
import 'package:sireenshaban/core/services/network_caller.dart';
import 'package:sireenshaban/core/services/storage_service.dart';
import 'package:sireenshaban/core/utils/constants/api_constants.dart';
import 'package:sireenshaban/core/utils/constants/snackbar_constant.dart';
import 'package:sireenshaban/core/utils/logging/logger.dart';
import 'package:sireenshaban/features/customer/home/model/eventModel.dart' hide Datum;
import 'package:sireenshaban/features/customer/home/model/packages_model.dart' hide Datum;
import 'package:sireenshaban/features/customer/home/model/trendingModel.dart' hide Datum;
import 'package:sireenshaban/features/customer/interest/categori_model.dart' hide Datum;
import 'package:sireenshaban/features/vendor/vendor_home/model/vendor_booking_model.dart';
import 'package:sireenshaban/features/vendor/vendor_profile/model/vendor_user_model.dart';

class HomeController extends GetxController {
  HomeController({this.isFromVendor = false});

  final bool isFromVendor;

  @override
  void onInit() {
    super.onInit();

    if(isFromVendor) {
      getVendorProfile();
      getDealsAndPromotions();
      getBooking();
      getAdditionalService();
      getCommunityEvents();
    } else {
      getAdditionalService();
      getDealsAndPromotions();
      getCommunityEvents();
      getTrendingNearby();
      getBooking(); // Also fetch bookings for regular users
    }
  }

  final NetworkCaller _networkCaller = NetworkCaller();
  RxBool isAdditionalServicesClose = false.obs;
  RxInt carouselCurrentIndex = 1.obs;

  RxBool isAdditionalServiceLoading = false.obs;
  RxBool isAdditionalServiceError = false.obs;

  RxBool isDealsAndPromotionLoading = false.obs;
  RxBool isDealsAndPromotionError = false.obs;

  RxBool isCommunityEventsLoading = false.obs;
  RxBool isCommunityEventsError = false.obs;

  RxBool isTrendingNearbyLoading = false.obs;
  RxBool isTrendingNearbyError = false.obs;

  RxBool isBookingLoading = false.obs;
  RxBool isBookingError = false.obs;

  RxBool isVendorProfileLoading = false.obs;
  RxBool isVendorProfileError = false.obs;

  RxBool isCategoryPackagesLoading = false.obs;
  RxBool isCategoryPackagesError = false.obs;




  Rx<CategoriModel?> categorys = Rx<CategoriModel?>(null);
  Rx<PackagesModel?> packages = Rx<PackagesModel?>(null);
  Rx<PackagesModel?> categoryPackages = Rx<PackagesModel?>(null);
  Rx<EventModel?> communityEvents = Rx<EventModel?>(null);
  Rx<TrendingModel?> trending = Rx<TrendingModel?>(null);
  Rx<VendorBookingModel?> bookings = Rx<VendorBookingModel?>(null);
  Rx<VendorUserModel?> vendorUser = Rx<VendorUserModel?>(null);


  Rx<DateTime> selectedDate = DateTime.now().obs;

  List<Datum> get filteredBookings {
    if (bookings.value == null) return [];

    return bookings.value!.data.where((booking) {
      bool isSameDate = booking.date.year == selectedDate.value.year &&
          booking.date.month == selectedDate.value.month &&
          booking.date.day == selectedDate.value.day;

      String status = booking.status?.toLowerCase() ?? '';
      bool isValidStatus = status != 'completed' && status != 'pending';

      return isSameDate && isValidStatus;
    }).toList();
  }

  // 3. Method to update date from UI
  void updateSelectedDate(DateTime date) {
    selectedDate.value = date;
  }



  void changeIsAdditionalServicesClose({required bool value}) {
    isAdditionalServicesClose.value = value;
  }

  void changeCarouselCurrentIndex({required int value}) {
    carouselCurrentIndex.value = value;
  }


  // fetch additional service
  Future<void> getAdditionalService() async {
    isAdditionalServiceLoading.value = true;
    final token = StorageService.token;

    final response = await _networkCaller.getRequest(
      ApiConstants.categories,
      token: "Bearer $token",
    );

    if(!response.isSuccess) {
      SnackBarConstant.error(response.errorMessage);
      isAdditionalServiceLoading.value = false;
      isAdditionalServiceError.value = true;
      return;
    }

    categorys.value = CategoriModel.fromJson(response.responseData);
    isAdditionalServiceLoading.value = false;
    isAdditionalServiceError.value = false;
    // SnackBarConstant.success("Category fetched successfully");
  }


  // fetch deals and promotions
  Future<void> getDealsAndPromotions() async {
    isDealsAndPromotionLoading.value = true;
    final token = StorageService.token;

    String endPoint = ApiConstants.dealsAndPromotions;

    if (isFromVendor) {
      // 🚨 Debug this line: Ensure StorageService.userId is not null or empty
      final vendorId = StorageService.vendorId;
      AppLoggerHelper.debug("Debugging Vendor URL: ${ApiConstants.dealsAndPromotions}/?vendor_id=$vendorId");
      endPoint = "${ApiConstants.dealsAndPromotions}/?vendor_id=$vendorId";
    }

    AppLoggerHelper.debug("End");

    final response = await _networkCaller.getRequest(
      endPoint,
      token: "Bearer $token",
    );

    if(!response.isSuccess) {
      SnackBarConstant.error(response.errorMessage);
      isDealsAndPromotionLoading.value = false;
      isDealsAndPromotionError.value = true;
      return;
    }

    packages.value = PackagesModel.fromJson(response.responseData);
    isDealsAndPromotionLoading.value = false;
    isDealsAndPromotionError.value = false;
    // SnackBarConstant.success("Deals & Promotions fetched successfully");
  }

  // fetch packages by category slug
  Future<void> getPackagesByCategory({required String categorySlug}) async {
    isCategoryPackagesLoading.value = true;
    final token = StorageService.token;

    final url = Uri.parse(ApiConstants.dealsAndPromotions).replace(
      queryParameters: {'category_slug': categorySlug},
    );

    final response = await _networkCaller.getRequest(
      url.toString(),
      token: "Bearer $token",
    );

    if (!response.isSuccess) {
      SnackBarConstant.error(response.errorMessage);
      isCategoryPackagesLoading.value = false;
      isCategoryPackagesError.value = true;
      return;
    }

    categoryPackages.value = PackagesModel.fromJson(response.responseData);
    isCategoryPackagesLoading.value = false;
    isCategoryPackagesError.value = false;
    SnackBarConstant.success("Packages fetched successfully");
  }

  // fetch community events
  Future<void> getCommunityEvents() async {
    isCommunityEventsLoading.value = true;
    final token = StorageService.token;
    final vendorId = StorageService.vendorId;

    String url = ApiConstants.communityEvents;
    if (isFromVendor && vendorId != null) {
      url = "$url?vendor_id=$vendorId";
    }

    final response = await _networkCaller.getRequest(
      url,
      token: "Bearer $token",
    );

    if (!response.isSuccess) {
      SnackBarConstant.error(response.errorMessage);
      isCommunityEventsLoading.value = false;
      isCommunityEventsError.value = true;
      return;
    }

    communityEvents.value = EventModel.fromJson(response.responseData);
    isCommunityEventsLoading.value = false;
    isCommunityEventsError.value = false;
    // SnackBarConstant.success("Community events fetched successfully");
  }

  Future<void> getBooking() async {
    isBookingLoading.value = true;

    final token = StorageService.token;
    final userId = StorageService.userId;
    final vendorId = StorageService.vendorId;
    final userRole = StorageService.role?.toLowerCase();
    
    // Log all relevant parameters
    AppLoggerHelper.debug("📋 [Booking] ========== BOOKING FETCH START ==========");
    AppLoggerHelper.debug("📋 [Booking] Token exists: ${token != null && token.isNotEmpty}");
    AppLoggerHelper.debug("📋 [Booking] User ID: $userId");
    AppLoggerHelper.debug("📋 [Booking] Vendor ID: $vendorId");
    AppLoggerHelper.debug("📋 [Booking] User Role: $userRole");
    AppLoggerHelper.debug("📋 [Booking] isFromVendor flag: $isFromVendor");
    AppLoggerHelper.debug("📋 [Booking] Full user profile: ${StorageService.userProfile}");
    
    // Determine the correct endpoint based on user role
    String endpoint;
    if (isFromVendor || userRole == 'vendor') {
      // For vendors, use vendorId if available, otherwise fallback to userId
      final idToUse = vendorId ?? userId;
      endpoint = "${ApiConstants.bookingsByVendor}/$idToUse";
      AppLoggerHelper.debug("📋 [Booking] Using VENDOR endpoint: $endpoint");
      AppLoggerHelper.debug("📋 [Booking] Using ID: $idToUse (vendorId: $vendorId, userId: $userId)");
    } else {
      endpoint = "${ApiConstants.bookingsByUser}/$userId";
      AppLoggerHelper.debug("📋 [Booking] Using USER endpoint: $endpoint");
    }

    final response = await _networkCaller.getRequest(
      endpoint,
      token: "Bearer $token",
    );

    AppLoggerHelper.debug("📋 [Booking] Response success: ${response.isSuccess}");
    AppLoggerHelper.debug("📋 [Booking] Response status code: ${response.statusCode}");
    AppLoggerHelper.debug("📋 [Booking] Response data: ${response.responseData}");

    if(!response.isSuccess) {
      AppLoggerHelper.debug("❌ [Booking] Error: ${response.errorMessage}");
      SnackBarConstant.error(response.errorMessage);
      isBookingLoading.value = false;
      isBookingError.value = true;
      return;
    }

    bookings.value = VendorBookingModel.fromJson(response.responseData);
    AppLoggerHelper.debug("✅ [Booking] Parsed ${bookings.value?.data.length ?? 0} bookings");
    
    // Log each booking status
    if (bookings.value != null) {
      for (var booking in bookings.value!.data) {
        AppLoggerHelper.debug("   📌 Booking ID: ${booking.id}, Status: ${booking.status}, Date: ${booking.date}");
      }
    }
    
    AppLoggerHelper.debug("📋 [Booking] ========== BOOKING FETCH END ==========");
    
    isBookingLoading.value = false;
    isBookingError.value = false;
    // SnackBarConstant.success("Bookings fetched successfully");
  }


  Future<void> getVendorProfile() async {
    isVendorProfileLoading.value = true;

    final token = StorageService.token;

    final vendorid = StorageService.vendorId;


    AppLoggerHelper.info("The actual vendor is: ${vendorId}");


    final result = await _networkCaller.getRequest(
      "${ApiConstants.vendorProfile}/$vendorId",
      token: "Bearer $token",
    );

    if(!result.isSuccess) {
      SnackBarConstant.error(result.errorMessage);
      isVendorProfileLoading.value = false;
      isVendorProfileError.value = true;
      return;
    }

    vendorUser.value = VendorUserModel.fromJson(result.responseData);
    isVendorProfileLoading.value = false;
    isVendorProfileError.value = false;
    // SnackBarConstant.success("Vendor profile fetched successfully");
  }


  // fetch trending nearby
  Future<void> getTrendingNearby() async {
    isTrendingNearbyLoading.value = true;
    final token = StorageService.token;

    final response = await _networkCaller.getRequest(
      ApiConstants.trendingNearby,
      token: "Bearer $token",
    );

    if(!response.isSuccess) {
      SnackBarConstant.error(response.errorMessage);
      isTrendingNearbyLoading.value = false;
      isTrendingNearbyError.value = true;
      return;
    }

    trending.value = TrendingModel.fromJson(response.responseData);
    isTrendingNearbyLoading.value = false;
    isTrendingNearbyError.value = false;
    // SnackBarConstant.success("Trending fetched successfully");
  }

  // fetch packages by category slug
  Future<void> getPackagesByCategory({required String categorySlug}) async {
    isCategoryPackagesLoading.value = true;
    final token = StorageService.token;

    final url = Uri.parse(ApiConstants.dealsAndPromotions).replace(
      queryParameters: {'category_slug': categorySlug},
    );

    final response = await _networkCaller.getRequest(
      url.toString(),
      token: "Bearer $token",
    );

    if (!response.isSuccess) {
      SnackBarConstant.error(response.errorMessage);
      isCategoryPackagesLoading.value = false;
      isCategoryPackagesError.value = true;
      return;
    }

    categoryPackages.value = PackagesModel.fromJson(response.responseData);
    isCategoryPackagesLoading.value = false;
    isCategoryPackagesError.value = false;
    SnackBarConstant.success("Packages fetched successfully");
  }
}
