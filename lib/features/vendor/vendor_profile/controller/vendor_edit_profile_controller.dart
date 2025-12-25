import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../../core/services/storage_service.dart';
import '../../../../core/controllers/user_controller.dart';
import 'package:image_picker/image_picker.dart';

import '../services/vendor_edit_profile_services.dart';
import '../../../../core/utils/constants/snackbar_constant.dart';

class VendorEditProfileController extends GetxController {
  // Text controllers for the fields present in the UI
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController serviceController = TextEditingController();

  // Image picker and selected images
  final ImagePicker _picker = ImagePicker();
  final Rxn<XFile> profileImage = Rxn<XFile>();
  final Rxn<XFile> coverImage = Rxn<XFile>();

  @override
  void onInit() {
    super.onInit();
    final profile = StorageService.userProfile;
    if (profile == null) return;

    firstNameController.text = StorageService.firstName ?? '';
    lastNameController.text = StorageService.lastName ?? '';
    countryController.text = StorageService.country ?? '';
    cityController.text = StorageService.city ?? '';
    addressController.text = StorageService.address ?? '';
    serviceController.text =
        StorageService.service ?? StorageService.businessName ?? '';
  }

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    countryController.dispose();
    cityController.dispose();
    addressController.dispose();
    serviceController.dispose();
    // no need to dispose XFile/Rxn
    super.onClose();
  }

  final RxBool isUpdating = false.obs;

  Future<void> updateProfile() async {
    if (isUpdating.value) return;
    isUpdating.value = true;

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
          final fieldUpdates = <String, dynamic>{
            'first_name': fields['first_name'] ?? '',
            'last_name': fields['last_name'] ?? '',
            'country': fields['country'] ?? '',
            'city': fields['city'] ?? '',
            'address': fields['address'] ?? '',
            'service': fields['service'] ?? '',
          };
          if (data != null && data is Map<String, dynamic>) {
            await StorageService.saveUserProfileMerged(
              <String, dynamic>{...fieldUpdates, ...data},
            );
          } else {
            await StorageService.saveUserProfileMerged(fieldUpdates);
          }

          firstNameController.text = StorageService.firstName ?? '';
          lastNameController.text = StorageService.lastName ?? '';
          countryController.text = StorageService.country ?? '';
          cityController.text = StorageService.city ?? '';
          addressController.text = StorageService.address ?? '';
          serviceController.text =
              StorageService.service ?? StorageService.businessName ?? '';

          // Refresh UserController so all screens update reactively
          final userCtrl = Get.find<UserController>();
          userCtrl.refreshFromStorage();
        } catch (_) {
          // ignore parse errors
        }

        SnackBarConstant.success('Profile updated successfully');
      } else {
        final msg = resp.body.isNotEmpty
            ? resp.body
            : 'Failed: ${resp.statusCode}';
        SnackBarConstant.error(msg);
      }
    } catch (e) {
      SnackBarConstant.error('Network error: $e');
    } finally {
      isUpdating.value = false;
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
