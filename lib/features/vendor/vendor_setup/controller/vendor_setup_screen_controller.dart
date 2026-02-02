import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sireenshaban/core/services/storage_service.dart';
import 'package:sireenshaban/core/utils/constants/api_constants.dart';
import 'package:sireenshaban/core/utils/constants/colors.dart';
import 'package:sireenshaban/core/utils/logging/logger.dart';
import 'package:sireenshaban/routes/app_routes.dart';

import '../../../../core/services/network_caller.dart';
import '../../../../core/utils/constants/enums.dart';
import '../../../../core/utils/constants/snackbar_constant.dart';
import '../../../customer/interest/categori_model.dart';

class VendorSetupScreenController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getCategory();
  }

  final NetworkCaller _networkCaller = NetworkCaller();

  Rx<ServicesGroup> selectedServiceGroup =
      ServicesGroup.businessAndCreativeServices.obs;

  String getServiceGroupName(ServicesGroup group) {
    switch (group) {
      case ServicesGroup.businessAndCreativeServices:
        return "Business and Creative Services";
      case ServicesGroup.personalCareAndEducation:
        return "Personal Care and Education";
      case ServicesGroup.homeAndMaintenanceServices:
        return "Home and Maintenance Services";
    }
  }

  RxBool isCategoriLoading = false.obs;
  RxBool isCategoriError = false.obs;
  Rx<CategoriModel?> categoriModel = Rx<CategoriModel?>(null);

  RxnInt selectedCategoryId = RxnInt();
  RxString selectedCategoryName = 'Select Category'.obs;

  Future<void> getCategory() async {
    isCategoriLoading.value = true;
    final token = StorageService.token;

    if (token == null) {
      isCategoriLoading.value = false;
      isCategoriError.value = true;
      SnackBarConstant.error("Token not found. Please login again.");
      return;
    }

    AppLoggerHelper.debug(token);

    final response = await _networkCaller.getRequest(
      ApiConstants.categories,
      token: "Bearer $token",
    );

    if (response.statusCode == 401) {
      isCategoriError.value = true;
      isCategoriLoading.value = false;
      SnackBarConstant.error("Unauthorized");
      return;
    }

    if (!response.isSuccess) {
      isCategoriLoading.value = false;
      isCategoriError.value = true;
      SnackBarConstant.error(response.errorMessage);
      return;
    }

    isCategoriError.value = false;

    categoriModel.value = CategoriModel.fromJson(response.responseData);

    isCategoriLoading.value = false;
    SnackBarConstant.success("Category fetched successfully");
  }

  final PageController pageController = PageController();

  RxBool isSubmitLoading = false.obs;

  RxInt currentPageIndex = 0.obs;

  final ImagePicker _picker = ImagePicker();

  final businessCategoryList = [
    'Saloon',
    'Restaurant',
    'Hotel',
    'Motel',
    'Plumber',
    'Electrician',
  ];

  final priceTypeList = ['Per KM'];

  final travelDistanceList = [
    '1 km',
    '2 km',
    '3 km',
    '4 km',
    '5 km',
    '6 km',
    '7 km',
    '8 km',
    '9 km',
    '10 km',
    '11 km',
    '12 km',
    '13 km',
    '14 km',
    '15 km',
    '16 km',
    '17 km',
    '18 km',
    '19 km',
    '20 km',
    '21 km',
    '22 km',
    '23 km',
    '24 km',
    '25 km',
    '26 km',
    '27 km',
    '28 km',
    '29 km',
    '30 km',
  ];

  // personal information
  final Rxn<XFile> profileImage = Rxn<XFile>(); // profile picture
  final Rxn<XFile> coverImage = Rxn<XFile>(); // cover picture
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController roadController = TextEditingController();
  final TextEditingController travelFeeController = TextEditingController();
  final TextEditingController travelFeePolicyController =
      TextEditingController();
  String countryCode = 'US';
  String dialCode = '';

  // business information
  final TextEditingController businessNameController = TextEditingController();
  late RxString businessCategory = businessCategoryList[0].obs;
  late RxString priceType = priceTypeList[0].obs;
  late RxString travelDistance = travelDistanceList[14].obs;

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

  RxBool atMyBusinessAddress = true.obs;
  RxBool iTravelToTheClient = false.obs;
  RxBool offerVirtualMeeting = false.obs;
  RxString teamSize = '1'.obs;

  Future<void> pickProfileImageFromGalary() async {
    try {
      final picked = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
        maxWidth: 1920,
        maxHeight: 1920,
      );
      if (picked != null) {
        profileImage.value = picked;
      }
    } catch (e) {
      AppLoggerHelper.error('error', e.toString());
      Get.snackbar('Error', 'Failed to pick image: $e');
    }
  }

  Future<void> pickCoverImageFromGalary() async {
    try {
      final picked = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
        maxWidth: 1920,
        maxHeight: 1920,
      );
      if (picked != null) {
        coverImage.value = picked;
      }
    } catch (e) {
      AppLoggerHelper.error('error', e.toString());
      Get.snackbar('Error', 'Failed to pick image: $e');
    }
  }

  void addLocation(String country, String city, String road) {
    countryController.text = country;
    cityController.text = city;
    roadController.text = road;

    Get.snackbar(
      'Success',
      'Location added',
      backgroundColor: AppColors.success.withValues(alpha: 0.1),
    );
  }

  LatLng shopLocation = const LatLng(40.74003379333115, -73.99088234777156);

  void goNext() {
    if (currentPageIndex.value < 2) {
      pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      currentPageIndex.value++;
    }
  }

  void goBack() {
    if (currentPageIndex.value > 0) {
      pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      currentPageIndex.value--;
    }
  }

  String getFormatedTime(BuildContext context, TimeOfDay time) {
    return time.format(context);
  }

  Future<void> submit() async {
    if (isSubmitLoading.value) return;
    if (selectedCategoryId.value == null) {
      SnackBarConstant.error("Please select a business category");
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

      // --- Basic Information ---
      formData.fields.addAll([
        MapEntry('first_name', firstNameController.text.trim()),
        MapEntry('last_name', lastNameController.text.trim()),
        MapEntry('phone_number', "$dialCode${numberController.text.trim()}"),
        MapEntry('country', countryController.text.trim()),
        MapEntry('city', cityController.text.trim()),
        MapEntry('address', roadController.text.trim()),
        MapEntry('business_name', businessNameController.text.trim()),
        MapEntry('category_id', selectedCategoryId.value.toString()),
        MapEntry('latitude', shopLocation.latitude.toString()),
        MapEntry('longitude', shopLocation.longitude.toString()),
        MapEntry('status', '1'),
        MapEntry('services_group', selectedServiceGroup.value.name),
      ]);

      // --- Settings (Array format maintenance) ---
      formData.fields.addAll([
        MapEntry(
          'settings[offers_virtual]',
          offerVirtualMeeting.value ? "1" : "0",
        ),
        MapEntry('settings[team_size][]', teamSize.value.toString()),
        MapEntry(
          'settings[max_travel_distance]',
          travelDistance.value.toString(),
        ),
        MapEntry(
          'settings[travel_policy]',
          travelFeePolicyController.text.trim(),
        ),
        MapEntry('settings[payment_method]', "Stripe"),
      ]);

      if (atMyBusinessAddress.value) {
        formData.fields.add(
          const MapEntry('settings[service_type][]', "At my business address"),
        );
      }
      if (iTravelToTheClient.value) {
        formData.fields.add(
          const MapEntry('settings[service_type][]', "I travel to the client"),
        );
      }

      // --- Business Hours (Fixed: Format as Decimal Number) ---
      for (int i = 0; i < daysOrder.length; i++) {
        final day = daysOrder[i];
        final startTime = startTimes[day]!.value;
        final endTime = endTimes[day]!.value;
        final isClosed = !weekDays[day]!.value;

        // লজিক: 10:30 AM কে "10.30" স্ট্রিং হিসেবে পাঠানো যা সার্ভারে Number হিসেবে গণ্য হবে
        // padLeft নিশ্চিত করে যে 9:05 হবে 09.05
        String openTimeDecimal =
            '${startTime.hour.toString().padLeft(2, '0')}.${startTime.minute.toString().padLeft(2, '0')}';
        String closeTimeDecimal =
            '${endTime.hour.toString().padLeft(2, '0')}.${endTime.minute.toString().padLeft(2, '0')}';

        formData.fields.addAll([
          MapEntry('business_hours[$i][day]', day),
          MapEntry('business_hours[$i][is_closed]', isClosed ? "1" : "0"),
          MapEntry('business_hours[$i][open_time]', openTimeDecimal), // "10.30"
          MapEntry(
            'business_hours[$i][close_time]',
            closeTimeDecimal,
          ), // "18.00"
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

      AppLoggerHelper.debug('Submitting to: ${ApiConstants.updateVendor}');
      final response = await dio.post(
        ApiConstants.updateVendor,
        data: formData,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        bool isSuccess =
            response.data['success'] == true ||
            response.data['status'] == 'success';

        if (isSuccess) {
          AppLoggerHelper.info('✅ SUCCESS: Succesfully updated vendor profile');
          SnackBarConstant.success('Setup successful!');

          final vendorId = response.data['vendor']['id'];

          StorageService.saveVendorId(vendorId);

          AppLoggerHelper.info('The toal id is: $vendorId');

          // নেভিগেশনের আগে সামান্য ডিলে (Delay) দিলে লগটি দেখার সুযোগ থাকে
          await Future.delayed(const Duration(milliseconds: 500));
          Get.offAllNamed(AppRoute.vendorBottomNavBar);
        } else {
          AppLoggerHelper.error(
            '❌ FAILED: Server returned success false',
            response.data.toString(),
          );
          SnackBarConstant.error(
            response.data['message'] ?? 'Failed to update',
          );
        }
      } else {
        SnackBarConstant.error('Server error: ${response.statusCode}');
      }
    } on DioException catch (e) {
      AppLoggerHelper.error(
        'Submission Error',
        e.response?.data.toString() ?? e.message!,
      );
      SnackBarConstant.error('Check all fields and try again.');
    } finally {
      isSubmitLoading.value = false;
    }
  }
}
