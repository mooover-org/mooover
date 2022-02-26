import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mooover/config/themes/themes.dart';

/// The application theme state.
///
/// It holds the currently applied [ThemeData].
@immutable
class ThemeState extends Equatable {
  final ThemeData themeData;
  const ThemeState(this.themeData);

  @override
  List<Object?> get props => [themeData];
}

/// The initial theme state (light theme).
@immutable
class InitialThemeState extends ThemeState {
  InitialThemeState(): super(appThemes[AppThemeName.light]!);
}
