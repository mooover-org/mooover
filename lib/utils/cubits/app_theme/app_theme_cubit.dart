import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mooover/config/themes/themes.dart';
import 'package:mooover/utils/cubits/app_theme/app_theme_states.dart';
import 'package:mooover/utils/domain/initializable.dart';
import 'package:mooover/utils/domain/user.dart';
import 'package:mooover/utils/services/user_services.dart';
import 'package:mooover/utils/services/user_session_services.dart';

class AppThemeCubit extends Cubit<AppThemeState> implements Initializable {
  AppThemeCubit(
      {AppThemeState initialState = const AppThemeLoadedState(AppTheme.light)})
      : super(initialState);

  @override
  Future<void> initialize() async {
    await loadAppTheme();
  }

  @override
  Future<void> dispose() async {
    await removeAppTheme();
  }

  /// This method is used to load the app theme.
  Future<void> loadAppTheme() async {
    emit(const AppThemeLoadingState());
    try {
      User user = await UserServices().getUser(UserSessionServices().getUserId());
      emit(AppThemeLoadedState(user.appTheme));
      log('App theme loaded');
    } catch (e) {
      emit(AppThemeErrorState(e.toString()));
    }
  }

  /// This method is used to remove the app theme.
  Future<void> removeAppTheme() async {
    emit(const AppThemeLoadingState());
    try {
      emit(const AppThemeLoadedState(AppTheme.light));
      log('App theme removed');
    } catch (e) {
      emit(AppThemeErrorState(e.toString()));
    }
  }

  /// This method is used to change the app theme.
  Future<void> changeAppTheme(AppTheme newAppTheme) async {
    emit(const AppThemeLoadingState());
    try {
      User user = await UserServices().getUser(UserSessionServices().getUserId());
      user.appTheme = newAppTheme;
      await UserServices().updateUser(user);
      emit(AppThemeLoadedState(newAppTheme));
      log('App theme changed for user ${user.id}');
    } catch (e) {
      emit(AppThemeErrorState(e.toString()));
    }
  }
}
