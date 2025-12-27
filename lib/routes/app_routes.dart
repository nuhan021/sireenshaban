import 'package:get/get.dart';
import 'package:sireenshaban/features/customer/notification/views/screens/notification_screen.dart';
import 'package:sireenshaban/features/splash/views/screens/splash_screen.dart';
import 'package:sireenshaban/features/subscription/views/screen/subscription_screen.dart';
import 'package:sireenshaban/features/vendor/vendor_bottom_nav_bar/views/screens/vendor_bottom_nav_bar.dart';
import 'package:sireenshaban/features/vendor/vendor_setup/views/screens/vendor_setup_screen.dart';

import '../features/authentication/views/screens/change_password_screen.dart';
import '../features/authentication/views/screens/forget_password_screen.dart';
import '../features/authentication/views/screens/verification_code_send_success_screen.dart';
import '../features/authentication/views/screens/login_screen.dart';
import '../features/authentication/views/screens/sign_up_screen.dart';
import '../features/customer/chat/views/screens/chat_screen.dart';
import '../features/customer/chat/views/screens/chat_list_screen.dart';
import '../features/customer/customer_bottom_nav_bar/views/screens/customer_bottom_nav_bar.dart';
import '../features/customer/interest/views/screens/customer_interest_screen.dart';
import '../features/customer/vendors/views/screens/vendors_screen.dart';
import '../features/onboarding/views/screens/onboarding_screen_1.dart';
import '../features/select_role/views/screens/select_role_screen.dart';
import '../features/vendor/vendor_profile_info/views/screens/vendor_profile_info_map.dart';

class AppRoute {
  static String loginScreen = "/loginScreen";
  static String signUpScreen = "/signUpScreen";
  static String splashScreen = "/splashScreen";
  static String onboardingScreen = "/onboardingScreen";
  static String selectRoleScreen = "/selectRoleScreen";
  static String customerInterestScreen = "/customerInterestScreen";
  static String verificationCodeSendSuccessScreen = "/verificationCodeSendSuccessScreen";
  static String forgetPasswordScreen = "/forgetPasswordScreen";
  static String changePasswordScreen = "/changePasswordScreen";
  static String vendorsScreen = "/vendorsScreen";
  static String chatListScreen = "/chatListScreen";
  static String chatScreen = "/chatScreen";
  static String notificationScreen = "/notificationScreen";
  static String vendorSetupScreen = "/vendorProfileInfo";
  static String vendorProfileInfoMap = "/vendorProfileInfoMap";
  static String vendorSetupScreen1st = '/vendorSetupProfileScreen1st';
  static String subscriptionScreen = '/subscriptionScreen';

  // customer bottom nav bar
  static String customerBottomNavBar = "/customerBottomNavBar";

  // vendor bottom nav bar
  static String vendorBottomNavBar = "/vendorBottomNavBar";





  static String getLoginScreen() => loginScreen;
  static String getSignUpScreen() => signUpScreen;
  static String getSplashScreen() => splashScreen;
  static String getOnboardingScreen() => onboardingScreen;
  static String getSelectRoleScreen() => selectRoleScreen;
  static String getCustomerInterestScreen() => customerInterestScreen;
  static String getVerificationCodeSendSuccessScreen() => verificationCodeSendSuccessScreen;
  static String getForgetPasswordScreen() => forgetPasswordScreen;
  static String getChangePasswordScreen() => changePasswordScreen;
  static String getVendorsScreen() => vendorsScreen;
  static String getChatListScreen() => chatListScreen;
  static String getChatScreen() => chatScreen;
  static String getNotificationScreen() => notificationScreen;
  static String getVendorProfileInfo() => vendorSetupScreen;
  static String getVendorProfileInfoMap() => vendorProfileInfoMap;
  static String getVendorSetupProfileScreen1st() => vendorSetupScreen1st;
  static String getSubscriptionScreen() => subscriptionScreen;




  // customer bottom nav bar
  static String getCustomerBottomNavBar() => customerBottomNavBar;

  // vendor bottom nav bar
  static String getVendorBottomNavBar() => vendorBottomNavBar;




  static List<GetPage> routes = [
    GetPage(name: loginScreen, page: () => LoginScreen()),
    GetPage(name: signUpScreen, page: () => SignUpScreen()),
    GetPage(name: splashScreen, page: () => const SplashScreen()),
    GetPage(name: onboardingScreen, page: () => const OnboardingScreen1()),
    GetPage(name: selectRoleScreen, page: () => SelectRoleScreen()),
    GetPage(name: customerInterestScreen, page: () => CustomerInterestScreen()),
    GetPage(name: verificationCodeSendSuccessScreen, page: () => VerificationCodeSendSuccessScreen()),
    GetPage(name: forgetPasswordScreen, page: () => ForgetPasswordScreen()),
    GetPage(name: changePasswordScreen, page: () => ChangePasswordScreen()),
    GetPage(name: vendorsScreen, page: () => const VendorsScreen()),
    GetPage(name: chatListScreen, page: () => ChatListScreen()),
    GetPage(
      name: chatScreen,
      page: () {
        final receiverId = Get.arguments?['receiverId'] as int? ?? 0;
        final receiverName = Get.arguments?['receiverName'] as String? ?? 'User';
        final receiverAvatar = Get.arguments?['receiverAvatar'] as String?;
        return ChatScreen(
          receiverId: receiverId,
          receiverName: receiverName,
          receiverAvatar: receiverAvatar,
        );
      },
    ),
    GetPage(name: notificationScreen, page: () => NotificationScreen()),
    GetPage(name: vendorSetupScreen, page: () => VendorSetupScreen()),
    GetPage(name: vendorProfileInfoMap, page: () => VendorProfileInfoMap()),
    GetPage(name: vendorSetupScreen1st, page: () => VendorSetupScreen()),
    GetPage(name: subscriptionScreen, page: () => SubscriptionScreen()),



    // customer bottom nav bar
    GetPage(name: customerBottomNavBar, page: () => CustomerBottomNavBar()),

    // vendor bottom nav bar
    GetPage(name: vendorBottomNavBar, page: () => VendorBottomNavBar()),

  ];
}
