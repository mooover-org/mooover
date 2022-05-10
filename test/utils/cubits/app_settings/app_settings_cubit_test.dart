import 'package:flutter_test/flutter_test.dart';
import 'package:mooover/utils/cubits/app_settings/app_settings_cubit.dart';
import 'package:mooover/config/themes/themes.dart';
import 'package:mooover/utils/cubits/app_settings/app_settings_states.dart';

void main() {
  group("AppSettingsCubit", () {
    test("app theme should change", () {
      final themeCubit = AppSettingsCubit();
      var state = themeCubit.state as AppSettingsInitialState;
      expect(state.appTheme, AppTheme.light);
      themeCubit.changeTheme(AppTheme.dark);
      var newState = themeCubit.state as AppSettingsLoadedState;
      expect(newState.appTheme, AppTheme.dark);
    });
  });
}
