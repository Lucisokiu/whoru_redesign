part of 'get_theme.dart';

abstract class ThemeState {}

// This is the state of initial app
class ThemeInitial extends ThemeState {}
// We will controll the theme of the app
class ThemeChanged extends ThemeState {}