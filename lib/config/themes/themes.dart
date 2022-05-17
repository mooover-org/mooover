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
    scaffoldBackgroundColor: Colors.grey[100],
    backgroundColor: Colors.grey[100],
    cardTheme: CardTheme(
      color: Colors.white,
      shadowColor: Colors.black,
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 3,
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: Colors.deepPurpleAccent,
      textTheme: ButtonTextTheme.primary,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        primary: Colors.white,
        backgroundColor: Colors.deepPurpleAccent,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        primary: Colors.white,
        backgroundColor: Colors.deepPurpleAccent,
      ),
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: Colors.deepPurpleAccent,
    ),
  ),
  AppTheme.dark: ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.deepPurple,
    appBarTheme: const AppBarTheme(backgroundColor: Colors.deepPurple),
    scaffoldBackgroundColor: Colors.grey[900],
    backgroundColor: Colors.grey[900],
    cardTheme: CardTheme(
      color: Colors.grey[850],
      shadowColor: Colors.black,
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 3,
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: Colors.deepPurple,
      textTheme: ButtonTextTheme.primary,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        primary: Colors.white,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        primary: Colors.white,
      ),
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: Colors.deepPurple,
    ),
  ),
};
