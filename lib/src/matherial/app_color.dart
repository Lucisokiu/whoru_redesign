import 'package:flutter/material.dart';

var colorBlack = const Color(0xFF121212);
var colorPrimaryBlack = const Color(0xFF14171A);
var colorDarkGrey = const Color(0xFF657786);
var colorPrimary = const Color(0xFF1DA1F2);
var colorTitle = const Color(0xFF2C3D50);

var colorHigh = Colors.redAccent;
var colorMedium = Colors.amber.shade700;
var colorLow = colorPrimary;
var colorCompleted = Colors.green;
var colorFailed = colorDarkGrey;
var colorActive = const Color(0xFF00D72F);

Color mC = Colors.grey.shade100;
Color mCL = Colors.white;
Color mCM = Colors.grey.shade200;
Color mCH = Colors.grey.shade400;
Color mCD = Colors.black.withOpacity(0.075);
Color mCC = Colors.green.withOpacity(0.65);
Color fCD = Colors.grey.shade700;
Color fCL = Colors.grey;

class AppColors {
  final Color primary;
  final Color background;
  final Color accent;
  final Color disabled;
  final Color error;
  final Color divider;
  final Color header;
  final Color button;
  final Color contentText1;
  final Color contentText2;
  final Color shadow;
  final Color text;
  final Color icon;
  final Color background2;

  const AppColors({
    required this.header,
    required this.primary,
    required this.background,
    required this.accent,
    required this.disabled,
    required this.error,
    required this.divider,
    required this.button,
    required this.contentText1,
    required this.contentText2,
    required this.shadow,
    required this.text,
    required this.icon,
    required this.background2,
  });

  factory AppColors.light() {
    return AppColors(
        header: colorBlack,
        primary: mCM,
        background: mCM,
        accent: const Color(0xFF17c063),
        disabled: Colors.black12,
        error: const Color(0xFFFF7466),
        divider: Colors.black26,
        button: const Color(0xFF657786),
        contentText1: colorBlack,
        contentText2: colorPrimaryBlack,
        shadow: Colors.black38,
        text: colorBlack,
        icon: colorBlack,
        background2: const Color(0xFFd3d3d3),);
  }

  factory AppColors.dark() {
    return AppColors(
        header: Colors.white,
        primary: Colors.grey.shade200,
        background: const Color(0xFF14171A),
        accent: const Color(0xFF17c063),
        disabled: Colors.white12,
        error: const Color(0xFFFF5544),
        divider: Colors.white24,
        button: Colors.white24,
        contentText1: mCL,
        contentText2: mCL,
        shadow: Colors.white38,
        text: mC,
        icon: mCM,
        background2: const Color.fromARGB(255, 108, 109, 110),
        );
  }
}
