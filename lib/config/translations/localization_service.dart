import 'dart:core';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petsvet_connect/config/translations/es_AR/es_ar_translation.dart';
import 'package:petsvet_connect/shared_prefrences/app_prefrences.dart';
import 'package:petsvet_connect/utils/constants.dart';

import 'en_US/en_us_translation.dart';

class LocalizationService extends Translations {
  // default language
  static Locale defaultLanguage = supportedLanguages[Constants.english]!;

  // supported languages
  static Map<String, Locale> supportedLanguages = {
    Constants.english: const Locale('en', 'US'),
    Constants.spanish: const Locale('es', 'AR'),
  };

  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': enUs,
        'es_AR': esAR,
      };

  /// check if the language is supported
  static isLanguageSupported(String languageCode) => supportedLanguages.keys.contains(languageCode);

  /// update app language by code language for example (en,ar..etc)
  static Future<void> updateLanguage(String languageCode) async {
    // check if the language is supported
    if (!isLanguageSupported(languageCode)) return;

    print("Updated language --> $languageCode");

    // update current language in shared pref
    await AppPreferences.setCurrentLanguage(language: languageCode);
    await Get.updateLocale(supportedLanguages[languageCode]!);
  }
}
