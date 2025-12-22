import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  // Constants for preference keys
  static const String _tokenKey = 'token';
  static const String _idKey = 'userId';
  static const String _vendorOdKey = 'vendorId';
  static const String onboardingStatus = "onboarding";
  static const String _role = "role";
  static const String _profileKey = 'user_profile';

  // Singleton instance for SharedPreferences
  static SharedPreferences? _preferences;

  // Initialize SharedPreferences (call this during app startup)
  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static bool getOnboardingStatus({required String tokenName}) {
    return _preferences?.getBool(onboardingStatus) ?? false;
  }

  static Future<void> setOnboardingStatus({required bool value}) async {
    await _preferences?.setBool(onboardingStatus, value);
  }

  static Future<void> saveRole(String role) async {
    await _preferences?.setString(_role, role);
  }

  // Check if a token exists in local storage
  static bool hasToken() {
    final token = _preferences?.getString(_tokenKey);
    return token != null;
  }

  static Future<void> savaVendorId(int id) async {
    await _preferences?.setString(_vendorOdKey, id.toString());
  }

  // Save the token and user ID to local storage
  static Future<void> saveToken(String token, String id) async {
    await _preferences?.setString(_tokenKey, token);
    await _preferences?.setString(_idKey, id);
  }

  // Remove the token and user ID from local storage (for logout)
  static Future<void> logoutUser() async {
    await _preferences?.remove(_tokenKey);
    await _preferences?.remove(_idKey);
    await _preferences?.remove(_role);
    // Navigate to the login screen
    // Get.offAllNamed('/login');
  }

  // Getter for user ID
  static String? get userId => _preferences?.getString(_idKey);

  // Getter for token
  static String? get token => _preferences?.getString(_tokenKey);

  // Getter for role
  static String? get role => _preferences?.getString(_role);

  static String? get vendorId => _preferences?.getString(_vendorOdKey);

  // Save serialized user profile JSON (as returned by /profile API)
  static Future<void> saveUserProfile(Map<String, dynamic> profile) async {
    final json = jsonEncode(profile);
    await _preferences?.setString(_profileKey, json);
  }

  // Get user profile map (or null)
  static Map<String, dynamic>? get userProfile {
    final s = _preferences?.getString(_profileKey);
    if (s == null || s.isEmpty) return null;
    try {
      return jsonDecode(s) as Map<String, dynamic>;
    } catch (_) {
      return null;
    }
  }

  // Convenience getters for common profile fields
  static String? get profileImage => userProfile?['image'] as String?;
  static String? get coverImage => userProfile?['background_image'] as String?;
  static String? get firstName => userProfile?['first_name'] as String?;
  static String? get lastName => userProfile?['last_name'] as String?;
  static String? get email => userProfile?['email'] as String?;
  static String? get city => userProfile?['city'] as String?;
  static String? get address => userProfile?['address'] as String?;
}
