import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mooover/config/themes/themes.dart';
import 'package:mooover/utils/helpers/app_config.dart';

/// The app settings state.
///
/// It holds the currently applied app settings.
@immutable
abstract class AppSettingsState extends Equatable {
  const AppSettingsState();

  @override
  List<Object?> get props => [];
}

/// The initial app settings state.
@immutable
class AppSettingsInitialState extends AppSettingsLoadedState {
  const AppSettingsInitialState(): super(AppTheme.light);
}

/// The app settings loading state.
@immutable
class AppSettingsLoadingState extends AppSettingsState {
  const AppSettingsLoadingState(): super();

  @override
  List<Object?> get props => [];
}

/// The app settings loaded state.
@immutable
class AppSettingsLoadedState extends AppSettingsState {
  final AppTheme appTheme;

  const AppSettingsLoadedState(this.appTheme) : super();

  @override
  List<Object?> get props => [appTheme];
}

/// The app settings error state.
@immutable
class AppSettingsErrorState extends AppSettingsState {
  final String errorMessage;

  const AppSettingsErrorState(this.errorMessage) : super();

  @override
  List<Object?> get props => [errorMessage];
}