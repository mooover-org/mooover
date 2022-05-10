import 'package:flutter_test/flutter_test.dart';
import 'package:mooover/utils/cubits/app_settings/app_settings_states.dart';
import 'package:mooover/config/themes/themes.dart';

void main() {
  group("AppSettingsStates", () {
    test("compare by fields", () {
      expect(AppSettingsInitialState(), AppSettingsInitialState());
      expect(const AppSettingsLoadedState(AppTheme.dark),
          const AppSettingsLoadedState(AppTheme.dark));
    });
  });
}
