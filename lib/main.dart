import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void main() {
  Get.put(ThemeController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    final ThemeController themeController = Get.find();

    return Obx(
      () => GetMaterialApp(
        builder: (context, Widget? child) {
          final MediaQueryData data = MediaQuery.of(context);
          return MediaQuery(
            data: data.copyWith(textScaler: const TextScaler.linear(1)),
            child: child!,
          );
        },
        title: '',
        theme: themeController.currentTheme.value,
        initialBinding: MainBinding(),
        translations: AppLocalization(),
        locale: AppLocalization.locale,
        fallbackLocale: AppLocalization.fallbackLocale,
        getPages: AppPages.pages,
        initialRoute: AppRoutes.SPLASH,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
