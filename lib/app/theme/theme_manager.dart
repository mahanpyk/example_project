import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeManager {
  factory ThemeManager() => _instance;

  ThemeManager._internal();

  static final ThemeManager _instance = ThemeManager._internal();

  Rx<ThemeData> currentTheme = AppTheme.lightTheme().obs;

  Future<void> loadTheme() async {
    bool isDarkMode = UserStoreService.to.get(key: AppConstants.THEME_MODE) ?? false;
    if (isDarkMode) {
      currentTheme.value = AppTheme.darkTheme();
      Get.changeTheme(AppTheme.darkTheme());
    } else {
      currentTheme.value = AppTheme.lightTheme();
      Get.changeTheme(AppTheme.lightTheme());
    }
  }

  Future<void> switchTheme() async {
    if (Get.isDarkMode) {
      currentTheme.value = AppTheme.lightTheme();
      Get.changeTheme(AppTheme.lightTheme());
      await UserStoreService.to.save(key: AppConstants.THEME_MODE, value: false);
    } else {
      currentTheme.value = AppTheme.darkTheme();
      Get.changeTheme(AppTheme.darkTheme());
      await UserStoreService.to.save(key: AppConstants.THEME_MODE, value: true);
    }
  }
}
