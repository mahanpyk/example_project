import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppBottomSheet {
  static void bottomSheet({
    required VoidCallback onTapSave,
    required String title,
  }) {
    Get.bottomSheet(
      BottomSheetWidget(onTapSave: onTapSave, title: title),
      isDismissible: false,
    );
  }
}
