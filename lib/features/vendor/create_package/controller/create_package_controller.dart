import 'package:flutter/material.dart';
import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sireenshaban/features/vendor/vendor_profile_info/views/controller/vendor_profile_info_map_controller.dart';
import 'package:sireenshaban/features/vendor/vendor_setup/controller/vendor_setup_screen_controller.dart';
import '../../../../core/utils/logging/logger.dart';

class CreatePackageController extends GetxController {
  // --- Private Dependencies ---
  final ImagePicker _imagePicker = ImagePicker();

  // --- Observable States (UI Reactive) ---
  final Rxn<XFile> bannerImage = Rxn<XFile>();
  final RxString venueType = 'Indoor'.obs;
  final RxString shift = 'Morning'.obs;

  /// Stores selected dates as Keys and their corresponding time slots as Values.
  /// Example: { DateTime(2025, 12, 21): ["10:00 AM", "02:00 PM"] }
  final RxMap<DateTime, List<String>> selectedSlots = <DateTime, List<String>>{}.obs;

  /// Available time pool for the user to pick from.
  final RxList<String> customTimeSlots = <String>[
    "10:00 AM",
    "12:00 PM",
    "02:00 PM"
  ].obs;

  LatLng? selectedPosition = Get.find<VendorProfileInfoMapController>().selectedPosition as LatLng?;
  final RxnInt selectedCategoryId = RxnInt();
  final RxString selectedVenueType = 'Indoor'.obs;

  // --- Text Controllers (Form Fields) ---
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController capacityController = TextEditingController();

  @override
  void onClose() {
    // Dispose controllers to prevent memory leaks
    titleController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    capacityController.dispose();
    super.onClose();
  }

  // --- Business Logic Methods ---

  /// Picks a banner image from the device gallery.
  Future<void> pickBannerImageFromGallery() async {
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80, // Optimized for network upload
      );

      if (pickedFile != null) {
        bannerImage.value = pickedFile;
        AppLoggerHelper.info('Image picked: ${pickedFile.path}');
      }
    } catch (e) {
      AppLoggerHelper.error('Image picking failed', e.toString());
      Get.snackbar(
          "Upload Error",
          "Could not access gallery. Please check permissions.",
          snackPosition: SnackPosition.BOTTOM
      );
    }
  }

  /// Toggles the selection of a time slot for a specific date.
  void toggleSlot(DateTime date, String time) {
    // Normalize date to remove time components for consistent map keys
    final DateTime dayKey = DateTime(date.year, date.month, date.day);

    final List<String> currentDaySlots = List.from(selectedSlots[dayKey] ?? []);

    if (currentDaySlots.contains(time)) {
      currentDaySlots.remove(time);
      AppLoggerHelper.debug('Removed slot: $time from ${dayKey.toIso8601String()}');
    } else {
      currentDaySlots.add(time);
      AppLoggerHelper.debug('Added slot: $time to ${dayKey.toIso8601String()}');
    }

    if (currentDaySlots.isEmpty) {
      selectedSlots.remove(dayKey);
    } else {
      selectedSlots[dayKey] = currentDaySlots;
    }

    selectedSlots.refresh();
  }

  /// Adds a new time slot to the global pool after validation.
  void addCustomTime(String newTime) {
    if (customTimeSlots.contains(newTime)) {
      Get.snackbar(
          "Duplicate Entry",
          "This time slot is already available.",
          backgroundColor: Colors.amberAccent,
          colorText: Colors.black
      );
      return;
    }

    customTimeSlots.add(newTime);
    _sortTimeSlots();
    AppLoggerHelper.info('New custom time added: $newTime');
  }

  /// Removes a time slot from the pool and cleans up all associated dates.
  void removeTimeSlot(String time) {
    customTimeSlots.remove(time);

    // Clean up any selected dates that contained this time slot
    selectedSlots.forEach((date, times) {
      times.removeWhere((t) => t == time);
    });

    // Remove keys with empty lists to keep the map clean
    selectedSlots.removeWhere((date, times) => times.isEmpty);

    selectedSlots.refresh();
    AppLoggerHelper.info('Time slot $time removed globally.');
  }

  /// Internal helper to keep time slots organized chronologically.
  void _sortTimeSlots() {
    customTimeSlots.sort((a, b) {
      final DateFormat format = DateFormat("hh:mm a");
      return format.parse(a).compareTo(format.parse(b));
    });
  }

  /// Formats all selection data into a structured Map for debugging and API submission.
  void submitPackage() {
    // 1. Prepare the availability data in a readable format
    // Converts Map<DateTime, List<String>> to Map<String, List<String>>
    final Map<String, List<String>> availabilitySummary = selectedSlots.map(
          (date, times) => MapEntry(
          DateFormat('yyyy-MM-dd').format(date),
          times
      ),
    );

    // 2. Construct the final submission payload
    final Map<String, dynamic> submissionData = {
      "banner_image": bannerImage.value?.path ?? "No image selected",
      "package_details": {
        "title": titleController.text.trim(),
        "description": descriptionController.text.trim(),
        "price": priceController.text.trim(),
        "capacity": capacityController.text.trim(),
        "venue_type": venueType.value,
        "shift": shift.value,
      },
      "location": {
        "lat": selectedPosition?.lat,
        "lng": selectedPosition?.lng,
      },
      "availability": availabilitySummary,
    };

    // 3. Log the structured data
    AppLoggerHelper.info('--- SUBMITTING PACKAGE DATA ---');
    debugPrint(submissionData.toString());

    // // Check if data is valid before proceeding
    // if (_validateForm()) {
    //   Get.snackbar("Success", "Package data prepared for upload",
    //       backgroundColor: Colors.green, colorText: Colors.white);
    // }
  }

  /// Private validation helper
  bool _validateForm() {
    if (bannerImage.value == null) {
      Get.snackbar("Error", "Please upload a banner image");
      return false;
    }
    if (titleController.text.isEmpty || priceController.text.isEmpty) {
      Get.snackbar("Error", "Title and Price are required");
      return false;
    }
    if (selectedSlots.isEmpty) {
      Get.snackbar("Error", "Please select at least one date and time slot");
      return false;
    }
    return true;
  }
}