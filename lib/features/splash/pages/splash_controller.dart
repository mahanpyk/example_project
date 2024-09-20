import 'package:get/get.dart';

class SplashController extends GetxController {
  SplashController();

  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 3), () => Get.offNamed(AppRoutes.LOGIN));
  }
}
