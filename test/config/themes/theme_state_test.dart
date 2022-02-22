import 'package:flutter_test/flutter_test.dart';
import 'package:mooover/config/themes/theme_state.dart';
import 'package:mooover/config/themes/themes.dart';

void main() {
  group("ThemeStates", () {
    test("compare by fields", () {
      expect(InitialThemeState(), InitialThemeState());
      expect(LoadedThemeState(appThemes[AppThemeName.dark]!),
          LoadedThemeState(appThemes[AppThemeName.dark]!));
    });
  });
}
