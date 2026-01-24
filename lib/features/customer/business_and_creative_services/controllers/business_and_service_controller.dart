import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
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

  //type 1 all controlles

  final TextEditingController projectDetailsController =
      TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  //type 2 all controlles
  final TextEditingController projectDetailsController2 =
      TextEditingController();
  final TextEditingController firstNameController2 = TextEditingController();
  final TextEditingController lastNameController2 = TextEditingController();
  final TextEditingController phoneController2 = TextEditingController();
  final TextEditingController emailController2 = TextEditingController();

  //type 2 all controlles
  final TextEditingController projectDetailsController3 =
      TextEditingController();
  final TextEditingController firstNameController3 = TextEditingController();
  final TextEditingController lastNameController3 = TextEditingController();
  final TextEditingController phoneController3 = TextEditingController();
  final TextEditingController emailController3 = TextEditingController();

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
    if (firstNameController.text.trim().isEmpty &&
        // firstNameController2.text.trim().isEmpty ||
        firstNameController3.text.trim().isEmpty) {
      firstNameController.text = user.firstName;
    }
    if (lastNameController.text.trim().isEmpty &&
        // lastNameController2.text.trim().isEmpty ||
        lastNameController3.text.trim().isEmpty) {
      lastNameController.text = user.lastName;
    }
    if (emailController.text.trim().isEmpty &&
        // emailController2.text.trim().isEmpty ||
        emailController3.text.trim().isEmpty) {
      emailController.text = user.email;
    }
    if (phoneController.text.trim().isEmpty &&
        // phoneController2.text.trim().isEmpty ||
        phoneController3.text.trim().isEmpty) {
      phoneController.text = user.phoneNumber;
    }
  }
// Inside BusinessAndServiceController
var selectedImage = Rx<File?>(null);

void onSelectImage() async {
  File? image = await pickImage(ImageSource.gallery);
  if (image != null) {
    selectedImage.value = image;
  }
}

void clearImage() {
  selectedImage.value = null;
}
Future<File?> pickImage(ImageSource source) async {
  try {
    final ImagePicker picker = ImagePicker();
    
    // Pick the image
    final XFile? pickedFile = await picker.pickImage(
      source: source,
      imageQuality: 80, // Compresses the image to save data/bandwidth
      maxWidth: 1000,   // Resizes to reasonable dimensions
    );

    if (pickedFile != null) {
      // Convert XFile to standard File
      return File(pickedFile.path);
    } else {
      print("User cancelled the picker.");
      return null;
    }
  } catch (e) {
    print("Error picking image: $e");
    return null;
  }
}
  Future<void> sendServiceRequest({
    required int vendorId,
    String paymentMethod = 'Stripe',
    DateTime? serviceDateTime,
    double? latitude,
    double? longitude,
    TextEditingController? firstName,
    TextEditingController? lastName,
    TextEditingController? email,
    TextEditingController? phone,
    TextEditingController? projectDetails,
    File? image,
  }) async {
    if (isSubmitting.value) return;

    if (vendorId <= 0) {
      SnackBarConstant.error('Invalid vendor.');
      return;
    }

    // 1. Extract and trim strings from controllers
    // Using ?.text?.trim() ensures we don't crash if a controller is null
    final fName = firstName?.text.trim() ?? '';
    final lName = lastName?.text.trim() ?? '';
    final emailVal = email?.text.trim() ?? '';
    final phoneVal = phone?.text.trim() ?? '';
    final details = projectDetails?.text.trim() ?? '';

    AppLoggerHelper.debug(
      'fName: $fName, lName: $lName, emailVal: $emailVal, phoneVal: $phoneVal, details: $details',
    );

    // 2. Comprehensive Validation
    if (details.isEmpty ||
        fName.isEmpty ||
        lName.isEmpty ||
        phoneVal.isEmpty ||
        emailVal.isEmpty) {
      SnackBarConstant.warning('Please fill all required fields.');
      return;
    }

    isSubmitting.value = true;

    try {
      final token = StorageService.token;
      if (token == null || token.isEmpty) {
        isSubmitting.value = false;
        SnackBarConstant.error('Unauthorized');
        return;
      }

      // Date formatting
      final formattedDate = DateFormat(
        'yyyy-MM-dd HH:mm:ss',
      ).format(serviceDateTime ?? DateTime.now());

      // Location Logic
      final mapPosition = _mapController?.selectedPosition;
      double? resolvedLatitude = mapPosition?.latitude ?? latitude;
      double? resolvedLongitude = mapPosition?.longitude ?? longitude;

      if (resolvedLatitude == null || resolvedLongitude == null) {
        try {
          final currentPosition = await Geolocator.getCurrentPosition(
            locationSettings: const LocationSettings(
              accuracy: LocationAccuracy.bestForNavigation,
            ),
          );
          resolvedLatitude = currentPosition.latitude;
          resolvedLongitude = currentPosition.longitude;
        } catch (_) {
          /* Fallback to null */
        }
      }

      // 3. Construct the Body using the extracted values
      final body = <String, dynamic>{
        "vendor_id": vendorId,
        "first_name": fName,
        "last_name": lName,
        "email": emailVal,
        "phone_number": phoneVal,
        "project_details": details,
        "payment_method": paymentMethod,
        "service_datetime": formattedDate,
        "image": image,
      };

      if (resolvedLatitude != null)
        body["location_latitude"] = resolvedLatitude;
      if (resolvedLongitude != null)
        body["location_longitude"] = resolvedLongitude;

      final response = await _service.createServiceRequest(
        body: body,
        token: "Bearer $token",
      );

      // 4. Handle Response
      if (response.statusCode == 401) {
        SnackBarConstant.error('Unauthorized');
      } else if (response.isSuccess ||
          response.statusCode == 200 ||
          response.statusCode == 201) {
        final message = response.responseData is Map
            ? response.responseData["message"]
            : null;
        SnackBarConstant.success(
          message ?? 'Service request sent successfully.',
        );
      } else {
        SnackBarConstant.error(response.errorMessage);
      }
    } catch (e) {
      SnackBarConstant.error('An unexpected error occurred.');
    } finally {
      isSubmitting.value = false;
    }
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
