import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData themeData() {
    return ThemeData(
      useMaterial3: true,
      pageTransitionsTheme: const PageTransitionsTheme(builders: {
        TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
        TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
      }),
      fontFamily: 'IRANSansWeb',
      appBarTheme: const AppBarTheme(elevation: 0.0),
      primaryColor: AppColors.primary,
      primarySwatch: Colors.green,
      scaffoldBackgroundColor: Colors.black,
      textTheme: AppTextStyles.textTheme,
    );
  }

  static BoxShadow getBoxShadow() {
    return const BoxShadow(
      color: AppColors.shadowColor,
      offset: Offset(0, 3),
      blurRadius: 9,
      spreadRadius: 0,
    );
  }
}

















