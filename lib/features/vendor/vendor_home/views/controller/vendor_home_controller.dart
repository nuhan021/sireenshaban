import 'package:get/get.dart';

import '../../../../../core/services/network_caller.dart';
import '../../../../../core/services/storage_service.dart';
import '../../../../../core/utils/constants/api_constants.dart';
import '../../../../../core/utils/constants/snackbar_constant.dart';
import '../../../../customer/home/model/packages_model.dart';

class VendorHomeController extends GetxController {
  final NetworkCaller _networkCaller = NetworkCaller();
  RxBool isVendorHomePackageLoading = false.obs;
  RxBool isVendorHomePackageError = false.obs;
  Rx<PackagesModel?> packages = Rx<PackagesModel?>(null);

  // fetch deals and promotions
  Future<void> getDealsAndPromotions() async {
    isVendorHomePackageLoading.value = true;
    final token = StorageService.token;

    final response = await _networkCaller.getRequest(
      ApiConstants.dealsAndPromotions,
      token: "Bearer $token",
    );

    if (!response.isSuccess) {
      SnackBarConstant.error(response.errorMessage);
      isVendorHomePackageLoading.value = false;
      isVendorHomePackageError.value = true;
      return;
    }

    packages.value = PackagesModel.fromJson(response.responseData);
    isVendorHomePackageLoading.value = false;
    isVendorHomePackageError.value = false;
    SnackBarConstant.success("Deals & Promotions fetched successfully");
  }
}
