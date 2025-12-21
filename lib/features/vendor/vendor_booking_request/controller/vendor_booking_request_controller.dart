import 'package:get/get.dart';
import 'package:sireenshaban/core/services/storage_service.dart';
import 'package:sireenshaban/core/utils/constants/enums.dart';
import 'package:sireenshaban/core/utils/constants/snackbar_constant.dart';
import 'package:sireenshaban/core/utils/logging/logger.dart';
import 'package:sireenshaban/features/vendor/vendor_booking_request/model/service_request_model.dart';
import 'package:sireenshaban/features/vendor/vendor_booking_request/services/vendor_booking_request_services.dart';

class VendorBookingController extends GetxController {
  final VendorBookingRequestServices _services = VendorBookingRequestServices();

  var bookingRequest = BookingRequest.newRequest.obs;

  RxBool isServiceRequestLoading = false.obs;
  RxBool isServiceRequestError = false.obs;
  RxList<ServiceRequestListItem> serviceRequests =
      <ServiceRequestListItem>[].obs;
  RxBool isServiceRequestDetailsLoading = false.obs;
  RxBool isServiceRequestDetailsError = false.obs;
  Rx<ServiceRequestDetail?> serviceRequestDetails =
      Rx<ServiceRequestDetail?>(null);

  @override
  void onInit() {
    super.onInit();
    getServiceRequests();
  }

  void changeBookingRequest(BookingRequest val) {
    bookingRequest.value = val;
  }

  List<ServiceRequestListItem> get visibleRequests {
    return serviceRequests;
  }

  int get newRequestCount => serviceRequests.length;

  Future<void> getServiceRequests() async {
    isServiceRequestLoading.value = true;

    final token = StorageService.token;
    AppLoggerHelper.debug("token is : ${token}");
    final authToken =
        token == null ? null : (token.startsWith("Bearer ") ? token : "Bearer $token");
    if (token == null) {
      isServiceRequestLoading.value = false;
      isServiceRequestError.value = true;
      SnackBarConstant.error("Unauthorized");
      return;
    }

    final response = await _services.getServiceRequests(
      token: authToken!,
    );

    if (response.statusCode == 401) {
      isServiceRequestLoading.value = false;
      isServiceRequestError.value = true;
      SnackBarConstant.error("Unauthorized");
      return;
    }

    if (!response.isSuccess && response.statusCode != 200) {
      AppLoggerHelper.debug("request Body:${response.responseData}");
      isServiceRequestLoading.value = false;
      isServiceRequestError.value = true;
      SnackBarConstant.error(response.errorMessage);
      return;
    }

    if (response.responseData is! Map<String, dynamic> ||
        response.responseData["requests"] == null) {
      isServiceRequestLoading.value = false;
      isServiceRequestError.value = true;
      SnackBarConstant.error("Invalid response data");
      return;
    }

    final data = ServiceRequestListResponse.fromJson(
      response.responseData as Map<String, dynamic>,
    );
    serviceRequests.assignAll(data.requests);
    isServiceRequestLoading.value = false;
    isServiceRequestError.value = false;
  }

  Future<void> getServiceRequestDetails({required int requestId}) async {
    isServiceRequestDetailsLoading.value = true;
    isServiceRequestDetailsError.value = false;
    serviceRequestDetails.value = null;

    final token = StorageService.token;
    final authToken =
        token == null ? null : (token.startsWith("Bearer ") ? token : "Bearer $token");
    if (token == null) {
      isServiceRequestDetailsLoading.value = false;
      isServiceRequestDetailsError.value = true;
      SnackBarConstant.error("Unauthorized");
      return;
    }

    final response = await _services.getServiceRequestDetails(
      token: authToken!,
      requestId: requestId,
    );

    if (response.statusCode == 401) {
      isServiceRequestDetailsLoading.value = false;
      isServiceRequestDetailsError.value = true;
      SnackBarConstant.error("Unauthorized");
      return;
    }

    if (!response.isSuccess && response.statusCode != 200) {
      isServiceRequestDetailsLoading.value = false;
      isServiceRequestDetailsError.value = true;
      SnackBarConstant.error(response.errorMessage);
      return;
    }

    if (response.responseData is! Map<String, dynamic> ||
        response.responseData["service_request"] == null) {
      isServiceRequestDetailsLoading.value = false;
      isServiceRequestDetailsError.value = true;
      SnackBarConstant.error("Invalid response data");
      return;
    }

    final data = ServiceRequestDetailResponse.fromJson(
      response.responseData as Map<String, dynamic>,
    );
    serviceRequestDetails.value = data.serviceRequest;
    isServiceRequestDetailsLoading.value = false;
    isServiceRequestDetailsError.value = false;
  }
}
