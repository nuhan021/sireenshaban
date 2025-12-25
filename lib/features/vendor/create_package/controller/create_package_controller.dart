import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:sireenshaban/core/services/storage_service.dart';
import 'package:sireenshaban/core/utils/constants/api_constants.dart';
import 'package:sireenshaban/features/vendor/vendor_profile_info/views/controller/vendor_profile_info_map_controller.dart';
import '../../../../core/utils/logging/logger.dart';

enum ServicesGroup {
  businessAndCreativeServices,
  personalCareAndEducation,
  homeAndMaintenanceServices
}

class CreatePackageController extends GetxController {
  final ImagePicker _imagePicker = ImagePicker();
  final VendorProfileInfoMapController _mapController = Get.find<VendorProfileInfoMapController>();

  // --- Reactive States ---
  final RxBool isLoading = false.obs;
  final Rxn<XFile> bannerImage = Rxn<XFile>();
  final RxString venueType = 'Indoor'.obs;
  final RxString shift = 'Morning'.obs;
  final RxnInt selectedCategoryId = RxnInt();
  final Rxn<ServicesGroup> selectedServiceGroup = Rxn<ServicesGroup>();

  // --- Selection Data ---
  final RxMap<DateTime, List<String>> selectedSlots = <DateTime, List<String>>{}.obs;
  final RxList<String> customTimeSlots = <String>["09:30 AM", "12:00 PM", "03:00 PM"].obs;

  // --- Form Controllers ---
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController capacityController = TextEditingController();

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    capacityController.dispose();
    super.onClose();
  }

  // --- Image Handling ---
  Future<void> pickBannerImageFromGallery() async {
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );
      if (pickedFile != null) {
        bannerImage.value = pickedFile;
      }
    } catch (e) {
      AppLoggerHelper.error('Image picking failed', e.toString());
    }
  }

  // --- Slot Management ---
  void toggleSlot(DateTime date, String time) {
    final DateTime dayKey = DateTime(date.year, date.month, date.day);
    final List<String> currentDaySlots = List.from(selectedSlots[dayKey] ?? []);

    if (currentDaySlots.contains(time)) {
      currentDaySlots.remove(time);
    } else {
      currentDaySlots.add(time);
    }

    if (currentDaySlots.isEmpty) {
      selectedSlots.remove(dayKey);
    } else {
      selectedSlots[dayKey] = currentDaySlots;
    }
    selectedSlots.refresh();
  }

  void addCustomTime(String newTime) {
    if (!customTimeSlots.contains(newTime)) {
      customTimeSlots.add(newTime);
      customTimeSlots.sort((a, b) => DateFormat.jm().parse(a).compareTo(DateFormat.jm().parse(b)));
    }
  }

  void removeTimeSlot(String time) {
    customTimeSlots.remove(time);
    selectedSlots.forEach((date, times) => times.removeWhere((t) => t == time));
    selectedSlots.removeWhere((date, times) => times.isEmpty);
    selectedSlots.refresh();
  }

  // --- Form Submission ---
  Future<void> submitPackage() async {
    if (!_validateForm()) return;

    isLoading.value = true;
    final latLng = _mapController.selectedPosition;
    final vendorId = StorageService.vendorId;

    AppLoggerHelper.info('The latitude: ${latLng?.latitude.toString()}');
    AppLoggerHelper.info('The latitude: ${latLng?.longitude.toString()}');

    try {

      // Credentials and URL from your Postman setup
      var uri = Uri.parse("${ApiConstants.baseUrl}/packages"); // Update with actual base URL
      var request = http.MultipartRequest('POST', uri);

      request.headers.addAll({
        'Authorization': 'Bearer ${StorageService.token}',
        'Accept': 'application/json',
        'ngrok-skip-browser-warning': '69420',
      });

      // 1. Basic Form Data
      request.fields['vendor_id'] = vendorId!;
      request.fields['category_id'] = selectedCategoryId.value.toString();
      request.fields['title'] = titleController.text.trim();
      request.fields['price_per_event'] = priceController.text.trim();
      request.fields['capacity'] = capacityController.text.trim();
      request.fields['venue_type'] = venueType.value;
      request.fields['description'] = descriptionController.text.trim();
      request.fields['service_group'] = selectedServiceGroup.value?.name ?? "";

      // Additional metadata from your Postman Screenshot
      // request.fields['location'] = "New York";
      request.fields['latitude'] = latLng?.latitude.toString() ?? "";
      request.fields['longitude'] = latLng?.longitude.toString() ?? "";
      // request.fields['duration'] = "120";
      request.fields['valid_until'] = "2025-12-25";
      // request.fields['subtitle'] = "Special Package Creation";

      // 2. Image File
      if (bannerImage.value != null) {
        request.files.add(await http.MultipartFile.fromPath('image', bannerImage.value!.path));
      }

      // 3. Nested Array Logic: dates[i][slots][j][time]
      int dateIndex = 0;
      selectedSlots.forEach((date, times) {
        request.fields['dates[$dateIndex][date]'] = DateFormat('yyyy-MM-dd').format(date);

        for (int slotIndex = 0; slotIndex < times.length; slotIndex++) {
          String timeValue = times[slotIndex];

          // নিশ্চিত করুন timeValue টি স্ট্রিং (যেমন: "09:30 AM")
          String formattedTime = _formatTo24H(timeValue);

          request.fields['dates[$dateIndex][slots][$slotIndex][time]'] = formattedTime;
          request.fields['dates[$dateIndex][slots][$slotIndex][period]'] = _determinePeriod(timeValue);
        }
        dateIndex++;
      });

      // 4. Execute Request
      var response = await request.send();
      final responseData = await response.stream.bytesToString();

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.back();
        AppLoggerHelper.info('Created');
        AppLoggerHelper.info(responseData);
        Get.snackbar("Success", "Package Published Successfully", backgroundColor: Colors.green, colorText: Colors.white);
      } else {
        AppLoggerHelper.error("Server Error", responseData);
        Get.snackbar("Error", "Failed to upload: ${response.statusCode}");
      }
    } catch (e) {
      AppLoggerHelper.error("Connection Error", e.toString());
      Get.snackbar("Error", "Check your internet connection");
    } finally {
      isLoading.value = false;
    }
  }

  // --- Helper Formatting ---
  String _formatTo24H(String time) {
    try {
      // যদি ইনপুট "09:30 AM" হয়, তবে এটি HH:mm:ss (09:30:00) এ রূপান্তর করবে
      // .parse করার সময় নিশ্চিত করুন ফরম্যাটটি ইনপুটের সাথে মিলছে (যেমন: "h:mm a")
      DateFormat inputFormat = DateFormat("h:mm a");
      DateTime tempDate = inputFormat.parse(time.trim().toUpperCase());
      return DateFormat("HH:mm:ss").format(tempDate);
    } catch (e) {
      AppLoggerHelper.error("Time Parse Error", "Input: $time, Error: $e");
      // যদি কনভার্ট না হয়, তবে অন্তত AM/PM বাদ দিয়ে পাঠানোর চেষ্টা করুন (Fallback)
      return time.replaceAll(RegExp(r'[a-zA-Z\s]'), '');
    }
  }

  String _determinePeriod(String time) {
    String lower = time.toLowerCase();
    if (lower.contains("am")) return "morning";
    int hour = int.parse(time.split(":")[0]);
    if (hour >= 12 || hour < 5) return "afternoon";
    return "evening";
  }

  bool _validateForm() {
    if (bannerImage.value == null) {
      Get.snackbar("Required", "Banner image is missing");
      return false;
    }
    if (selectedCategoryId.value == null || selectedServiceGroup.value == null) {
      Get.snackbar("Required", "Please select Category and Service Group");
      return false;
    }
    if (selectedSlots.isEmpty) {
      Get.snackbar("Required", "Please select at least one date and time slot");
      return false;
    }
    return true;
  }
}