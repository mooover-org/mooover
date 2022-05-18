import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mooover/config/themes/themes.dart';

/// The base state of the [AppThemeCubit]
@immutable
abstract class AppThemeState extends Equatable {
  const AppThemeState();

  @override
  List<Object> get props => [];
}

/// The loading state of the [AppThemeCubit]
@immutable
class AppThemeLoadingState extends AppThemeState {
  const AppThemeLoadingState();

  @override
  List<Object> get props => [];
}

/// The loaded state of the [AppThemeCubit]
@immutable
class AppThemeLoadedState extends AppThemeState {
  final AppTheme appTheme;

  const AppThemeLoadedState(this.appTheme);

  @override
  List<Object> get props => [appTheme];
}

/// The error state of the [AppThemeCubit]
@immutable
class AppThemeErrorState extends AppThemeState {
  final String message;

  const AppThemeErrorState(this.message);

  @override
  List<Object> get props => [message];
}
