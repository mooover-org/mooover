import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class UserSessionState extends Equatable {
  const UserSessionState();
}

@immutable
class NoUserSessionState extends UserSessionState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

@immutable
class LoadingUserSessionState extends UserSessionState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

@immutable
class ValidUserSessionState extends UserSessionState {
  final String accessToken;
  final DateTime accessTokenExpirationDateTime;
  final String refreshToken;

  const ValidUserSessionState(this.accessToken, this.accessTokenExpirationDateTime, this.refreshToken);

  @override
  List<Object?> get props => [accessToken, refreshToken];
}

@immutable
class InvalidUserSessionState extends UserSessionState {
  final String errorMessage;

  const InvalidUserSessionState(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
