import 'dart:developer';

import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';
import 'package:mooover/constants/constants.dart';
import 'package:mooover/constants/endpoints.dart';
import 'package:mooover/utils/domain/exceptions.dart';
import 'package:mooover/utils/domain/id_token.dart';
import 'package:mooover/utils/helpers/auth_interceptor.dart';

/// The user session services.
///
/// It handles the login, logout and other related tasks.
class UserSessionServices {
  static final _instance = UserSessionServices._();

  UserSessionServices._();

  factory UserSessionServices() => _instance;

  final FlutterAppAuth _appAuth = FlutterAppAuth();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  final http.Client httpClient = InterceptedClient.build(interceptors: [
    AuthInterceptor(),
  ]);

  IdToken? idToken;
  String? accessToken;
  String? refreshToken;

  /// Sets the refresh token value in memory and in the secure storage.
  Future<void> setRefreshToken(String? value) async {
    refreshToken = value;
    await _secureStorage.write(key: refreshTokenKey, value: value);
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
          await _secureStorage.read(key: refreshTokenKey);
      if (storedRefreshToken == null) {
        log("no last session");
        throw LoginException(message: "no last session");
      }
      final TokenResponse? response = await _appAuth.token(
        TokenRequest(
          auth0ClientId,
          auth0RedirectUrl,
          issuer: auth0Issuer,
          additionalParameters: {"audience": auth0Audience},
          refreshToken: storedRefreshToken,
        ),
      );
      if (response == null) {
        log("got null response when refreshing tokens");
        throw LoginException();
      }
      log("got ${response.toString()}");
      idToken = IdToken.fromString(response.idToken);
      accessToken = response.accessToken;
      await setRefreshToken(response.refreshToken);
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
  ///
  /// Throws [LoginException] if login process fails.
  Future<void> login() async {
    try {
      final AuthorizationTokenResponse? response =
          await _appAuth.authorizeAndExchangeCode(
        AuthorizationTokenRequest(
          auth0ClientId,
          auth0RedirectUrl,
          issuer: auth0Issuer,
          additionalParameters: {"audience": auth0Audience},
          scopes: ["openid", "profile", "offline_access", "email"],
          promptValues: ["login"],
        ),
      );
      if (response == null) {
        log("got null response when logging in");
        throw LoginException();
      }
      log("got ${response.toString()}");
      idToken = IdToken.fromString(response.idToken);
      accessToken = response.accessToken;
      await setRefreshToken(response.refreshToken);
      try {
        await httpClient.post(userServicesUrl.toUri(),
            body: {"user_id": idToken!.userId, "name": idToken!.name});
      } catch (e) {
        log(e.toString());
      }
      return;
    } on LoginException {
      rethrow;
    } catch (e) {
      log("Error: ${e.toString()}");
      throw LoginException();
    }
  }

  /// Performs a logout action.
  ///
  /// Logs out the user from the Auth0 server as well as locally.
  ///
  /// Throws [LogoutException] if logout process fails.
  Future<void> logout() async {
    try {
      await _secureStorage.delete(key: refreshTokenKey);
      await http.get(
        Uri.https(
          auth0Domain,
          '/v2/logout',
          {
            'client_id': auth0ClientId,
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
}
