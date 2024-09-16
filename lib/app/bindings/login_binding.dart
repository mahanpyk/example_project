import 'package:get/get.dart';

class LoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginRepository>(() => LoginRepositoryImpl());
    Get.lazyPut<LoginController>(
        () => LoginController(Get.find<LoginRepository>()));
  }
}
