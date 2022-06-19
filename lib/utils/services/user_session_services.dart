import 'dart:convert';

import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';
import 'package:mooover/utils/domain/exceptions.dart';
import 'package:mooover/utils/domain/id_token.dart';
import 'package:mooover/utils/helpers/app_config.dart';
import 'package:mooover/utils/helpers/auth_interceptor.dart';
import 'package:mooover/utils/helpers/logger.dart';

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
    logger.d('Refresh token set to $value');
  }

  /// Attempts to load the last user session.
  ///
  /// Reads the locally stored refresh token and requests a new session from the
  /// Auth0 authentication and authorization service.
  ///
  /// Throws [LoginException] if the process fails.
  Future<void> loadLastSession() async {
    logger.d('Loading last session');
    try {
      final storedRefreshToken =
          await _secureStorage.read(key: AppConfig().refreshTokenKey);
      if (storedRefreshToken == null) {
        logger.d("No refresh token found");
        throw LoginException(message: "no last session");
      }
      logger.d("Found refresh token: $storedRefreshToken");
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
        logger.d("Null response from token request");
        throw LoginException();
      }
      _idToken = IdToken.fromString(response.idToken);
      accessToken = response.accessToken;
      await setRefreshToken(response.refreshToken!);
      logger.i("Loaded last session");
      return;
    } catch (e) {
      logger.e("Failed to load last session", e);
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
    logger.d("Login requested");
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
        logger.d("Null response from authorization request");
        throw LoginException();
      }
      _idToken = IdToken.fromString(response.idToken);
      accessToken = response.accessToken;
      try {
        final registeredUserResponse = await _httpClient.get(Uri.http(
            AppConfig().apiDomain,
            '${AppConfig().userServicesPath}/${_idToken!.sub}'));
        if (registeredUserResponse.statusCode == 404) {
          logger.d("User not found in database");
          await registerNewUser();
        }
      } on http.ClientException {
        logger.e("Failed to check if user is registered");
        throw LoginException();
      }
      await setRefreshToken(response.refreshToken!);
      logger.i("Logged in: ${_idToken!.sub}");
    } catch (e) {
      logger.e("Failed to login", e);
      rethrow;
    }
  }

  /// Registers a new user.
  Future<void> registerNewUser() async {
    logger.d("Registering new user");
    try {
      final userInfo = jsonDecode((await _httpClient
              .get(Uri.https(AppConfig().auth0Domain, '/userinfo')))
          .body);
      logger.d("User info: $userInfo");
      final response = await _httpClient
          .post(Uri.http(AppConfig().apiDomain, AppConfig().userServicesPath),
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
        logger.e("Failed to register new user: ${response.statusCode}");
        throw LoginException(message: "could not register user");
      }
      logger.i("Registered new user");
    } catch (e) {
      logger.e("Failed to register new user", e);
      throw LoginException(message: e.toString());
    }
  }

  /// Performs a logout action.
  ///
  /// Logs out the user from the Auth0 server as well as locally.
  ///
  /// Throws [LogoutException] if logout process fails.
  Future<void> logout() async {
    logger.d("Logout requested");
    try {
      await _secureStorage.delete(key: AppConfig().refreshTokenKey);
      accessToken = null;
      logger.d("Cleared refresh and access token");
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
      logger.i("Logged out");
      return;
    } catch (e) {
      logger.e("Failed to logout", e);
      throw LogoutException();
    }
  }

  /// Returns the currently logged in user's id.
  String getUserId() {
    if (_idToken == null) {
      logger.w("No user logged in");
      throw Exception("No user logged in");
    }
    logger.d("User id: ${_idToken!.sub}");
    return _idToken!.sub;
  }

  /// Returns the user session status.
  bool liveUserSession() {
    return accessToken != null;
  }
}
