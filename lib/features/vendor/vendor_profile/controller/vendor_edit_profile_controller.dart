import 'package:flutter/material.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:sireenshaban/core/utils/constants/enums.dart';
import 'package:sireenshaban/core/utils/logging/logger.dart';
import 'package:sireenshaban/features/customer/home/controller/home_controller.dart';
import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/services/storage_service.dart';
import '../../../../core/controllers/user_controller.dart';
import 'package:image_picker/image_picker.dart';

import '../services/vendor_edit_profile_services.dart';
import '../../../../core/utils/constants/snackbar_constant.dart';
import '../../../../core/utils/constants/api_constants.dart';

class VendorEditProfileController extends GetxController {
  // Text controllers for the fields present in the UI
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController serviceController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController businessNameController = TextEditingController();
  final TextEditingController travelFeePolicyController =
      TextEditingController();

  RxnInt selectedCategoryId = RxnInt();
  Rx<ServicesGroup> selectedServiceGroup =
      ServicesGroup.businessAndCreativeServices.obs;

  RxBool offerVirtualMeeting = false.obs;
  RxString teamSize = '1'.obs;
  RxString travelDistance = '0'.obs;
  RxBool atMyBusinessAddress = false.obs;
  RxBool iTravelToTheClient = false.obs;
  RxBool isSubmitLoading = false.obs;
  RxBool issuccess = false.obs;

  String dialCode = '';
  LatLng? shopLocation;

  // Image picker and selected images
  final ImagePicker _picker = ImagePicker();
  final Rxn<XFile> profileImage = Rxn<XFile>();
  final Rxn<XFile> coverImage = Rxn<XFile>();
  final HomeController homeController = Get.find<HomeController>();

  final List<String> daysOrder = [
    'Saturday',
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
  ];

  final Map<String, RxBool> weekDays = {
    'Saturday': true.obs,
    'Sunday': false.obs,
    'Monday': true.obs,
    'Tuesday': true.obs,
    'Wednesday': true.obs,
    'Thursday': true.obs,
    'Friday': true.obs,
  };

  final Map<String, Rx<TimeOfDay>> startTimes = {
    'Saturday': TimeOfDay.now().obs,
    'Sunday': TimeOfDay.now().obs,
    'Monday': TimeOfDay.now().obs,
    'Tuesday': TimeOfDay.now().obs,
    'Wednesday': TimeOfDay.now().obs,
    'Thursday': TimeOfDay.now().obs,
    'Friday': TimeOfDay.now().obs,
  };

  final Map<String, Rx<TimeOfDay>> endTimes = {
    'Saturday': TimeOfDay.now().obs,
    'Sunday': TimeOfDay.now().obs,
    'Monday': TimeOfDay.now().obs,
    'Tuesday': TimeOfDay.now().obs,
    'Wednesday': TimeOfDay.now().obs,
    'Thursday': TimeOfDay.now().obs,
    'Friday': TimeOfDay.now().obs,
  };

  @override
  void onInit() {
    super.onInit();
    // Default/example values (kept from previous screen initState)
    if (homeController.vendorUser.value != null) {
      final vendor = homeController.vendorUser.value!.vendor;
      final user = vendor.user;
      final settings = vendor.settings;

      firstNameController.text = user.firstName;
      lastNameController.text = user.lastName;
      countryController.text = user.country;
      cityController.text = user.city;
      addressController.text = user.address ?? '';
      serviceController.text = 'Photographer';

      numberController.text = user.phoneNumber;
      businessNameController.text = vendor.businessName;
      selectedCategoryId.value = vendor.categoryId;

      offerVirtualMeeting.value = settings.offersVirtual;
      if (settings.teamSize.isNotEmpty) {
        teamSize.value = settings.teamSize.first;
      }
      travelDistance.value = settings.maxTravelDistance;
      travelFeePolicyController.text = settings.travelPolicy;
      atMyBusinessAddress.value = settings.serviceType.contains(
        "At my business address",
      );
      iTravelToTheClient.value = settings.serviceType.contains(
        "I travel to the client",
      );

      if (vendor.servicesGroup != null) {
        selectedServiceGroup.value = ServicesGroup.values.firstWhere(
          (group) => group.name == vendor.servicesGroup,
          orElse: () => selectedServiceGroup.value,
        );
      }

      final lat = double.tryParse(vendor.latitude);
      final lng = double.tryParse(vendor.longitude);
      if (lat != null && lng != null) {
        shopLocation = LatLng(lat, lng);
      }
    }
  }

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    countryController.dispose();
    cityController.dispose();
    addressController.dispose();
    serviceController.dispose();
    numberController.dispose();
    businessNameController.dispose();
    travelFeePolicyController.dispose();
    // no need to dispose XFile/Rxn
    super.onClose();
  }

  final RxBool isUpdating = false.obs;

  Future<bool> updateProfile() async {
    if (isUpdating.value) return false;
    isUpdating.value = true;
    var isSuccess = false;

    try {
      final fields = <String, String>{
        'first_name': firstNameController.text.trim(),
        'last_name': lastNameController.text.trim(),
        'country': countryController.text.trim(),
        'city': cityController.text.trim(),
        'address': addressController.text.trim(),
        'service': serviceController.text.trim(),
      };

      final http.Response resp = await VendorEditProfileService.editProfile(
        fields: fields,
        imagePath: profileImage.value?.path,
        backgroundImagePath: coverImage.value?.path,
      );

      if (resp.statusCode == 200 || resp.statusCode == 201) {
        // Try to parse returned profile and save to shared preferences
        try {
          final decoded = jsonDecode(resp.body);
          final data = decoded['data'];
          if (data != null && data is Map<String, dynamic>) {
            await StorageService.saveUserProfile(data);
            // Optionally update local text controllers with saved values
            firstNameController.text =
                data['first_name'] ?? firstNameController.text;
            lastNameController.text =
                data['last_name'] ?? lastNameController.text;
            countryController.text = data['country'] ?? countryController.text;
            cityController.text = data['city'] ?? cityController.text;
            addressController.text = data['address'] ?? addressController.text;

            // Refresh UserController so all screens update reactively
            final userCtrl = Get.find<UserController>();
            userCtrl.refreshFromStorage();

            if (homeController.isFromVendor) {
              await homeController.getVendorProfile();
            }
          }
        } catch (_) {
          // ignore parse errors
        }

        SnackBarConstant.success('Profile updated successfully');
        isSuccess = true;
      } else {
        final msg = resp.body.isNotEmpty
            ? resp.body
            : 'Failed: ${resp.statusCode}';
        AppLoggerHelper.info(msg.toString());
        SnackBarConstant.error(msg);
        AppLoggerHelper.error("Profile update failed: $msg");
      }
    } catch (e) {
      SnackBarConstant.error('Network error: $e');
    } finally {
      isUpdating.value = false;
    }
    return isSuccess;
  }

  Future<void> updateVendorProfile() async {
    if (isSubmitLoading.value) return;

    // Accessing the exact data from your Rx variable
    final vendorData = homeController.vendorUser.value?.vendor;

    if (vendorData == null) {
      SnackBarConstant.error("Vendor data is not available");
      return;
    }

    isSubmitLoading.value = true;

    try {
      final dio = Dio();
      dio.options.headers = {
        'Authorization': 'Bearer ${StorageService.token}',
        'Accept': 'application/json',
        'ngrok-skip-browser-warning': '69420',
      };

      FormData formData = FormData();

      // --- Basic Information from Vendor Model ---
      formData.fields.addAll([
        MapEntry('first_name', firstNameController.text.trim()),
        MapEntry('last_name', lastNameController.text.trim()),
        MapEntry('phone_number', vendorData.user.phoneNumber),
        MapEntry('country', countryController.text.trim()),
        MapEntry('city', cityController.text.trim()),
        MapEntry('address', addressController.text.trim()),
        MapEntry('business_name', vendorData.businessName),
        MapEntry('category_id', vendorData.categoryId.toString()),
        MapEntry('latitude', vendorData.latitude),
        MapEntry('longitude', vendorData.longitude),
        MapEntry('status', vendorData.status.toString()),
        MapEntry('services_group', vendorData.servicesGroup ?? ''),
      ]);

      // --- Settings from Vendor Model ---
      formData.fields.addAll([
        MapEntry(
          'settings[offers_virtual]',
          vendorData.settings.offersVirtual ? "1" : "0",
        ),
        MapEntry(
          'settings[max_travel_distance]',
          vendorData.settings.maxTravelDistance,
        ),
        MapEntry('settings[travel_policy]', vendorData.settings.travelPolicy),
        MapEntry('settings[payment_method]', vendorData.settings.paymentMethod),
      ]);

      // Mapping Team Size list
      for (var size in vendorData.settings.teamSize) {
        formData.fields.add(MapEntry('settings[team_size][]', size));
      }

      // Mapping Service Type list
      for (var type in vendorData.settings.serviceType) {
        formData.fields.add(MapEntry('settings[service_type][]', type));
      }

      // --- Business Hours from Vendor Model ---
      // Mapping the exact businessHours list from the model
      for (int i = 0; i < vendorData.businessHours.length; i++) {
        final hour = vendorData.businessHours[i];

        // Converting "15:06:00" to the "15.06" format required by your API
        String formattedOpen = hour.openTime
            .replaceAll(':', '.')
            .substring(0, 5);
        String formattedClose = hour.closeTime
            .replaceAll(':', '.')
            .substring(0, 5);

        formData.fields.addAll([
          MapEntry('business_hours[$i][day]', hour.day),
          MapEntry('business_hours[$i][is_closed]', hour.isClosed.toString()),
          MapEntry('business_hours[$i][open_time]', formattedOpen),
          MapEntry('business_hours[$i][close_time]', formattedClose),
        ]);
      }

      // --- Image Handling ---
      if (profileImage.value != null) {
        formData.files.add(
          MapEntry(
            'image',
            await MultipartFile.fromFile(profileImage.value!.path),
          ),
        );
      }

      if (coverImage.value != null) {
        formData.files.add(
          MapEntry(
            'background_image',
            await MultipartFile.fromFile(coverImage.value!.path),
          ),
        );
      }

      AppLoggerHelper.debug(
        'Submitting update to: ${ApiConstants.updateVendor}',
      );

      final response = await dio.post(
        ApiConstants.updateVendor,
        data: formData,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        bool isSuccess =
            response.data['success'] == true ||
            response.data['status'] == 'success';

        if (isSuccess) {
          issuccess.value = true;
          AppLoggerHelper.info(
            '✅ SUCCESS: Vendor profile updated successfully',
          );
          SnackBarConstant.success('Profile updated successfully!');

          // Refresh the global vendor state
          await homeController.getVendorProfile();

          await Future.delayed(const Duration(milliseconds: 500));
          Get.back();
        } else {
          SnackBarConstant.error(response.data['message'] ?? 'Update failed');
        }
      } else {
        SnackBarConstant.error('Server error: ${response.statusCode}');
      }
    } on DioException catch (e) {
      AppLoggerHelper.error(
        'Update Error',
        e.response?.data.toString() ?? e.message!,
      );
      SnackBarConstant.error(
        e.response?.data['message'] ?? 'An error occurred during update',
      );
    } finally {
      isSubmitLoading.value = false;
    }
  }

  Future<void> pickProfileImageFromGallery() async {
    try {
      final picked = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
        maxWidth: 1920,
        maxHeight: 1920,
      );
      if (picked != null) profileImage.value = picked;
    } catch (e) {
      SnackBarConstant.error('Failed to pick image: $e');
    }
  }

  Future<void> pickCoverImageFromGallery() async {
    try {
      final picked = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
        maxWidth: 1920,
        maxHeight: 1920,
      );
      if (picked != null) coverImage.value = picked;
    } catch (e) {
      SnackBarConstant.error('Failed to pick cover image: $e');
    }
  }
}
