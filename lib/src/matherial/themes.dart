import 'package:flutter/material.dart';
import 'package:whoru/src/matherial/app_color.dart';

class AppTheme {
  AppTheme({
    required this.mode,
    required this.data,
    required this.appColors,
  });

  final ThemeMode mode;
  final ThemeData data;
  final AppColors appColors;

  factory AppTheme.light() {
    const mode = ThemeMode.light;
    final appColors = AppColors.light();
    final themeData = ThemeData.light().copyWith(
      useMaterial3: true,
      primaryColor: appColors.primary,
      scaffoldBackgroundColor: appColors.background,
      snackBarTheme: SnackBarThemeData(
        backgroundColor: appColors.error,
        behavior: SnackBarBehavior.floating,
      ),
      dividerColor: appColors.divider,
      cardTheme: CardTheme(
        color: appColors.background,
      ),
      shadowColor: appColors.shadow,
      colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.grey.shade200,
          background: Colors.grey.shade200,
          primary: appColors.background2),
      buttonTheme: const ButtonThemeData().copyWith(
        colorScheme: const ColorScheme.light().copyWith(
          primary: appColors.button,
        ),
      ),
      iconTheme: const IconThemeData().copyWith(color: appColors.icon),
      textTheme: TextTheme(
        bodyMedium: TextStyle(
          color: appColors.text,
        ),
      ),
      listTileTheme: const ListTileThemeData(
        iconColor: Colors.red,
      ),
    );
    return AppTheme(
      mode: mode,
      data: themeData,
      appColors: appColors,
    );
  }

  factory AppTheme.dark() {
    const mode = ThemeMode.dark;
    final appColors = AppColors.dark();
    final themeData = ThemeData.dark().copyWith(
      useMaterial3: true,
      primaryColor: appColors.primary,
      scaffoldBackgroundColor: appColors.background,
      snackBarTheme: SnackBarThemeData(
        backgroundColor: appColors.error,
        behavior: SnackBarBehavior.floating,
      ),
      dividerColor: appColors.divider,
      cardTheme: CardTheme(
        color: appColors.background,
      ),
      colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.black,
          brightness: Brightness.dark,
          background: Colors.black,
          primary: appColors.background2),
      buttonTheme: const ButtonThemeData().copyWith(
        colorScheme: const ColorScheme.light().copyWith(
          primary: appColors.button,
        ),
      ),
      iconTheme: const IconThemeData().copyWith(color: appColors.icon),
      shadowColor: appColors.shadow,
      textTheme: TextTheme(
        bodyMedium: TextStyle(
          color: appColors.text,
        ),
      ),
      listTileTheme: const ListTileThemeData(
        iconColor: Colors.red,
      ),
    );
    return AppTheme(
      mode: mode,
      data: themeData,
      appColors: appColors,
    );
  }
}
