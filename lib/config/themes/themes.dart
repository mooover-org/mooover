import 'package:flutter/material.dart';

/// Converts a theme name to an app theme
AppTheme stringToAppTheme(String themeName) {
  switch (themeName) {
    case 'dark':
      return AppTheme.dark;
    case 'light':
      return AppTheme.light;
    default:
      return AppTheme.light;
  }
}

/// Converts an app theme to a theme name
String appThemeToString(AppTheme appTheme) {
  switch (appTheme) {
    case AppTheme.dark:
      return 'dark';
    case AppTheme.light:
      return 'light';
    default:
      return 'light';
  }
}

/// Available app themes names
enum AppTheme {
  light,
  dark,
}

/// Available app themes
final appThemes = {
  AppTheme.light: ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.deepPurpleAccent,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.deepPurpleAccent
    ),
  ),
  AppTheme.dark: ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.deepPurple,
    appBarTheme: const AppBarTheme(
        backgroundColor: Colors.deepPurple
    ),
  ),
};