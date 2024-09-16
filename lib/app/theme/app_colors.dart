import 'package:flutter/material.dart';

class AppColors {
  static const gray = {
    25: Color(0xfffcfcfd),
    50: Color(0xfff9fafb),
    100: Color(0xfff2f4f7),
    200: Color(0xffeaecf0),
    300: Color(0xffd0d5dd),
    400: Color(0xff98a2b3),
    500: Color(0xff667085),
    700: Color(0xff344054),
    600: Color(0xff475467),
    800: Color(0xff1d2939),
    900: Color(0xff101828),
  };
  static final LinearGradient kLinearGradientBlue = const LinearGradient(
    colors: <Color>[
      Color(0xffd0fcff),
      Color(0xff00f0ff),
    ],
  ).scale(1);
  static const shadowColor = Color(0x26000000);
  static const secondaryColor = Color(0xff554ce1);
  static const primary = Color(0xfff24187);
  static const restSelectedColor = Color(0xffF4619B);
  static const purple = Color(0xff9ea0ef);
}
