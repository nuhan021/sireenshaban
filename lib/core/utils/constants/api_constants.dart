class ApiConstants {
  ApiConstants._();

  static const String baseUrl =
      "https://overapprehensive-optatively-meri.ngrok-free.dev/api/v1";
  static const String login = "$baseUrl/login";
  static const String editProfile = "$baseUrl/profile";
  static const String register = "$baseUrl/register";
  static const String verifyOtp = "$baseUrl/verify-otp";
  static const String resendOtp = "$baseUrl/resend-otp";
  static const String updateVendor = "$baseUrl/vendors";
  static const String categories = "$baseUrl/categories";
  static const String selectCategory =
      "$baseUrl/categories/complete-onboarding";
  static const String dealsAndPromotions = "$baseUrl/packages";
  static const String trendingNearby = "$baseUrl/trending-nearby";
  static const String communityEvents = "$baseUrl/events";
  static const String bookings = "$baseUrl/bookings";
  static const String serviceRequest = "$baseUrl/serviceRequest/service-requests";
  static const String serviceRequestDetails = "$baseUrl/serviceRequest";
  static const String bookingsByVendor = "$baseUrl/booking-list-by-vendor";
  static const String profile = "$baseUrl/profile";

  // Chat endpoints
  static const String chatHistory = "$baseUrl/chat";
  static const String sendMessage = "$baseUrl/chat/send";
  static const String markRead = "$baseUrl/chat/mark-read";
  static const String userStatus = "$baseUrl/user";
  static const String chatList = "$baseUrl/chat/history";
  static const String saveFcmToken = "$baseUrl/save-fcm-token";
  static const String pusherAuth = "$baseUrl/pusher/auth";
}
