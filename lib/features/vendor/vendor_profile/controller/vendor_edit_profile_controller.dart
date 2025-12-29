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

  String dialCode = '';
  LatLng? shopLocation;

  // Image picker and selected images
  final ImagePicker _picker = ImagePicker();
  final Rxn<XFile> profileImage = Rxn<XFile>();
  final Rxn<XFile> coverImage = Rxn<XFile>();
  final HomeController homeController = Get.find<HomeController>();

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
      atMyBusinessAddress.value =
          settings.serviceType.contains("At my business address");
      iTravelToTheClient.value =
          settings.serviceType.contains("I travel to the client");

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

  Future<bool> updateVendorProfile() async {
    if (isUpdating.value) return false;
    isUpdating.value = true;
    var isSuccess = false;

    try {
      final dio = Dio();
      final token = StorageService.token;

      dio.options.headers = {
        'Authorization': token != null ? 'Bearer $token' : '',
        'Accept': 'application/json',
        'ngrok-skip-browser-warning': '69420',
      };

      final formData = FormData();

      final vendor = homeController.vendorUser.value?.vendor;
      final user = vendor?.user;
      final settings = vendor?.settings;

      String? resolveText(TextEditingController controller, String? fallback) {
        final trimmed = controller.text.trim();
        if (trimmed.isNotEmpty) return trimmed;
        final fallbackTrimmed = fallback?.trim();
        if (fallbackTrimmed != null && fallbackTrimmed.isNotEmpty) {
          return fallbackTrimmed;
        }
        return null;
      }

      void addIfNotEmpty(String key, String? value) {
        final trimmed = value?.trim();
        if (trimmed != null && trimmed.isNotEmpty) {
          formData.fields.add(MapEntry(key, trimmed));
        }
      }

      addIfNotEmpty(
        'first_name',
        resolveText(firstNameController, user?.firstName),
      );
      addIfNotEmpty('last_name', resolveText(lastNameController, user?.lastName));
      addIfNotEmpty('phone_number', () {
        final dialed = '${dialCode}${numberController.text.trim()}'.trim();
        if (dialed.isNotEmpty) return dialed;
        return user?.phoneNumber;
      }());
      addIfNotEmpty('country', resolveText(countryController, user?.country));
      addIfNotEmpty('city', resolveText(cityController, user?.city));
      addIfNotEmpty('address', resolveText(addressController, user?.address));
      addIfNotEmpty(
        'business_name',
        resolveText(businessNameController, vendor?.businessName),
      );

      final categoryId = selectedCategoryId.value ?? vendor?.categoryId;
      if (categoryId != null) {
        formData.fields.add(MapEntry('category_id', categoryId.toString()));
      }

      final lat = shopLocation?.latitude.toString() ?? vendor?.latitude;
      final lng = shopLocation?.longitude.toString() ?? vendor?.longitude;
      addIfNotEmpty('latitude', lat);
      addIfNotEmpty('longitude', lng);
      addIfNotEmpty('status', (vendor?.status ?? 1).toString());
      addIfNotEmpty(
        'services_group',
        vendor?.servicesGroup ?? selectedServiceGroup.value.name,
      );

      addIfNotEmpty(
        'settings[offers_virtual]',
        (offerVirtualMeeting.value ? "1" : "0"),
      );
      addIfNotEmpty('settings[team_size][]', teamSize.value);
      addIfNotEmpty('settings[max_travel_distance]', travelDistance.value);
      addIfNotEmpty(
        'settings[travel_policy]',
        resolveText(travelFeePolicyController, settings?.travelPolicy),
      );
      addIfNotEmpty(
        'settings[payment_method]',
        settings?.paymentMethod ?? 'Stripe',
      );

      if (atMyBusinessAddress.value) {
        addIfNotEmpty(
          'settings[service_type][]',
          "At my business address",
        );
      }
      if (iTravelToTheClient.value) {
        addIfNotEmpty(
          'settings[service_type][]',
          "I travel to the client",
        );
      }

      if (vendor?.businessHours != null) {
        for (var i = 0; i < vendor!.businessHours.length; i++) {
          final hour = vendor.businessHours[i];
          addIfNotEmpty('business_hours[$i][day]', hour.day);
          addIfNotEmpty(
            'business_hours[$i][is_closed]',
            hour.isClosed.toString(),
          );
          addIfNotEmpty('business_hours[$i][open_time]', hour.openTime);
          addIfNotEmpty('business_hours[$i][close_time]', hour.closeTime);
        }
      }

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

      if (formData.fields.isEmpty && formData.files.isEmpty) {
        SnackBarConstant.error('Nothing to update.');
        return false;
      }

      final response = await dio.post(
        ApiConstants.updateVendor,
        data: formData,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        isSuccess =
            response.data['success'] == true ||
            response.data['status'] == 'success';

        if (isSuccess) {
          SnackBarConstant.success('Profile updated successfully');
        } else {
          SnackBarConstant.error(
            response.data['message'] ?? 'Failed to update',
          );
        }
      } else {
        SnackBarConstant.error('Server error: ${response.statusCode}');
      }
    } on DioException catch (e) {
      SnackBarConstant.error(e.response?.data.toString() ?? e.message ?? '');
    } finally {
      isUpdating.value = false;
    }

    return isSuccess;
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
