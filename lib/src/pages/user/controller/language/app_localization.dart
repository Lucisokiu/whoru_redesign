import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class AppLocalization  {
  final Locale locale;

  AppLocalization(this.locale);

  static AppLocalization of(BuildContext context) {
    return Localizations.of(context, AppLocalization);
  }

  late Map<String, String> _localizedValues;

  Future loadJson(Locale locale) async {
    String jsonStringValues = await rootBundle.loadString(
        'assets/translations/${locale.languageCode}_${locale.countryCode}.json');

    Map<String, dynamic> mappedJson = json.decode(jsonStringValues);

    _localizedValues =
        mappedJson.map((key, value) => MapEntry(key, value.toString()));
  }

  String getTranslatedValues(String key) {
    return _localizedValues[key]!;
  }

  static const LocalizationsDelegate<AppLocalization> delegate =
      _AppLocalizationDelegate();
}

class _AppLocalizationDelegate extends LocalizationsDelegate<AppLocalization> {

  const _AppLocalizationDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en_US', 'vi_VN']
        .contains('${locale.languageCode}_${locale.countryCode}');
  }

  @override
  Future<AppLocalization> load(Locale locale) async {
    AppLocalization localization = AppLocalization(locale);
    await localization.loadJson(locale);
    return localization;
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalization> old) {
    return false;
  }
}
