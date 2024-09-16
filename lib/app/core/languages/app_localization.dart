import 'dart:ui';

import 'package:get/get.dart';

class AppLocalization extends Translations {
  AppLocalization() {
    // locale = _getLocaleFromLanguage(LocalizeStoreService.to.languages);
  }

  static Locale locale = const Locale('fa', 'IR');
  static const fallbackLocale = Locale('fa', 'IR');
  static final languages = [
    LanguageEnum.ENGLISH,
    LanguageEnum.PERSIAN,
  ];
  static final locales = [
    const Locale('en', 'US'),
    const Locale('fa', 'IR'),
  ];

  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': enUS,
        'fa_IR': faIR,
      };

  void changeLocale(LanguageEnum lang) {
    final locale = _getLocaleFromLanguage(lang);
    Get.updateLocale(locale);
  }

  Locale _getLocaleFromLanguage(LanguageEnum lang) {
    switch (lang) {
      case LanguageEnum.ENGLISH:
        return const Locale('en', 'US');
      case LanguageEnum.PERSIAN:
        return const Locale('fa', 'IR');
      default:
        return const Locale('fa', 'IR');
    }
  }
}
