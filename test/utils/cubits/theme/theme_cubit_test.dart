import 'package:flutter_test/flutter_test.dart';
import 'package:mooover/utils/cubits/theme/theme_cubit.dart';
import 'package:mooover/config/themes/themes.dart';

void main() {
  group("ThemeCubit", () {
    test("theme data should change", () {
      final themeCubit = ThemeCubit();
      expect(themeCubit.state.themeData, appThemes[AppThemeName.light]);
      themeCubit.changeTheme(appThemes[AppThemeName.dark]!);
      expect(themeCubit.state.themeData, appThemes[AppThemeName.dark]);
    });
  });
}
