import 'package:flutter_test/flutter_test.dart';
import 'package:mooover/utils/cubits/theme/theme_states.dart';
import 'package:mooover/config/themes/themes.dart';

void main() {
  group("ThemeStates", () {
    test("compare by fields", () {
      expect(InitialThemeState(), InitialThemeState());
      expect(ThemeState(appThemes[AppThemeName.dark]!),
          ThemeState(appThemes[AppThemeName.dark]!));
    });
  });
}
