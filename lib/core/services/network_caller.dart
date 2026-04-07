import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
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

  // DELETE method
  Future<ResponseData> deleteRequest(String url, {String? token}) async {
    try {
      final Response response = await client
          .delete(
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

  // Handle response
  ResponseData _handleResponse(Response response) {
    debugPrint("HTTP STATUS: ${response.statusCode}");
    
    dynamic decodedResponse;
    try {
      decodedResponse = jsonDecode(response.body);
    } catch (e) {
      debugPrint("RAW ERROR RESPONSE (Not JSON): ${response.body}");
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
        debugPrint("API ERROR RESPONSE: $decodedResponse");
        return ResponseData(
          isSuccess: false,
          statusCode: response.statusCode,
          responseData: decodedResponse,
          errorMessage: _extractErrorMessages(decodedResponse),
        );
      }
    } else {
      debugPrint("RAW ERROR RESPONSE: ${response.body}");
      return ResponseData(
        isSuccess: false,
        statusCode: response.statusCode,
        responseData: decodedResponse,
        errorMessage: _extractErrorMessages(decodedResponse),
      );
    }
  }

  // Extract error messages from various formats
  String _extractErrorMessages(dynamic responseData) {
    if (responseData == null) return 'An unknown error occurred';

    // 1. Check for 'errors' map (Common in Laravel/Rails)
    if (responseData['errors'] != null && responseData['errors'] is Map) {
      List<String> messages = [];
      (responseData['errors'] as Map).forEach((key, value) {
        if (value is List) {
          messages.add(value.join(' '));
        } else {
          messages.add(value.toString());
        }
      });
      if (messages.isNotEmpty) return messages.join('\n');
    }

    // 2. Check for 'message' field
    if (responseData['message'] != null) {
      return responseData['message'].toString();
    }

    // 3. Check for 'errorSources' (Old logic)
    if (responseData['errorSources'] != null && responseData['errorSources'] is List) {
      return (responseData['errorSources'] as List)
          .map((error) => error['message'] ?? 'Unknown error')
          .join(', ');
    }

    // 4. Check for 'error' field
    if (responseData['error'] != null) {
      return responseData['error'].toString();
    }

    return 'An unknown error occurred';
  }

  // Handle errors
  ResponseData _handleError(dynamic error) {
    debugPrint("NETWORK CALLER ERROR: $error");
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
