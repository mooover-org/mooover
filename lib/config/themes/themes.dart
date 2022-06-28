import 'package:flutter/material.dart';

const Map<String, Color> _kPalette = {
  'primary': Color(0xff880e4f),
  'primaryLight': Color(0xffbc477b),
  'primaryDark': Color(0xff560027),
  'backgroundLight': Color(0xffeeeeee),
  'backgroundDark': Color(0xff212121),
  'surfaceLight': Color(0xfffafafa),
  'surfaceDark': Color(0xff363636),
  'onPrimary': Color(0xfffafafa),
  'onPrimaryLight': Color(0xfffafafa),
  'onPrimaryDark': Color(0xfffafafa),
  'onBackgroundLight': Color(0xff090909),
  'onBackgroundDark': Color(0xfffafafa),
  'onSurfaceLight': Color(0xff090909),
  'onSurfaceDark': Color(0xfffafafa),
  'shadowLight': Color(0xff000000),
  'shadowDark': Color(0xff000000),
};

const Map<String, EdgeInsets> _kPadding = {
  'small': EdgeInsets.all(5),
  'medium': EdgeInsets.all(10),
  'large': EdgeInsets.all(15),
};

Map<String, BorderRadius> _kRadius = {
  'small': BorderRadius.circular(5),
  'medium': BorderRadius.circular(10),
  'large': BorderRadius.circular(15),
};

const _kElevation = {
  'small': 3.0,
  'medium': 6.0,
  'large': 12.0,
};

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
    primaryColor: _kPalette['primary'],
    accentColor: _kPalette['primaryLight'],
    appBarTheme: AppBarTheme(backgroundColor: _kPalette['primary']),
    scaffoldBackgroundColor: _kPalette['backgroundLight'],
    backgroundColor: _kPalette['backgroundLight'],
    cardTheme: CardTheme(
      color: _kPalette['surfaceLight'],
      shadowColor: _kPalette['shadowLight'],
      margin: _kPadding['medium'],
      shape: RoundedRectangleBorder(
        borderRadius: _kRadius['medium'] as BorderRadiusGeometry,
      ),
      elevation: _kElevation['medium'],
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: _kPalette['primary'],
      textTheme: ButtonTextTheme.primary,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        primary: _kPalette['onSurfaceLight'],
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        primary: _kPalette['onPrimary'],
        backgroundColor: _kPalette['primary'],
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: _kPalette['primary'],
    ),
    iconTheme: IconThemeData(color: _kPalette['onPrimary']),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: _kPalette['primary'],
    ),
    colorScheme: ColorScheme.light(
      primary: _kPalette['primary']!,
      primaryVariant: _kPalette['primaryLight'],
      secondary: _kPalette['primaryDark']!,
      secondaryVariant: _kPalette['primaryDark'],
      surface: _kPalette['surfaceLight']!,
      background: _kPalette['backgroundLight']!,
      error: _kPalette['primaryDark']!,
      onPrimary: _kPalette['onPrimary']!,
      onSecondary: _kPalette['onPrimary']!,
    ),
  ),
  AppTheme.dark: ThemeData(
    brightness: Brightness.dark,
    primaryColor: _kPalette['primaryLight'],
    accentColor: _kPalette['primaryLight'],
    appBarTheme: AppBarTheme(backgroundColor: _kPalette['primaryLight']),
    scaffoldBackgroundColor: _kPalette['backgroundDark'],
    backgroundColor: _kPalette['backgroundDark'],
    cardTheme: CardTheme(
      color: _kPalette['surfaceDark'],
      shadowColor: _kPalette['shadowDark'],
      margin: _kPadding['medium'],
      shape: RoundedRectangleBorder(
        borderRadius: _kRadius['medium'] as BorderRadiusGeometry,
      ),
      elevation: _kElevation['medium'],
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: _kPalette['primaryLight'],
      textTheme: ButtonTextTheme.primary,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        primary: _kPalette['onPrimaryDark'],
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        primary: _kPalette['onPrimaryDark'],
        backgroundColor: _kPalette['primaryLight'],
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: _kPalette['primaryLight'],
    ),
    iconTheme: IconThemeData(color: _kPalette['onPrimaryDark']),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: _kPalette['primaryLight'],
    ),
    colorScheme: ColorScheme.dark(
      primary: _kPalette['primaryLight']!,
      primaryVariant: _kPalette['primaryLight'],
      secondary: _kPalette['primaryLight']!,
      secondaryVariant: _kPalette['primaryLight'],
      surface: _kPalette['surfaceDark']!,
      background: _kPalette['backgroundDark']!,
      error: _kPalette['primaryLight']!,
      onPrimary: _kPalette['onPrimaryDark']!,
      onSecondary: _kPalette['onPrimary']!,
    ),
  ),
};
