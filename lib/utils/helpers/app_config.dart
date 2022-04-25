import 'dart:convert';

import 'package:flutter/services.dart';

class AppConfig {
  String bundleIdentifier = "";
  String userServicesUrl = "";
  String auth0Domain = "";
  String auth0ClientId = "";
  String auth0RedirectUrl = "";
  String auth0Issuer = "";
  String auth0Audience = "";
  String refreshTokenKey = "";

  static final AppConfig _instance = AppConfig._();

  factory AppConfig() {
    return _instance;
  }

  AppConfig._();

  static Future<void> loadForDevelopment() async {
    final json =
        jsonDecode(await rootBundle.loadString('assets/config/dev.json'));
    _fromJson(json);
  }

  static Future<void> loadForProduction() async {
    final json =
        jsonDecode(await rootBundle.loadString('assets/config/prod.json'));
    _fromJson(json);
  }

  static void _fromJson(json) {
    _instance.bundleIdentifier = json["app"]["bundleIdentifier"];
    _instance.userServicesUrl = json["api"]["userServicesUrl"];
    _instance.auth0Domain = json["auth0"]["domain"];
    _instance.auth0ClientId = json["auth0"]["clientId"];
    _instance.auth0RedirectUrl = json["auth0"]["redirectUrl"];
    _instance.auth0Issuer = json["auth0"]["issuer"];
    _instance.auth0Audience = json["auth0"]["audience"];
    _instance.refreshTokenKey = json["auth0"]["refreshTokenKey"];
  }
}
