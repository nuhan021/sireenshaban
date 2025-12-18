import 'package:device_preview/device_preview.dart';
import 'package:sireenshaban/core/services/storage_service.dart';
import 'package:sireenshaban/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'core/bindings/controller_binder.dart';
import 'core/utils/theme/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //Set the fit size (Find your UI design, look at the dimensions of the device screen and fill it in,unit in dp)
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      // Use builder only if you need to use library outside ScreenUtilInit context
      builder: (_, child) {
        String getInitialRoute() {
          final isOnboarded = StorageService.getOnboardingStatus(
            tokenName: StorageService.onboardingStatus,
          );

          if (!isOnboarded) {
            return AppRoute.onboardingScreen;
          }

          if (!StorageService.hasToken()) {
            return AppRoute.selectRoleScreen;
          }

          final role = StorageService.role;

          if (role == 'Vendor') {
            return AppRoute.vendorBottomNavBar;
          }

          if (role == 'Customer') {
            return AppRoute.customerBottomNavBar;
          }

          // fallback (corrupted or missing role)
          return AppRoute.selectRoleScreen;
        }

        return GetMaterialApp(
          useInheritedMediaQuery: true,
          locale: DevicePreview.locale(context),
          builder: DevicePreview.appBuilder,
          debugShowCheckedModeBanner: false,
          initialRoute: getInitialRoute(),
          getPages: AppRoute.routes,
          initialBinding: ControllerBinder(),
          themeMode: ThemeMode.light,
          theme: AppTheme.lightTheme,
        );
      },
    );
  }
}
