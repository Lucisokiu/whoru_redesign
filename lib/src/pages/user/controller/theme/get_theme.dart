import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'theme_state.dart';

class ThemeController extends Bloc<ThemeState, ThemeMode> {
  static bool isDarkMode = false;

  static bool get isDark => isDarkMode;

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  ThemeController(super.initialState){
    onInit();
  }

  onInit() {
    getDarkMode().then((value) => isDarkMode = value);
    print("isDarkMode: $isDarkMode");
  }

  getDarkMode() async {
    SharedPreferences pref = await _prefs;
    isDarkMode = (pref.getBool('isDarkMode') ?? false);
    return isDarkMode;
  }

  _saveDarkMode() async {
    SharedPreferences pref = await _prefs;
    pref.setBool('isDarkMode', isDarkMode);
  }

  void toggleDarkMode() {
    isDarkMode = !isDarkMode;
    // ignore: invalid_use_of_visible_for_testing_member
    emit(isDarkMode ? ThemeMode.dark : ThemeMode.light);
    _saveDarkMode();
  }
}
