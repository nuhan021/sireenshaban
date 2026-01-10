import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../../../core/utils/constants/api_constants.dart';
import '../../../../core/services/storage_service.dart';

class VendorEditProfileService {
  VendorEditProfileService._();

  /// Update vendor profile using `http` package and multipart form-data.
  ///
  /// `fields` is a map of text fields to send. `imagePath` and `backgroundImagePath`
  /// are optional file paths to attach.
  static Future<http.Response> editProfile({
    required Map<String, String> fields,
    String? imagePath,
    String? backgroundImagePath,
  }) async {
    final uri = Uri.parse(ApiConstants.editProfile);

    final request = http.MultipartRequest('POST', uri);

    // Add authorization header if token exists
    final token = StorageService.token;
    if (token != null && token.isNotEmpty) {
      request.headers['Authorization'] = 'Bearer $token';
    }

    // Add text fields
    request.fields.addAll(fields);

    // Attach files if provided
    if (imagePath != null && imagePath.isNotEmpty) {
      final file = File(imagePath);
      if (await file.exists()) {
        request.files.add(
          await http.MultipartFile.fromPath('image', file.path),
        );
      }
    }

    if (backgroundImagePath != null && backgroundImagePath.isNotEmpty) {
      final file = File(backgroundImagePath);
      if (await file.exists()) {
        request.files.add(
          await http.MultipartFile.fromPath('background_image', file.path),
        );
      }
    }

    // Send request
    final streamed = await request.send();
    final response = await http.Response.fromStream(streamed);

    log('UpdateProfile status: ${response.statusCode}');
    log('UpdateProfile body: ${response.body}');

    return response;
  }
}
