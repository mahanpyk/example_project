import 'dart:ui';

import 'package:get/get.dart';

class AppLocalization extends Translations {
  // Load the language when the app starts
  AppLocalization() {
    locale = _getLocaleFromLanguage(LocalizeStoreService.to.languages);
  }

  static Locale? locale;
  static const fallbackLocale = Locale('en', 'US');
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

  void changeLocale(LanguageEnum lang) async {
    final locale = _getLocaleFromLanguage(lang);
    await LocalizeStoreService.to
        .saveLanguages(language: lang); // save the selected language
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
