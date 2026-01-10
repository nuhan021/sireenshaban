
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sireenshaban/features/vendor/vendor_profile_info/views/controller/vendor_profile_info_map_controller.dart';
import '../../../../core/services/storage_service.dart';
import '../../../../core/utils/constants/api_constants.dart';
import '../../../../core/utils/logging/logger.dart';

class CreateEventController extends GetxController {
  RxBool isLoading = false.obs;
  final ImagePicker _imagePicker = ImagePicker();

  // Observable States
  final Rxn<XFile> eventImage = Rxn<XFile>();
  final Rxn<DateTime> selectedDate = Rxn<DateTime>();
  final Rxn<TimeOfDay> selectedTime = Rxn<TimeOfDay>();
  final RxnInt selectedCategoryId = RxnInt();
  final RxString venueType = 'Indoor'.obs;
  final RxInt isPublic = 1.obs;

  // Form Controllers
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController ticketPriceController = TextEditingController();
  final TextEditingController maxAttendeesController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  final TextEditingController contactController = TextEditingController();

  // Location from Map
  final _mapController = Get.find<VendorProfileInfoMapController>();

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    ticketPriceController.dispose();
    maxAttendeesController.dispose();
    durationController.dispose();
    contactController.dispose();
    super.onClose();
  }

  Future<void> pickImage() async {
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );
      if (pickedFile != null) eventImage.value = pickedFile;
    } catch (e) {
      AppLoggerHelper.error('Image pick failed', e.toString());
    }
  }

  Future<void> submitEvent() async {
    if (!_validateEventForm()) return;

    isLoading.value = true;
    final latLng = _mapController.selectedPosition;
    final vendorId = StorageService.vendorId;

    AppLoggerHelper.info('--- SUBMITTING EVENT DATA ---');
    AppLoggerHelper.info('The latitude: ${latLng?.latitude.toString()}');
    AppLoggerHelper.info('The longitude: ${latLng?.longitude.toString()}');

    try {
      // API Endpoint
      var uri = Uri.parse("${ApiConstants.baseUrl}/events");
      var request = http.MultipartRequest('POST', uri);

      // Headers
      request.headers.addAll({
        'Authorization': 'Bearer ${StorageService.token}',
        'Accept': 'application/json',
        'ngrok-skip-browser-warning': '69420',
      });

      // 1. Basic Fields (Screen অনুযায়ী)
      request.fields['vendor_id'] = vendorId!;
      request.fields['category_id'] = selectedCategoryId.value.toString();
      request.fields['title'] = titleController.text.trim();
      request.fields['description'] = descriptionController.text.trim();

      // Date & Time formatting
      if (selectedDate.value != null) {
        request.fields['event_date'] = DateFormat(
          'yyyy-MM-dd',
        ).format(selectedDate.value!);
      }

      if (selectedTime.value != null) {
        // API সাধারণত HH:mm ফরম্যাট আশা করে
        final hour = selectedTime.value!.hour.toString().padLeft(2, '0');
        final minute = selectedTime.value!.minute.toString().padLeft(2, '0');
        request.fields['event_time'] = "$hour:$minute";
      }

      request.fields['venue_type'] = venueType.value;
      request.fields['location'] = ''; // বা আপনার লোকেশন ভ্যারিয়েবল
      request.fields['lat'] = latLng?.latitude.toString() ?? "";
      request.fields['lng'] = latLng?.longitude.toString() ?? "";
      request.fields['duration'] = durationController.text.trim();
      request.fields['ticket_price'] = ticketPriceController.text.trim();
      request.fields['max_attendees'] = maxAttendeesController.text.trim();
      request.fields['organizer_contact'] = contactController.text.trim();
      request.fields['is_public'] = "1";

      // 2. Image File (Screen অনুযায়ী key হচ্ছে 'image')
      if (eventImage.value != null) {
        request.files.add(
          await http.MultipartFile.fromPath('image', eventImage.value!.path),
        );
      }

      // 3. Execute Request
      var response = await request.send();
      final responseData = await response.stream.bytesToString();

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.back();
        AppLoggerHelper.info('Event Created Successfully');
        Get.snackbar(
          "Success",
          "Event Published Successfully",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
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

  // --- Validation Helper ---
  bool _validateEventForm() {
    if (eventImage.value == null) {
      Get.snackbar("Required", "Event image is missing");
      return false;
    }
    if (titleController.text.isEmpty || descriptionController.text.isEmpty) {
      Get.snackbar("Required", "Title and Description are required");
      return false;
    }
    if (selectedDate.value == null) {
      Get.snackbar("Required", "Please select an event date");
      return false;
    }
    return true;
  }
}
