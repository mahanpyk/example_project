import 'package:get/get.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.SPLASH,
      page: () => const SplashPage(),
    ),
    GetPage(
      name: AppRoutes.LOGIN,
      page: () => const LoginPage(),
      binding: LoginBinding(),
    ),
  ];
}
