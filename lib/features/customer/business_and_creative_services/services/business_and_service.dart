import 'package:sireenshaban/core/models/response_data.dart';
import 'package:sireenshaban/core/services/network_caller.dart';
import 'package:sireenshaban/core/utils/constants/api_constants.dart';

class BusinessAndService {
  final NetworkCaller _networkCaller = NetworkCaller();

  Future<ResponseData> createServiceRequest({
    required Map<String, dynamic> body,
    required String token,
  }) {
    return _networkCaller.postRequest(
      ApiConstants.serviceRequestDetails,
      body: body,
      token: token,
    );
  }
}
