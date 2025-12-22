import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart';
import 'package:sireenshaban/features/vendor/vendor_profile_info/views/controller/vendor_profile_info_map_controller.dart';
import '../../../../core/utils/logging/logger.dart';

class CreateEventController extends GetxController {
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
      final XFile? pickedFile = await _imagePicker.pickImage(source: ImageSource.gallery, imageQuality: 80);
      if (pickedFile != null) eventImage.value = pickedFile;
    } catch (e) {
      AppLoggerHelper.error('Image pick failed', e.toString());
    }
  }

  void submitEvent() {
    final latLng = _mapController.selectedPosition;
    final Map<String, dynamic> submissionData = {
      "vendor_id": 2, // Usually comes from an Auth service
      "category_id": selectedCategoryId.value,
      "title": titleController.text.trim(),
      "description": descriptionController.text.trim(),
      "event_date": selectedDate.value != null ? DateFormat('yyyy-MM-dd').format(selectedDate.value!) : null,
      "event_time": selectedTime.value != null ? "${selectedTime.value!.hour}:${selectedTime.value!.minute}" : null,
      "venue_type": venueType.value,
      "lat": latLng?.latitude, // Dynamic access
      "lng": latLng?.longitude, // Dynamic access
      "image": eventImage.value?.path,
      "duration": durationController.text.trim(),
      "ticket_price": ticketPriceController.text.trim(),
      "max_attendees": maxAttendeesController.text.trim(),
      "organizer_contact": contactController.text.trim(),
      "is_public": isPublic.value,
    };

    AppLoggerHelper.info('--- SUBMITTING EVENT DATA ---');
    debugPrint(submissionData.toString());
  }
}