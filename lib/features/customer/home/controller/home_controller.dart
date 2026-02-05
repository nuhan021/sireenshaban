import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
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
import 'package:sireenshaban/routes/app_routes.dart';

class HomeController extends GetxController {
  final NetworkCaller _networkCaller;
  HomeController({this.isFromVendor = false, NetworkCaller? networkCaller})
      : _networkCaller = networkCaller ?? NetworkCaller();

  final bool isFromVendor;

  @override
  void onInit() {
    super.onInit();
    if (isFromVendor) {
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
      getBooking();
    }
  }

  // --- Observables ---
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
  RxBool isSearchItemLoading = false.obs;
  RxBool isSearchItemError = false.obs;

  Rx<CategoriModel?> categorys = Rx<CategoriModel?>(null);
  Rx<PackagesModel?> packages = Rx<PackagesModel?>(null);
  Rx<PackagesModel?> categoryPackages = Rx<PackagesModel?>(null);
  Rx<EventModel?> communityEvents = Rx<EventModel?>(null);
  Rx<TrendingModel?> trending = Rx<TrendingModel?>(null);
  Rx<VendorBookingModel?> bookings = Rx<VendorBookingModel?>(null);
  Rx<VendorUserModel?> vendorUser = Rx<VendorUserModel?>(null);
  var filterCategory = Rxn<CategoriModel>();
  var searchQuery = ''.obs;
  Rx<DateTime> selectedDate = DateTime.now().obs;

  // --- Getters ---
  List<dynamic> get filteredCategories {
    if (searchQuery.value.isEmpty) {
      return categorys.value?.data ?? [];
    }
    return categorys.value?.data.where((category) {
      return (category.name ?? '').toLowerCase().contains(searchQuery.value.toLowerCase());
    }).toList() ?? [];
  }

  List<Datum> get filteredBookings {
    if (bookings.value == null) return [];
    return bookings.value!.data.where((booking) {
      bool isSameDate = booking.date.year == selectedDate.value.year &&
          booking.date.month == selectedDate.value.month &&
          booking.date.day == selectedDate.value.day;
      String status = booking.status.toLowerCase();
      bool isValidStatus = status != 'completed' && status != 'pending';
      return isSameDate && isValidStatus;
    }).toList();
  }

  // --- Utility Methods ---
  void updateSelectedDate(DateTime date) => selectedDate.value = date;
  void changeIsAdditionalServicesClose({required bool value}) => isAdditionalServicesClose.value = value;
  void changeCarouselCurrentIndex({required int value}) => carouselCurrentIndex.value = value;

  // --- API Methods with Try-Catch ---

  Future<void> getAdditionalService() async {
    try {
      isAdditionalServiceLoading.value = true;
      isAdditionalServiceError.value = false;
      final response = await _networkCaller.getRequest(
        ApiConstants.categories,
        token: "Bearer ${StorageService.token}",
      );

      if (response.isSuccess && response.responseData != null) {
        categorys.value = CategoriModel.fromJson(response.responseData);
      } else {
        isAdditionalServiceError.value = true;
        SnackBarConstant.error(response.errorMessage);
      }
    } catch (e) {
      isAdditionalServiceError.value = true;
      AppLoggerHelper.error("getAdditionalService catch: $e");
    } finally {
      isAdditionalServiceLoading.value = false;
    }
  }

  Future<void> getDealsAndPromotions() async {
    try {
      isDealsAndPromotionLoading.value = true;
      isDealsAndPromotionError.value = false;
      String endPoint = ApiConstants.dealsAndPromotions;

      if (isFromVendor) {
        final vendorId = StorageService.vendorId;
        endPoint = "${ApiConstants.dealsAndPromotions}/?vendor_id=$vendorId";
      }

      final response = await _networkCaller.getRequest(
        endPoint,
        token: "Bearer ${StorageService.token}",
      );

      if (response.isSuccess && response.responseData != null) {
        packages.value = PackagesModel.fromJson(response.responseData);
      } else {
        isDealsAndPromotionError.value = true;
        SnackBarConstant.error(response.errorMessage);
      }
    } catch (e) {
      isDealsAndPromotionError.value = true;
      AppLoggerHelper.error("getDealsAndPromotions catch: $e");
    } finally {
      isDealsAndPromotionLoading.value = false;
    }
  }

  Future<void> getPackagesByCategory({required String categorySlug}) async {
    try {
      isCategoryPackagesLoading.value = true;
      isCategoryPackagesError.value = false;
      final url = Uri.parse(ApiConstants.dealsAndPromotions)
          .replace(queryParameters: {'category_slug': categorySlug});

      final response = await _networkCaller.getRequest(
        url.toString(),
        token: "Bearer ${StorageService.token}",
      );

      if (response.isSuccess && response.responseData != null) {
        categoryPackages.value = PackagesModel.fromJson(response.responseData);
        SnackBarConstant.success("Packages fetched successfully");
      } else {
        isCategoryPackagesError.value = true;
        SnackBarConstant.error(response.errorMessage);
      }
    } catch (e) {
      isCategoryPackagesError.value = true;
      AppLoggerHelper.error("getPackagesByCategory catch: $e");
    } finally {
      isCategoryPackagesLoading.value = false;
    }
  }

  Future<void> getCommunityEvents() async {
    try {
      isCommunityEventsLoading.value = true;
      isCommunityEventsError.value = false;
      String url = ApiConstants.communityEvents;
      if (isFromVendor && StorageService.vendorId != null) {
        url = "$url?vendor_id=${StorageService.vendorId}";
      }

      final response = await _networkCaller.getRequest(
        url,
        token: "Bearer ${StorageService.token}",
      );

      if (response.isSuccess && response.responseData != null) {
        communityEvents.value = EventModel.fromJson(response.responseData);
      } else {
        isCommunityEventsError.value = true;
        SnackBarConstant.error(response.errorMessage);
      }
    } catch (e) {
      isCommunityEventsError.value = true;
      AppLoggerHelper.error("getCommunityEvents catch: $e");
    } finally {
      isCommunityEventsLoading.value = false;
    }
  }

  Future<void> getBooking() async {
    try {
      isBookingLoading.value = true;
      isBookingError.value = false;

      final userRole = StorageService.role?.toLowerCase();
      String endpoint = (isFromVendor || userRole == 'vendor')
          ? "${ApiConstants.bookingsByVendor}/${StorageService.vendorId ?? StorageService.userId}"
          : "${ApiConstants.bookingsByUser}/${StorageService.userId}";

      final response = await _networkCaller.getRequest(
        endpoint,
        token: "Bearer ${StorageService.token}",
      );

      if (response.isSuccess && response.responseData != null) {
        bookings.value = VendorBookingModel.fromJson(response.responseData);
      } else {
        isBookingError.value = true;
        SnackBarConstant.error(response.errorMessage);
      }
    } catch (e) {
      isBookingError.value = true;
      AppLoggerHelper.error("getBooking catch: $e");
    } finally {
      isBookingLoading.value = false;
    }
  }

  Future<void> getVendorProfile() async {
    try {
      isVendorProfileLoading.value = true;
      isVendorProfileError.value = false;
      final vendorId = StorageService.vendorId;

      final result = await _networkCaller.getRequest(
        "${ApiConstants.vendorProfile}/$vendorId",
        token: "Bearer ${StorageService.token}",
      );

      if (result.statusCode == 404) {
        Get.offAllNamed(AppRoute.vendorSetupScreen);
        return;
      }

      if (result.isSuccess && result.responseData != null) {
        vendorUser.value = VendorUserModel.fromJson(result.responseData);
      } else {
        isVendorProfileError.value = true;
        SnackBarConstant.error(result.errorMessage);
      }
    } catch (e) {
      isVendorProfileError.value = true;
      AppLoggerHelper.error("getVendorProfile catch: $e");
    } finally {
      isVendorProfileLoading.value = false;
    }
  }

  Future<void> getTrendingNearby() async {
    try {
      isTrendingNearbyLoading.value = true;
      isTrendingNearbyError.value = false;
      final response = await _networkCaller.getRequest(
        ApiConstants.trendingNearby,
        token: "Bearer ${StorageService.token}",
      );

      if (response.isSuccess && response.responseData != null) {
        trending.value = TrendingModel.fromJson(response.responseData);
        SnackBarConstant.success("Trending fetched successfully");
      } else {
        isTrendingNearbyError.value = true;
        SnackBarConstant.error(response.errorMessage);
      }
    } catch (e) {
      isTrendingNearbyError.value = true;
      AppLoggerHelper.error("getTrendingNearby catch: $e");
    } finally {
      isTrendingNearbyLoading.value = false;
    }
  }
}