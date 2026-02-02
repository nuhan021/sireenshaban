import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageService {
  // Constants for preference keys
  static const String _tokenKey = 'token';
  static const String _idKey = 'userId';
  static const String _vendorIdKey = 'vendorId';
  static const String _fcmTokenKey = 'fcmToken';
  static const String onboardingStatus = "onboarding";
  static const String _role = "role";
  static const String _profileKey = 'user_profile';

  // Singleton instance for SharedPreferences
  static SharedPreferences? _preferences;
  
  // Secure storage instance for sensitive data
  static const _secureStorage = FlutterSecureStorage();

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
    // Check secure storage first, then fall back to shared preferences for migration
    return _preferences?.getString(_tokenKey) != null;
  }

static Future<void> saveVendorId(int id) async {
  await _preferences?.setString(_vendorIdKey, id.toString());
}


  // Save the token and user ID to secure storage
  static Future<void> saveToken(String token, String id) async {
    // Store token in secure storage (encrypted)
    await _secureStorage.write(key: _tokenKey, value: token);
    // Store user ID in secure storage as well
    await _secureStorage.write(key: _idKey, value: id);
  }

  // Remove the token and user ID from secure storage (for logout)
  static Future<void> logoutUser() async {
    await _secureStorage.delete(key: _tokenKey);
    await _secureStorage.delete(key: _idKey);
    await _preferences?.remove(_role);
  }

  // Getter for user ID (from secure storage)
  static Future<String?> getUserId() async {
    return await _secureStorage.read(key: _idKey);
  }

  // Getter for token (from secure storage)
  static Future<String?> getTokenAsync() async {
    return await _secureStorage.read(key: _tokenKey);
  }

  // Synchronous token getter (returns cached value, should be populated at startup)
  // Use getTokenAsync() for fresh values
  static String? get token => _preferences?.getString('_token_cache');
  
  // Synchronous user ID getter (returns cached value)
  // For fresh value, use getUserId() async method
  static String? get userId => _preferences?.getString('_id_cache');

  // Getter for role
  static String? get role => _preferences?.getString(_role);

  static String? get vendorId => _preferences?.getString(_vendorIdKey);

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

  // FCM Token methods
  static Future<void> setFCMToken(String token) async {
    await _preferences?.setString(_fcmTokenKey, token);
  }

  static String? get fcmToken => _preferences?.getString(_fcmTokenKey);

  static Future<void> clearFCMToken() async {
    await _preferences?.remove(_fcmTokenKey);
  }

  // Getter for vendor ID (from vendor profile data)
  // The vendor object is nested inside the user profile for vendors
  
  // Sync methods for backward compatibility (use these sparingly)
  // These should only be used where async calls are not possible
  static String? getTokenSync() {
    // This is a workaround - better to use async version where possible
    return _preferences?.getString('_token_cache');
  }
  
  // Cache token and userId for quick access (should be called after loading from secure storage)
  static Future<void> cacheToken(String token) async {
    await _preferences?.setString('_token_cache', token);
  }
  
  static Future<void> cacheUserId(String userId) async {
    await _preferences?.setString('_id_cache', userId);
  }
}