import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ThemeController extends GetxController {
  late bool isDarkMode;

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  @override
  void onInit() async {
    super.onInit();
    await getDarkMode().then((value) => isDarkMode = value);
  }

  getDarkMode() async {
    SharedPreferences pref = await _prefs;
    isDarkMode = (pref.getBool('isDarkMode') ?? false);
    Get.changeThemeMode(isDarkMode ? ThemeMode.dark : ThemeMode.light);
    return isDarkMode;
  }

  _saveDarkMode() async {
    SharedPreferences pref = await _prefs;
    pref.setBool('isDarkMode', isDarkMode);
  }

  void toggleDarkMode() {
    print(isDarkMode);
    isDarkMode = !isDarkMode;
    Get.changeThemeMode(isDarkMode ? ThemeMode.dark : ThemeMode.light);
    _saveDarkMode();
  }
}
