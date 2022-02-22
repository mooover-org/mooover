import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mooover/config/themes/themes.dart';

/// The base theme state
@immutable
abstract class ThemeState extends Equatable {
  final ThemeData? themeData;
  const ThemeState(this.themeData);
}

/// The initial theme state
@immutable
class InitialThemeState extends ThemeState {
  InitialThemeState(): super(appThemes[AppThemeName.light]);

  @override
  List<Object?> get props => [themeData];
}

/// The loaded theme state
@immutable
class LoadedThemeState extends ThemeState {
  const LoadedThemeState(ThemeData themeData): super(themeData);

  @override
  List<Object?> get props => [themeData];
}
