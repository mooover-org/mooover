import 'package:flutter/material.dart';

/// Converts an app theme to a string
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

/// Converts a string to an app theme
AppTheme appThemeFromString(String themeName) {
  switch (themeName) {
    case 'dark':
      return AppTheme.dark;
    case 'light':
      return AppTheme.light;
    default:
      return AppTheme.light;
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
    appBarTheme: const AppBarTheme(backgroundColor: Colors.deepPurpleAccent),
  ),
  AppTheme.dark: ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.deepPurple,
    appBarTheme: const AppBarTheme(backgroundColor: Colors.deepPurple),
  ),
};
