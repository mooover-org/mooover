import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mooover/config/themes/theme_state.dart';

/// The theme [Cubit].
///
/// It manages the [ThemeState] changes.
class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(InitialThemeState());

  /// Changes the [ThemeState] to the newly picked theme.
  void changeTheme(ThemeData newThemeData) {
    emit(LoadedThemeState(newThemeData));
  }
}