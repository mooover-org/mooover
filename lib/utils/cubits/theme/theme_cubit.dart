import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mooover/utils/cubits/theme/theme_states.dart';

/// The theme [Cubit].
///
/// It manages the [ThemeState] changes.
class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit(initialState) : super(initialState);

  /// Changes the app style theme.
  ///
  /// Changes the [ThemeState] to a new one that uses the picked [ThemeData].
  void changeTheme(ThemeData newThemeData) {
    emit(ThemeState(newThemeData));
  }
}