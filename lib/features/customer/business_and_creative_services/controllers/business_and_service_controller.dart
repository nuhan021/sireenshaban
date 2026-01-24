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

  //type 3 all controlles
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

  // Group 1
  firstNameController.text = user.firstName;
  lastNameController.text = user.lastName;
  emailController.text = user.email;
  phoneController.text = user.phoneNumber;

  // Group 2
  firstNameController2.text = user.firstName;
  lastNameController2.text = user.lastName;
  emailController2.text = user.email;
  phoneController2.text = user.phoneNumber;

  // Group 3 (The ones used in your UI)
  firstNameController3.text = user.firstName;
  lastNameController3.text = user.lastName;
  emailController3.text = user.email;
  phoneController3.text = user.phoneNumber;
  
  AppLoggerHelper.debug("Profile fields synced for all controllers.");
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
        maxWidth: 1000, // Resizes to reasonable dimensions
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
  // Pass the controllers from the UI
  required TextEditingController email,
  required TextEditingController phone,
  required TextEditingController projectDetails,
  File? image,
}) async {
  if (isSubmitting.value) return;

  if (vendorId <= 0) {
    SnackBarConstant.error('Invalid vendor.');
    return;
  }

  // Get the current user from the profile controller
  final UserModel? user = _profileController?.user.value;
  
  if (user == null) {
    SnackBarConstant.error('User profile not found.');
    return;
  }

  // 1. Extract values
  final emailVal = email.text.trim();
  final phoneVal = phone.text.trim();
  final details = projectDetails.text.trim();

  // 2. Validation
  if (details.isEmpty || phoneVal.isEmpty || emailVal.isEmpty) {
    SnackBarConstant.warning('Please fill all required fields.');
    return;
  }

  isSubmitting.value = true;

  try {
    final token = StorageService.token;
    if (token == null || token.isEmpty) {
      SnackBarConstant.error('Unauthorized');
      return;
    }

    final formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss')
        .format(serviceDateTime ?? DateTime.now());

    // Location logic
    final mapPosition = _mapController?.selectedPosition;
    double? resolvedLatitude = mapPosition?.latitude ?? latitude;
    double? resolvedLongitude = mapPosition?.longitude ?? longitude;

    // 3. Construct the Body (Using fixed user names)
    final body = <String, dynamic>{
      "vendor_id": vendorId,
      "first_name": user.firstName, // Fixed from profile
      "last_name": user.lastName,   // Fixed from profile
      "email": emailVal,
      "phone_number": phoneVal,
      "project_details": details,
      "payment_method": paymentMethod,
      "service_datetime": formattedDate,
    };
    
    // Add image if exists
    if (image != null) body["image"] = image;

    if (resolvedLatitude != null) body["location_latitude"] = resolvedLatitude;
    if (resolvedLongitude != null) body["location_longitude"] = resolvedLongitude;

    AppLoggerHelper.debug("Request Body: $body");

    final response = await _service.createServiceRequest(
      body: body,
      token: "Bearer $token",
    );

    // 4. Handle Response
    if (response.isSuccess || response.statusCode == 200 || response.statusCode == 201) {
      Get.snackbar("Success", "Request sent successfully");
      Get.back(); // Optional: Navigate back after success
    } else {
      SnackBarConstant.error(response.errorMessage ?? 'Failed to send request');
    }
  } catch (e) {
    AppLoggerHelper.error("Request Error: $e");
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
