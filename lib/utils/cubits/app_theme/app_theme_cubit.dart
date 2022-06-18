import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mooover/config/themes/themes.dart';
import 'package:mooover/utils/cubits/app_theme/app_theme_states.dart';
import 'package:mooover/utils/domain/user.dart';
import 'package:mooover/utils/helpers/logger.dart';
import 'package:mooover/utils/services/user_services.dart';
import 'package:mooover/utils/services/user_session_services.dart';

class AppThemeCubit extends Cubit<AppThemeState> {
  AppThemeCubit(
      {AppThemeState initialState = const AppThemeLoadedState(AppTheme.light)})
      : super(initialState) {
    loadAppTheme();
  }

  /// This method is used to load the app theme.
  Future<void> loadAppTheme() async {
    emit(const AppThemeLoadingState());
    logger.d('App theme state loading');
    try {
      User user =
          await UserServices().getUser(UserSessionServices().getUserId());
      emit(AppThemeLoadedState(user.appTheme));
      logger.d('App theme state loaded: ${user.appTheme}');
    } catch (e) {
      emit(AppThemeErrorState(e.toString()));
      logger.e('App theme state error: $e');
    }
  }

  /// This method is used to remove the app theme.
  Future<void> removeAppTheme() async {
    emit(const AppThemeLoadingState());
    logger.d('App theme state loading');
    try {
      emit(const AppThemeLoadedState(AppTheme.light));
      logger.d('App theme state loaded: ${AppTheme.light}');
    } catch (e) {
      emit(AppThemeErrorState(e.toString()));
      logger.e('App theme state error: $e');
    }
  }

  /// This method is used to change the app theme.
  Future<void> changeAppTheme(AppTheme newAppTheme) async {
    emit(const AppThemeLoadingState());
    logger.d('App theme state loading');
    try {
      User user =
          await UserServices().getUser(UserSessionServices().getUserId());
      user.appTheme = newAppTheme;
      await UserServices().updateUser(user);
      emit(AppThemeLoadedState(newAppTheme));
      logger.d('App theme state changed: $newAppTheme');
    } catch (e) {
      emit(AppThemeErrorState(e.toString()));
      logger.e('App theme state error: $e');
    }
  }
}
