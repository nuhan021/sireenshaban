import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';

import '../models/response_data.dart';

class NetworkCaller {
  final Client client;
  final int timeoutDuration;

  NetworkCaller({Client? client, int? timeoutDuration})
    : client = client ?? Client(),
      timeoutDuration = timeoutDuration ?? 20;

  // GET method
  Future<ResponseData> getRequest(String url, {String? token}) async {
    try {
      final Response response = await client
          .get(
            Uri.parse(url),
            headers: {
              'Authorization': 'Bearer ${token ?? ''}',
              'Content-type': 'application/json',
              'Accept': 'application/json',
            },
          )
          .timeout(Duration(seconds: timeoutDuration));

      return _handleResponse(response);
    } catch (e) {
      return _handleError(e);
    }
  }

  // POST method
  Future<ResponseData> postRequest(
    String url, {
    Map<String, dynamic>? body,
    String? token,
    Map<String, String>? headers,
  }) async {
    try {
      Map<String, String> finalHeaders;
      if (headers == null) {
        finalHeaders = {
          'Authorization': 'Bearer ${token ?? ''}',
          'Content-type': 'application/json',
          'Accept': 'application/json',
        };
      } else {
        finalHeaders = Map<String, String>.from(headers);
        if (!finalHeaders.containsKey('Authorization')) {
          finalHeaders['Authorization'] = 'Bearer ${token ?? ''}';
        }
      }

      final Response response = await client
          .post(Uri.parse(url), headers: finalHeaders, body: jsonEncode(body))
          .timeout(Duration(seconds: timeoutDuration));
      return _handleResponse(response);
    } catch (e) {
      return _handleError(e);
    }
  }

  // Handle response
  ResponseData _handleResponse(Response response) {
    dynamic decodedResponse;
    try {
      decodedResponse = jsonDecode(response.body);
    } catch (e) {
      return ResponseData(
        isSuccess: false,
        statusCode: response.statusCode,
        responseData: response.body,
        errorMessage: 'Failed to parse server response',
      );
    }

    if (response.statusCode == 200 || response.statusCode == 201) {
      if (decodedResponse['success'] == true) {
        return ResponseData(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: decodedResponse,
          errorMessage: '',
        );
      } else {
        return ResponseData(
          isSuccess: false,
          statusCode: response.statusCode,
          responseData: decodedResponse,
          errorMessage: decodedResponse['message'] ?? 'Unknown error occurred',
        );
      }
    } else if (response.statusCode == 400) {
      return ResponseData(
        isSuccess: false,
        statusCode: response.statusCode,
        responseData: decodedResponse,
        errorMessage: _extractErrorMessages(decodedResponse['errorSources']),
      );
    } else if (response.statusCode == 500) {
      return ResponseData(
        isSuccess: false,
        statusCode: response.statusCode,
        responseData: '',
        errorMessage:
            decodedResponse['message'] ?? 'An unexpected error occurred!',
      );
    } else {
      return ResponseData(
        isSuccess: false,
        statusCode: response.statusCode,
        responseData: decodedResponse,
        errorMessage: decodedResponse['message'] ?? 'An unknown error occurred',
      );
    }
  }

  // Extract error messages for status 400
  String _extractErrorMessages(dynamic errorSources) {
    if (errorSources is List) {
      return errorSources
          .map((error) => error['message'] ?? 'Unknown error')
          .join(', ');
    }
    return 'Validation error';
  }

  // Handle errors
  ResponseData _handleError(dynamic error) {
    if (error is ClientException) {
      return ResponseData(
        isSuccess: false,
        statusCode: 500,
        responseData: '',
        errorMessage: 'Network error occurred. Please check your connection.',
      );
    } else if (error is TimeoutException) {
      return ResponseData(
        isSuccess: false,
        statusCode: 408,
        responseData: '',
        errorMessage: 'Request timeout. Please try again later.',
      );
    } else {
      return ResponseData(
        isSuccess: false,
        statusCode: 500,
        responseData: '',
        errorMessage: 'Unexpected error occurred.',
      );
    }
  }
}
