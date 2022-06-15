import 'dart:convert';
import 'dart:developer';

import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';
import 'package:mooover/utils/domain/exceptions.dart';
import 'package:mooover/utils/domain/id_token.dart';
import 'package:mooover/utils/helpers/app_config.dart';
import 'package:mooover/utils/helpers/auth_interceptor.dart';

/// The user session services.
///
/// It handles the login, logout and other related tasks.
class UserSessionServices {
  static final _instance = UserSessionServices._();

  UserSessionServices._();

  factory UserSessionServices() => _instance;

  final http.Client _httpClient = InterceptedClient.build(interceptors: [
    AuthInterceptor(),
  ]);
  final FlutterAppAuth _appAuth = FlutterAppAuth();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  IdToken? _idToken;
  String? accessToken;
  String? refreshToken;

  /// Sets the refresh token value in memory and in the secure storage.
  Future<void> setRefreshToken(String value) async {
    refreshToken = value;
    await _secureStorage.write(key: AppConfig().refreshTokenKey, value: value);
  }

  /// Attempts to load the last user session.
  ///
  /// Reads the locally stored refresh token and requests a new session from the
  /// Auth0 authentication and authorization service.
  ///
  /// Throws [LoginException] if the process fails.
  Future<void> loadLastSession() async {
    try {
      final storedRefreshToken =
          await _secureStorage.read(key: AppConfig().refreshTokenKey);
      if (storedRefreshToken == null) {
        log("no last session");
        throw LoginException(message: "no last session");
      }
      final TokenResponse? response = await _appAuth.token(
        TokenRequest(
          AppConfig().auth0ClientId,
          AppConfig().auth0RedirectUrl,
          issuer: AppConfig().auth0Issuer,
          additionalParameters: {"audience": AppConfig().auth0Audience},
          refreshToken: storedRefreshToken,
        ),
      );
      if (response == null) {
        log("got null response when refreshing tokens");
        throw LoginException();
      }
      _idToken = IdToken.fromString(response.idToken);
      accessToken = response.accessToken;
      await setRefreshToken(response.refreshToken!);
      return;
    } on LoginException {
      logout();
      rethrow;
    } catch (e) {
      log("Error: ${e.toString()}");
      logout();
      throw LoginException();
    }
  }

  /// Performs a login action.
  ///
  /// Opens a web browser page and logs the user in through the Auth0 service.
  /// The method then attempts to add the user to the database if necessary.
  ///
  /// Throws [LoginException] if login process fails.
  Future<void> login() async {
    try {
      final AuthorizationTokenResponse? response =
          await _appAuth.authorizeAndExchangeCode(
        AuthorizationTokenRequest(
          AppConfig().auth0ClientId,
          AppConfig().auth0RedirectUrl,
          issuer: AppConfig().auth0Issuer,
          additionalParameters: {"audience": AppConfig().auth0Audience},
          scopes: ["openid", "profile", "offline_access", "email"],
          promptValues: ["login"],
        ),
      );
      if (response == null) {
        log("got null response when logging in");
        throw LoginException();
      }
      _idToken = IdToken.fromString(response.idToken);
      accessToken = response.accessToken;
      try {
        final registeredUserResponse = await _httpClient
            .get("${AppConfig().userServicesUrl}/${_idToken!.sub}".toUri());
        if (registeredUserResponse.statusCode == 404) {
          await registerNewUser();
        }
      } on http.ClientException {
        throw LoginException();
      }
      await setRefreshToken(response.refreshToken!);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  /// Registers a new user.
  Future<void> registerNewUser() async {
    try {
      final userInfo = jsonDecode(
          (await _httpClient.get("${AppConfig().auth0Issuer}/userinfo".toUri()))
              .body);
      final response =
          await _httpClient.post((AppConfig().userServicesUrl).toUri(),
              body: jsonEncode({
                "sub": userInfo["sub"],
                "name": userInfo["name"],
                "given_name": userInfo["given_name"],
                "family_name": userInfo["family_name"],
                "nickname": userInfo["nickname"],
                "email": userInfo["email"],
                "picture": userInfo["picture"],
              }),
              headers: {"Content-Type": "application/json"});
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw LoginException(message: "could not register user");
      }
    } catch (e) {
      throw LoginException(message: e.toString());
    }
  }

  /// Performs a logout action.
  ///
  /// Logs out the user from the Auth0 server as well as locally.
  ///
  /// Throws [LogoutException] if logout process fails.
  Future<void> logout() async {
    try {
      await _secureStorage.delete(key: AppConfig().refreshTokenKey);
      accessToken = null;
      await http.get(
        Uri.https(
          AppConfig().auth0Domain,
          '/v2/logout',
          {
            'client_id': AppConfig().auth0ClientId,
            'federated': '',
          },
        ),
        headers: {'Authorization': 'Bearer $accessToken'},
      );
      log("logged out successfully");
      return;
    } catch (e) {
      log("Error: ${e.toString()}");
      throw LogoutException();
    }
  }

  /// Returns the currently logged in user's id token.
  String getUserId() {
    if (_idToken == null) {
      throw Exception("no id token");
    }
    return _idToken!.sub;
  }

  /// Returns the user session status.
  bool liveUserSession() {
    return accessToken != null;
  }
}
