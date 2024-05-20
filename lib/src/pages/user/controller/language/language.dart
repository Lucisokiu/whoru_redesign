import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';




class LocalizationService {
  static final Future<SharedPreferences> _prefs =
      SharedPreferences.getInstance();
  static Locale? locale;
  static Locale? fallbackLocale = _getLocaleFromLanguage();
  static final langCodes = [
    'en',
    'vi',
  ];
  static final locales = [
    const Locale('en', 'US'),
    const Locale('vi', 'VN'),
  ];
  static final langs = LinkedHashMap.from({
    'en': 'English',
    'vi': 'Tiếng Việt',
  });

  static Future<void> changeLocale(String langCode) async {
    SharedPreferences pref = await _prefs;
    (pref.setString('langCodes', langCode));
    locale = _getLocaleFromLanguage(langCode: langCode);
    print(locale);
  }

  static Future<void> getLocale() async {
    SharedPreferences pref = await _prefs;
    String? langcode = (pref.getString('langCodes'));
    locale = _getLocaleFromLanguage(langCode: langcode);
  }

  static Locale _getLocaleFromLanguage({String? langCode}) {
    var lang = langCode;
    for (int i = 0; i < langCodes.length; i++) {
      if (lang == langCodes[i]) return locales[i];
    }
    return locales[0];
  }
}
