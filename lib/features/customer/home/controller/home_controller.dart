import 'package:get/get.dart';
import 'package:sireenshaban/core/services/network_caller.dart';
import 'package:sireenshaban/core/services/storage_service.dart';
import 'package:sireenshaban/core/utils/constants/api_constants.dart';
import 'package:sireenshaban/core/utils/constants/enums.dart';
import 'package:sireenshaban/core/utils/constants/snackbar_constant.dart';
import 'package:sireenshaban/core/utils/logging/logger.dart';
import 'package:sireenshaban/features/customer/home/model/eventModel.dart' hide Datum;
import 'package:sireenshaban/features/customer/home/model/packages_model.dart' hide Datum;
import 'package:sireenshaban/features/customer/home/model/trendingModel.dart' hide Datum;
import 'package:sireenshaban/features/customer/interest/categori_model.dart' hide Datum;
import 'package:sireenshaban/features/vendor/vendor_home/model/vendor_booking_model.dart';

class HomeController extends GetxController {
  HomeController({this.isFromVendor = false});

  final bool isFromVendor;

  @override
  void onInit() {
    super.onInit();
    if(isFromVendor) {
      getDealsAndPromotions();
      getBooking();
    } else {
      getAdditionalService();
      getDealsAndPromotions();
      getCommunityEvents();
      getTrendingNearby();
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



  Rx<CategoriModel?> categorys = Rx<CategoriModel?>(null);
  Rx<PackagesModel?> packages = Rx<PackagesModel?>(null);
  Rx<EventModel?> communityEvents = Rx<EventModel?>(null);
  Rx<TrendingModel?> trending = Rx<TrendingModel?>(null);
  Rx<VendorBookingModel?> bookings = Rx<VendorBookingModel?>(null);


  Rx<DateTime> selectedDate = DateTime.now().obs;

  List<Datum> get filteredBookings {
    if (bookings.value == null) return [];

    return bookings.value!.data.where((booking) {
      bool isSameDate = booking.date.year == selectedDate.value.year &&
          booking.date.month == selectedDate.value.month &&
          booking.date.day == selectedDate.value.day;

      bool isNotCompleted = booking.status?.toLowerCase() != 'completed';

      return isSameDate && isNotCompleted;
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
    SnackBarConstant.success("Category fetched successfully");
  }


  // fetch deals and promotions
  Future<void> getDealsAndPromotions() async {
    isDealsAndPromotionLoading.value = true;
    final token = StorageService.token;

    String endPoint = ApiConstants.dealsAndPromotions;

    if (isFromVendor) {
      // 🚨 Debug this line: Ensure StorageService.userId is not null or empty
      final userId = StorageService.userId;
      AppLoggerHelper.debug("Debugging Vendor URL: ${ApiConstants.dealsAndPromotions}/?vendor_id=$userId");
      endPoint = "${ApiConstants.dealsAndPromotions}/?vendor_id=$userId";
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
    SnackBarConstant.success("Deals & Promotions fetched successfully");
  }


  // fetch community events
  Future<void> getCommunityEvents() async {
    isCommunityEventsLoading.value = true;
    final token = StorageService.token;

    final response = await _networkCaller.getRequest(
      ApiConstants.communityEvents,
      token: "Bearer $token",
    );

    if(!response.isSuccess) {
      SnackBarConstant.error(response.errorMessage);
      isCommunityEventsLoading.value = false;
      isCommunityEventsError.value = true;
      return;
    }

    communityEvents.value = EventModel.fromJson(response.responseData);
    isCommunityEventsLoading.value = false;
    isCommunityEventsError.value = false;
    SnackBarConstant.success("Community events fetched successfully");
  }

  Future<void> getBooking() async {
    isBookingLoading.value = true;

    final token = StorageService.token;

    final response = await _networkCaller.getRequest(
      // "${ApiConstants.bookingsByVendor}/${StorageService.userId}",
      "${ApiConstants.bookingsByVendor}/1",
      token: "Bearer $token",
    );

    if(!response.isSuccess) {
      SnackBarConstant.error(response.errorMessage);
      isBookingLoading.value = false;
      isBookingError.value = true;
      return;
    }

    bookings.value = VendorBookingModel.fromJson(response.responseData);
    isBookingLoading.value = false;
    isBookingError.value = false;
    SnackBarConstant.success("Bookings fetched successfully");
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
    SnackBarConstant.success("Trending fetched successfully");
  }
}

