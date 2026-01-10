import 'package:flutter/foundation.dart';
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
  Rx<ServiceRequestDetail?> serviceRequestDetails = Rx<ServiceRequestDetail?>(
    null,
  );
  RxBool isSubmittingQuote = false.obs;

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
    AppLoggerHelper.debug("token is : $token");
    final authToken = token == null
        ? null
        : (token.startsWith("Bearer ") ? token : "Bearer $token");
    if (token == null) {
      isServiceRequestLoading.value = false;
      isServiceRequestError.value = true;
      SnackBarConstant.error("Unauthorized");
      return;
    }

    final response = await _services.getServiceRequests(token: authToken!);

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
    final authToken = token == null
        ? null
        : (token.startsWith("Bearer ") ? token : "Bearer $token");
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

  Future<bool> submitQuote({
    required int serviceRequestId,
    required double serviceFee,
    required double travelFee,
    required String message,
  }) async {
    isSubmittingQuote.value = true;

    final token = StorageService.token;
    final authToken = token == null
        ? null
        : (token.startsWith("Bearer ") ? token : "Bearer $token");

    if (token == null) {
      isSubmittingQuote.value = false;
      SnackBarConstant.error("Unauthorized");
      return false;
    }

    debugPrint("📋 [VendorBookingController] Submitting quote...");
    debugPrint("   - Service Request ID: $serviceRequestId");
    debugPrint("   - Service Fee: $serviceFee");
    debugPrint("   - Travel Fee: $travelFee");
    debugPrint("   - Message: $message");

    final response = await _services.submitQuote(
      token: authToken!,
      serviceRequestId: serviceRequestId,
      serviceFee: serviceFee,
      travelFee: travelFee,
      message: message,
    );

    debugPrint(
      "📋 [VendorBookingController] Quote response: ${response.isSuccess}",
    );
    debugPrint(
      "📋 [VendorBookingController] Response data: ${response.responseData}",
    );

    isSubmittingQuote.value = false;

    if (response.statusCode == 401) {
      SnackBarConstant.error("Unauthorized");
      return false;
    }

    if (!response.isSuccess &&
        response.statusCode != 200 &&
        response.statusCode != 201) {
      SnackBarConstant.error(response.errorMessage);
      return false;
    }

    SnackBarConstant.success("Quote submitted successfully");
    return true;
  }
}
