import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'language/en-US.dart';
import 'language/vi-VN.dart';

class LocalizationService extends Translations {
  static final Future<SharedPreferences> _prefs =
      SharedPreferences.getInstance();
  static Locale? locale;
  static Locale? fallbackLocale = _getLocaleFromLanguage();

  static final langCodes = [
    'en',
    'vi',
  ];
  static final locales = [
    Locale('en', 'US'),
    Locale('vi', 'VN'),
  ];
  static final langs = LinkedHashMap.from({
    'en': 'English',
    'vi': 'Tiếng Việt',
  });

  static Future<void> changeLocale(String langCode) async {
    SharedPreferences pref = await _prefs;
    (pref.setString('langCodes', langCode));
    locale = _getLocaleFromLanguage(langCode: langCode);
    Get.updateLocale(locale!);
  }

  static Future<void> getLocale() async {
    SharedPreferences pref = await _prefs;
    String? langcode = (pref.getString('langCodes'));
    locale = _getLocaleFromLanguage(langCode: langcode);
    Get.updateLocale(locale!);
  }

  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': en,
        'vi_VN': vi,
      };

  static Locale _getLocaleFromLanguage({String? langCode}) {
    var lang = langCode ?? Get.deviceLocale!.languageCode;
    for (int i = 0; i < langCodes.length; i++) {
      if (lang == langCodes[i]) return locales[i];
    }
    return Get.locale!;
  }
}
