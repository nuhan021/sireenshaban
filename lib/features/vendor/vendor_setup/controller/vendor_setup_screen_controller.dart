import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sireenshaban/core/utils/constants/colors.dart';
import 'package:sireenshaban/core/utils/logging/logger.dart';

class VendorSetupScreenController extends GetxController {

  final PageController pageController = PageController();

  RxInt currentPageIndex = 0.obs;

  final ImagePicker _picker = ImagePicker();

  final businessCategoryList = [
    'Saloon',
    'Restaurant',
    'Hotel',
    'Motel',
    'Plumber',
    'Electrician'
  ];

  final priceTypeList = [
    'Per KM'
  ];

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
    '30 km'
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
  final TextEditingController travelFeePolicyController = TextEditingController();
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

    Get.snackbar('Success', 'Location added', backgroundColor: AppColors.success.withValues(alpha: 0.1));
  }

  void goNext() {
    if(currentPageIndex.value < 2) {
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
}