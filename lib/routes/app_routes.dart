import 'package:get/get.dart';
import 'package:sireenshaban/features/splash/views/screens/splash_screen.dart';

import '../features/authentication/views/screens/change_password_screen.dart';
import '../features/authentication/views/screens/forget_password_screen.dart';
import '../features/authentication/views/screens/verification_code_send_success_screen.dart';
import '../features/authentication/views/screens/login_screen.dart';
import '../features/authentication/views/screens/sign_up_screen.dart';
import '../features/customer/customer_bottom_nav_bar/views/screens/customer_bottom_nav_bar.dart';
import '../features/customer/vendors/views/screens/vendors_screen.dart';
import '../features/onboarding/views/screens/onboarding_screen.dart';
import '../features/select_role/views/screens/select_role_screen.dart';

class AppRoute {
  static String loginScreen = "/loginScreen";
  static String signUpScreen = "/signUpScreen";
  static String splashScreen = "/splashScreen";
  static String onboardingScreen = "/onboardingScreen";
  static String selectRoleScreen = "/selectRoleScreen";
  static String verificationCodeSendSuccessScreen = "/verificationCodeSendSuccessScreen";
  static String forgetPasswordScreen = "/forgetPasswordScreen";
  static String changePasswordScreen = "/changePasswordScreen";
  static String vendorsScreen = "/vendorsScreen";

  // customer bottom nav bar
  static String customerBottomNavBar = "/customerBottomNavBar";




  static String getLoginScreen() => loginScreen;
  static String getSignUpScreen() => signUpScreen;
  static String getSplashScreen() => splashScreen;
  static String getOnboardingScreen() => onboardingScreen;
  static String getSelectRoleScreen() => selectRoleScreen;
  static String getVerificationCodeSendSuccessScreen() => verificationCodeSendSuccessScreen;
  static String getForgetPasswordScreen() => forgetPasswordScreen;
  static String getChangePasswordScreen() => changePasswordScreen;
  static String getVendorsScreen() => vendorsScreen;

  // customer bottom nav bar
  static String getCustomerBottomNavBar() => customerBottomNavBar;




  static List<GetPage> routes = [
    GetPage(name: loginScreen, page: () => LoginScreen()),
    GetPage(name: signUpScreen, page: () => SignUpScreen()),
    GetPage(name: splashScreen, page: () => const SplashScreen()),
    GetPage(name: onboardingScreen, page: () => const OnboardingScreen()),
    GetPage(name: selectRoleScreen, page: () => SelectRoleScreen()),
    GetPage(name: verificationCodeSendSuccessScreen, page: () => VerificationCodeSendSuccessScreen()),
    GetPage(name: forgetPasswordScreen, page: () => ForgetPasswordScreen()),
    GetPage(name: changePasswordScreen, page: () => ChangePasswordScreen()),
    GetPage(name: vendorsScreen, page: () => VendorsScreen()),

    // customer bottom nav bar
    GetPage(name: customerBottomNavBar, page: () => CustomerBottomNavBar()),
  ];
}
