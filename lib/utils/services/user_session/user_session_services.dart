import 'dart:developer';

import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:mooover/constants/constants.dart';
import 'package:mooover/utils/domain/exceptions.dart';

/// The user session services.
///
/// It handles the login, logout and other related tasks.
class UserSessionServices {
  static final _instance = UserSessionServices._();

  UserSessionServices._();

  factory UserSessionServices() => _instance;

  final FlutterAppAuth _appAuth = FlutterAppAuth();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

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
      final storedRefreshToken = await _secureStorage.read(key: refreshTokenKey);
      if (storedRefreshToken == null) {
        log("no last session");
        throw LoginException(message: "no last session");
      }
      final TokenResponse? response = await _appAuth.token(
        TokenRequest(
          auth0ClientId,
          auth0RedirectUrl,
          issuer: auth0Issuer,
          refreshToken: storedRefreshToken,
        ),
      );
      if (response == null) {
        log("got null response when refreshing tokens");
        throw LoginException();
      }
      log("got ${response.toString()}");
      await setRefreshToken(response.refreshToken);
      return;
    } on LoginException {
      rethrow;
    } catch (e) {
      log("Error: ${e.toString()}");
      throw LoginException();
    } finally {
      logout();
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
          scopes: ["openid", "profile", "offline_access"],
          promptValues: ["login"],
        ),
      );
      if (response == null) {
        log("got null response when logging in");
        throw LoginException();
      }
      log("got ${response.toString()}");
      await setRefreshToken(response.refreshToken);
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
