import 'package:get/get.dart';
import 'package:sireenshaban/core/services/network_caller.dart';
import 'package:sireenshaban/core/services/storage_service.dart';
import 'package:sireenshaban/core/utils/constants/api_constants.dart';
import 'package:sireenshaban/core/utils/constants/snackbar_constant.dart';
import 'package:sireenshaban/core/utils/logging/logger.dart';
import 'package:sireenshaban/features/customer/interest/categori_model.dart';

import '../../../../routes/app_routes.dart';

class CustomerInterestController extends GetxController {
  @override
  void onInit() {
    getCategory();
    super.onInit();
  }

  final NetworkCaller _networkCaller = NetworkCaller();
  RxBool isCategoriLoading = false.obs;
  RxBool isSetCategoryLoading = false.obs;
  RxBool isCategoriError = false.obs;
  List<InterestModel> category = [];

  Rx<CategoriModel?> categoriModel = Rx<CategoriModel?>(null);

  RxList<String> selectedCategory = <String>[].obs;

  void addAndRemoveCategory({required String role}) {
    if (selectedCategory.contains(role)) {
      selectedCategory.remove(role);
    } else {
      if (selectedCategory.length < 5) selectedCategory.add(role);
    }
  }

  Future<void> getCategory() async {
    isCategoriLoading.value = true;
    final token = StorageService.token;

    AppLoggerHelper.debug(token!);

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

    category.clear();

    categoriModel.value!.data.forEach((e) {
      category.add(InterestModel(e.id, role: e.name, image: e.image ?? ''));
    });

    isCategoriLoading.value = false;
    SnackBarConstant.success("Category fetched successfully");
  }

  Future<void> setCategory() async {
    if (selectedCategory.isEmpty) {
      SnackBarConstant.warning("Please select at least one category");
      return;
    }

    isSetCategoryLoading.value = true;

    final token = StorageService.token;

    final response = await _networkCaller.postRequest(
      ApiConstants.selectCategory,
      body: {
        "category_ids": category
            .where((e) => selectedCategory.contains(e.role))
            .map((e) => e.id)
            .toList(),
      },
      token: "Bearer $token",
    );

    if (response.statusCode == 401) {
      isSetCategoryLoading.value = false;
      SnackBarConstant.error("Unauthorized");
      return;
    }

    if (!response.isSuccess) {
      isSetCategoryLoading.value = false;
      SnackBarConstant.error(response.errorMessage);
      return;
    }

    isSetCategoryLoading.value = false;
    SnackBarConstant.success("Category updated successfully");
    Get.offAllNamed(AppRoute.customerBottomNavBar);
  }
}

class InterestModel {
  InterestModel(this.id, {required this.role, required this.image});

  final int id;
  final String role;
  final String image;
}
