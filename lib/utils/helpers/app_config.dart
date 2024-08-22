import 'dart:convert';
import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:mooover/config/themes/themes.dart';

class AppConfig {
  static final AppConfig _instance = AppConfig._();

  String bundleIdentifier = "usr.adipopbv.mooover";
  AppTheme initialAppTheme = AppTheme.light;
  String apiDomain = "localhost:8000";
  String basePath = "/api/v1";
  String userServicesPath = "/api/v1/users";
  String groupServicesPath = "/api/v1/groups";
  String stepsServicesPath = "/api/v1/steps";
  String auth0Domain = "";
  String auth0ClientId = "";
  String auth0RedirectUrl = "";
  String auth0Issuer = "";
  String auth0Audience = "";
  String refreshTokenKey = "refresh_token";
  String lastStepsCountKey = "last_steps_count";
  int stepsUpdateInterval = 5;

  AppConfig._();

  factory AppConfig() => _instance;

  static Future<void> loadForDevelopment() async {
    try {
      final json =
          jsonDecode(await rootBundle.loadString('assets/config/dev.json'));
      _fromJson(json);
    } catch (e) {
      log("Error loading config for development: $e");
    }
  }

  static Future<void> loadForProduction() async {
    try {
      final json =
          jsonDecode(await rootBundle.loadString('assets/config/prod.json'));
      _fromJson(json);
    } catch (e) {
      log("Error loading config for production: $e");
    }
  }

  static void _fromJson(Map<String, dynamic> json) {
    _instance.bundleIdentifier = json["app"]["bundleIdentifier"];
    _instance.initialAppTheme =
        appThemeFromString(json["app"]["initialAppTheme"]);
    _instance.apiDomain = json["api"]["domain"];
    _instance.basePath = json["api"]["basePath"];
    _instance.userServicesPath = json["api"]["userServicesPath"];
    _instance.groupServicesPath = json["api"]["groupServicesPath"];
    _instance.stepsServicesPath = json["api"]["stepsServicesPath"];
    _instance.auth0Domain = json["auth0"]["domain"];
    _instance.auth0ClientId = json["auth0"]["clientId"];
    _instance.auth0RedirectUrl = json["auth0"]["redirectUrl"];
    _instance.auth0Issuer = json["auth0"]["issuer"];
    _instance.auth0Audience = json["auth0"]["audience"];
    _instance.refreshTokenKey = json["auth0"]["refreshTokenKey"];
    _instance.lastStepsCountKey = json["app"]["lastStepsCountKey"];
    _instance.stepsUpdateInterval = json["app"]["stepsUpdateInterval"];
  }
}
