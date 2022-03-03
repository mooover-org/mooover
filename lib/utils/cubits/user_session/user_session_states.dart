import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class UserSessionState extends Equatable {
  const UserSessionState();
}

@immutable
class InitialUserSessionState extends UserSessionState {
  const InitialUserSessionState();

  @override
  List<Object?> get props => [];
}

@immutable
class LoadingUserSessionState extends UserSessionState {
  const LoadingUserSessionState();

  @override
  List<Object?> get props => [];
}

@immutable
class NoUserSessionState extends UserSessionState {
  const NoUserSessionState();

  @override
  List<Object?> get props => [];
}

@immutable
class ValidUserSessionState extends UserSessionState {
  const ValidUserSessionState();

  @override
  List<Object?> get props => [];
}
