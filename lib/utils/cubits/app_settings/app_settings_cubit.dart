import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mooover/config/themes/themes.dart';
import 'package:mooover/utils/cubits/app_settings/app_settings_states.dart';
import 'package:mooover/utils/services/app_settings_services.dart';

/// The app settings [Cubit].
///
/// It manages the [AppSettingsState] changes.
class AppSettingsCubit extends Cubit<AppSettingsState> {
  AppSettingsCubit({AppSettingsState? initialState})
      : super(initialState ?? AppSettingsInitialState()) {
    loadAppSettings();
  }

  /// Loads the app settings.
  Future<void> loadAppSettings() async {
    emit(const AppSettingsLoadingState());
    try {
      final appTheme = await AppSettingsServices().getAppTheme();
      emit(AppSettingsLoadedState(appTheme));
    } catch (e) {
      emit(AppSettingsErrorState(e.toString()));
    }
  }

  /// Changes the app style theme.
  ///
  /// Changes the [AppSettingsState] to a new one that uses the picked [AppTheme].
  Future<void> changeTheme(AppTheme appTheme) async {
    emit(const AppSettingsLoadingState());
    try {
      await AppSettingsServices().setAppTheme(appTheme);
      emit(AppSettingsLoadedState(appTheme));
    } catch (e) {
      emit(AppSettingsErrorState(e.toString()));
    }
  }
}
