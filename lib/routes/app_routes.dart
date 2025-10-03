import 'package:get/get.dart';
import 'package:sireenshaban/features/splash/views/splash_screen.dart';

import '../features/authentication/views/screens/login_screen.dart';
import '../features/onboarding/views/onboarding_screen.dart';

class AppRoute {
  static String loginScreen = "/loginScreen";
  static String splashScreen = "/splashScreen";
  static String onboardingScreen = "/onboardingScreen";

  static String getLoginScreen() => loginScreen;
  static String getSplashScreen() => splashScreen;
  static String getOnboardingScreen() => onboardingScreen;

  static List<GetPage> routes = [
    GetPage(name: loginScreen, page: () => const LoginScreen()),
    GetPage(name: splashScreen, page: () => const SplashScreen()),
    GetPage(name: onboardingScreen, page: () => const OnboardingScreen()),
  ];
}
