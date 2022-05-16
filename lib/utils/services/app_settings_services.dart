import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mooover/config/themes/themes.dart';
import 'package:mooover/utils/helpers/app_config.dart';

class AppSettingsServices {
  static final _instance = AppSettingsServices._();

  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  AppSettingsServices._();

  factory AppSettingsServices() => _instance;

  Future<void> setAppTheme(AppTheme appTheme) async {
    await _secureStorage.write(
        key: AppConfig().appThemeKey, value: appThemeToString(appTheme));
  }

  Future<AppTheme> getAppTheme() async {
    final appThemeString =
        await _secureStorage.read(key: AppConfig().appThemeKey);
    if (appThemeString == null) {
      return AppTheme.light;
    }
    return appThemeFromString(appThemeString);
  }
}
