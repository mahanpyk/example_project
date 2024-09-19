import 'package:flutter/material.dart';

class AppTheme {
  // Theme for light mode
  static ThemeData lightTheme() {
    return ThemeData(
      brightness: Brightness.light,
      useMaterial3: true,
      fontFamily: 'IRANSansWeb',
      primaryColor: AppColors.primary,
      primarySwatch: Colors.green,
      scaffoldBackgroundColor: Colors.white,
      textTheme: AppTextStyles.textTheme,
      appBarTheme: AppBarTheme(
        elevation: 0.0,
        color: AppColors.primary,
      ),
      pageTransitionsTheme: const PageTransitionsTheme(builders: {
        TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
        TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
      }),
    );
  }

  // Theme for dark mode
  static ThemeData darkTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      useMaterial3: true,
      fontFamily: 'IRANSansWeb',
      primaryColor: AppColors.primary,
      primarySwatch: Colors.green,
      scaffoldBackgroundColor: Colors.black,
      textTheme: AppTextStyles.textTheme,
      appBarTheme: AppBarTheme(
        elevation: 0.0,
        color: AppColors.primaryDark,
      ),
      pageTransitionsTheme: const PageTransitionsTheme(builders: {
        TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
        TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
      }),
    );
  }

  // BoxShadow reusable styling
  static BoxShadow getBoxShadow() {
    return const BoxShadow(
      color: AppColors.shadowColor,
      offset: Offset(0, 3),
      blurRadius: 9,
      spreadRadius: 0,
    );
  }
}
