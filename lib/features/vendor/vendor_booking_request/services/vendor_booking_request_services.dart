import 'package:sireenshaban/core/models/response_data.dart';
import 'package:sireenshaban/core/services/network_caller.dart';
import 'package:sireenshaban/core/utils/constants/api_constants.dart';

class VendorBookingRequestServices {
  final NetworkCaller _networkCaller = NetworkCaller();

  Future<ResponseData> getServiceRequests({required String token}) {
    return _networkCaller.getRequest(
      ApiConstants.serviceRequest,
      token: token,
    );
  }

  Future<ResponseData> getServiceRequestDetails({
    required String token,
    required int requestId,
  }) {
    return _networkCaller.getRequest(
      
      "${ApiConstants.serviceRequestDetails}/$requestId",
      token: token,
      
    );
  }
}
