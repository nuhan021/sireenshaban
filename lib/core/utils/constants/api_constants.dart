class ApiConstants {
  ApiConstants._();

  static const String baseUrl = "https://arytenoepiglottic-gravely-noriko.ngrok-free.dev/api/v1";
  static const String login = "$baseUrl/login";
  static const String register = "$baseUrl/register";
  static const String verifyOtp = "$baseUrl/verify-otp";
  static const String resendOtp = "$baseUrl/resend-otp";
  static const String updateVendor = "$baseUrl/vendors";
  static const String categories = "$baseUrl/categories";
  static const String selectCategory = "$baseUrl/categories/complete-onboarding";
  static const String dealsAndPromotions = "$baseUrl/packages";
  static const String trendingNearby = "$baseUrl/trending-nearby";
  static const String communityEvents = "$baseUrl/events";
  static const String bookings = "$baseUrl/bookings";
  static const String serviceRequest = "$baseUrl/serviceRequest";
  static const String profile = "$baseUrl/profile";
}
