import 'package:flutter/material.dart';
import 'package:get/get.dart';

mixin AppUtilsMixin {
  void removeFocus() => FocusManager.instance.primaryFocus!.unfocus();

  void logoutFromApp() {
    UserStoreService.to.deleteAll();
    Get.offAndToNamed(AppRoutes.LOGIN);
  }
}
