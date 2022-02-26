import 'dart:developer';

import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mooover/constants/constants.dart';
import 'package:mooover/utils/cubits/user_session/user_session_states.dart';

/// The user session [Cubit].
///
/// It manages the [UserSessionState] changes.
class UserSessionCubit extends Cubit<UserSessionState> {
  final FlutterAppAuth appAuth = FlutterAppAuth();
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  UserSessionCubit(UserSessionState initialState) : super(initialState);

  /// Performs a login action.
  Future<void> loginAction() async {
    emit(LoadingUserSessionState());
    try {
      log("sending auth request");
      final AuthorizationTokenResponse? response =
          await appAuth.authorizeAndExchangeCode(
        AuthorizationTokenRequest(
          auth0ClientId,
          auth0RedirectUrl,
          issuer: auth0Issuer,
          scopes: ['openid', 'profile', 'offline_access'],
          promptValues: ['login'],
        ),
      );
      if (response == null) {
        log("got null");
        emit(const InvalidUserSessionState("unable to initialize session"));
        return;
      }
      log("got " + response.toString());
      await secureStorage.write(
          key: 'refresh_token', value: response.refreshToken);
      emit(ValidUserSessionState(response.accessToken!,
          response.accessTokenExpirationDateTime!, response.refreshToken!));
    } catch (_) {
      emit(const InvalidUserSessionState("unable to initialize session"));
    }
  }

  Future<void> refreshPastSession() async {
    final storedRefreshToken = await secureStorage.read(key: 'refresh_token');
    if (storedRefreshToken == null) {
      emit(NoUserSessionState());
    }
    emit(LoadingUserSessionState());
    try {
      final response = await appAuth.token(TokenRequest(
        auth0ClientId,
        auth0RedirectUrl,
        issuer: auth0Issuer,
        refreshToken: storedRefreshToken,
      ));
      if (response == null) {
        emit(const InvalidUserSessionState("unable to refresh last session"));
        return;
      }
      await secureStorage.write(
          key: 'refresh_token', value: response.refreshToken);
      emit(ValidUserSessionState(response.accessToken!,
          response.accessTokenExpirationDateTime!, response.refreshToken!));
    } catch (_) {
      emit(const InvalidUserSessionState("unable to initialize session"));
    }
  }

  Future<void> logoutAction() async {
    await secureStorage.delete(key: 'refresh_token');
    emit(NoUserSessionState());
  }
}
