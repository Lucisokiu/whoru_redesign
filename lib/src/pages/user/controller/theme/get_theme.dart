import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'theme_state.dart';

class ThemeController extends Bloc<ThemeState, ThemeMode> {
  bool isDarkMode = false;

  bool get isDark => isDarkMode;

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  ThemeController(super.initialState) {
    onInit();
  }

  void onInit() {
    getDarkMode().then((value) => isDarkMode = value);
  }

  getDarkMode() async {
    SharedPreferences pref = await _prefs;
    isDarkMode = (pref.getBool('isDarkMode') ?? false);
    emit(isDarkMode ? ThemeMode.dark : ThemeMode.light);
    return isDarkMode;
  }

  _saveDarkMode() async {
    SharedPreferences pref = await _prefs;
    pref.setBool('isDarkMode', isDarkMode);
  }

  void toggleDarkMode() {
    print(isDarkMode);
    isDarkMode = !isDarkMode;
    emit(isDarkMode ? ThemeMode.dark : ThemeMode.light);
    _saveDarkMode();
  }
}
