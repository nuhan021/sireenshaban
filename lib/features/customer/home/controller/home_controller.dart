import 'package:get/get.dart';
import 'package:sireenshaban/core/services/network_caller.dart';
import 'package:sireenshaban/core/services/storage_service.dart';
import 'package:sireenshaban/core/utils/constants/api_constants.dart';
import 'package:sireenshaban/core/utils/constants/enums.dart';
import 'package:sireenshaban/core/utils/constants/snackbar_constant.dart';
import 'package:sireenshaban/core/utils/logging/logger.dart';
import 'package:sireenshaban/features/customer/home/model/eventModel.dart';
import 'package:sireenshaban/features/customer/home/model/packages_model.dart';
import 'package:sireenshaban/features/customer/home/model/trendingModel.dart';
import 'package:sireenshaban/features/customer/interest/categori_model.dart';

class HomeController extends GetxController {


  @override
  void onInit() {
    super.onInit();
    getAdditionalService();
    getDealsAndPromotions();
    getCommunityEvents();
    getTrendingNearby();
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


  Rx<CategoriModel?> categorys = Rx<CategoriModel?>(null);
  Rx<PackagesModel?> packages = Rx<PackagesModel?>(null);
  Rx<EventModel?> communityEvents = Rx<EventModel?>(null);
  Rx<TrendingModel?> trending = Rx<TrendingModel?>(null);






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

    final response = await _networkCaller.getRequest(
      ApiConstants.dealsAndPromotions,
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

