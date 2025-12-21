import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sireenshaban/core/services/storage_service.dart';
import 'package:sireenshaban/core/utils/constants/snackbar_constant.dart';
import 'package:sireenshaban/core/utils/logging/logger.dart';
import 'package:sireenshaban/features/customer/business_and_creative_services/services/business_and_service.dart';
import 'package:sireenshaban/features/customer/profile/controllers/profile_controller.dart';
import 'package:sireenshaban/features/customer/profile/models/user_model.dart';
import 'package:sireenshaban/features/vendor/vendor_profile_info/views/controller/vendor_profile_info_map_controller.dart';

class BusinessAndServiceController extends GetxController {
  final BusinessAndService _service = BusinessAndService();

  final TextEditingController projectDetailsController =
      TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  RxBool isSubmitting = false.obs;

  ProfileController? _profileController;
  VendorProfileInfoMapController? _mapController;

  @override
  void onInit() {
    super.onInit();

    _profileController = Get.isRegistered<ProfileController>()
        ? Get.find<ProfileController>()
        : Get.put(ProfileController());

    if (_profileController != null) {
      _syncProfileFields(_profileController!.user.value);
      ever<UserModel?>(_profileController!.user, _syncProfileFields);
    }

    if (Get.isRegistered<VendorProfileInfoMapController>()) {
      _mapController = Get.find<VendorProfileInfoMapController>();
    }
  }

  void _syncProfileFields(UserModel? user) {
    if (user == null) return;
    if (firstNameController.text.trim().isEmpty) {
      firstNameController.text = user.firstName;
    }
    if (lastNameController.text.trim().isEmpty) {
      lastNameController.text = user.lastName;
    }
    if (emailController.text.trim().isEmpty) {
      emailController.text = user.email;
    }
  }

  Future<void> sendServiceRequest({
    required int vendorId,
    String paymentMethod = 'Stripe',
    DateTime? serviceDateTime,
    double? latitude,
    double? longitude,
  }) async {
    if (isSubmitting.value) return;
    if (vendorId <= 0) {
      SnackBarConstant.error('Invalid vendor.');
      return;
    }

    final profileUser = _profileController?.user.value;
    final firstName = (profileUser?.firstName ?? firstNameController.text)
        .trim();
    final lastName = (profileUser?.lastName ?? lastNameController.text).trim();
    final email = (profileUser?.email ?? emailController.text).trim();

    if (projectDetailsController.text.trim().isEmpty ||
        firstName.isEmpty ||
        lastName.isEmpty ||
        phoneController.text.trim().isEmpty) {
      SnackBarConstant.warning('Please fill all required fields.');
      return;
    }

    isSubmitting.value = true;

    final token = StorageService.token;
    if (token == null || token.isEmpty) {
      isSubmitting.value = false;
      SnackBarConstant.error('Unauthorized');
      return;
    }

    final formattedDate = DateFormat(
      'yyyy-MM-dd HH:mm:ss',
    ).format(serviceDateTime ?? DateTime.now());

    final mapPosition = _mapController?.selectedPosition;
    double? resolvedLatitude = mapPosition?.latitude ?? latitude;
    double? resolvedLongitude = mapPosition?.longitude ?? longitude;

    if (resolvedLatitude == null || resolvedLongitude == null) {
      try {
        final currentPosition = await Geolocator.getCurrentPosition(
          locationSettings: const LocationSettings(
            accuracy: LocationAccuracy.bestForNavigation,
            distanceFilter: 5,
          ),
        );
        resolvedLatitude ??= currentPosition.latitude;
        resolvedLongitude ??= currentPosition.longitude;
      } catch (_) {
        // Fallback to leaving location null if permissions/services fail.
      }
    }

    final body = <String, dynamic>{
      "vendor_id": vendorId,
      "first_name": firstName,
      "last_name": lastName,
      "location_latitude": resolvedLatitude,
      "location_longitude": resolvedLongitude,
      "service_datetime": formattedDate,
      "project_details": projectDetailsController.text.trim(),
      "payment_method": paymentMethod,
      "phone_number": phoneController.text.trim(),
    };

    if (email.isNotEmpty) {
      body["email"] = email;
    }

    if (resolvedLatitude != null) {
      body["location_latitude"] = resolvedLatitude;
    }
    if (resolvedLongitude != null) {
      body["location_longitude"] = resolvedLongitude;
    }

    final response = await _service.createServiceRequest(
      body: body,
      token: "Bearer $token",
    );

    if (response.statusCode == 401) {
      isSubmitting.value = false;
      SnackBarConstant.error('Unauthorized');
      return;
    }

    final isOk =
        response.isSuccess ||
        response.statusCode == 200 ||
        response.statusCode == 201;
    if (!isOk) {
      isSubmitting.value = false;
      SnackBarConstant.error(response.errorMessage);
      return;
    }

    isSubmitting.value = false;
    final message = response.responseData is Map
        ? response.responseData["message"]?.toString()
        : null;
    AppLoggerHelper.debug("booking request:${response.responseData}");
    SnackBarConstant.success(message ?? 'Service request sent successfully.');
  }

  @override
  void onClose() {
    projectDetailsController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    super.onClose();
  }
}
