import 'package:sireenshaban/core/models/response_data.dart';
import 'package:sireenshaban/core/services/network_caller.dart';
import 'package:sireenshaban/core/utils/constants/api_constants.dart';

class ProfileServices {
  final NetworkCaller _networkCaller = NetworkCaller();

  Future<ResponseData> getProfile({required String token}) {
    return _networkCaller.getRequest(ApiConstants.profile, token: token);
  }
}
