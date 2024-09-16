import 'package:get/get.dart';

class MainBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LocalStorage>(() => StorageService());
    Get.put<LocalizeStoreService>(
      LocalizeStoreService(Get.find<LocalStorage>()),
      permanent: true,
    );
    Get.put<UserStoreService>(
      UserStoreService(Get.find<LocalStorage>()),
      permanent: true,
    );
  }
}
