import 'package:flutter/material.dart';

/// Available app themes names
enum AppThemeName {
  light,
  dark,
}

/// Available app themes
final appThemes = {
  AppThemeName.light: ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.deepPurpleAccent,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.deepPurpleAccent
    ),
  ),
  AppThemeName.dark: ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.deepPurple,
    appBarTheme: const AppBarTheme(
        backgroundColor: Colors.deepPurple
    ),
  ),
};