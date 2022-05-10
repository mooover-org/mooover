import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// [UserSessionState] is the base state of the [UserSessionCubit].
@immutable
abstract class UserSessionState extends Equatable {
  const UserSessionState();
}

/// [UserSessionInitial] is the initial state of the [UserSessionCubit].
@immutable
class UserSessionInitialState extends UserSessionState {
  const UserSessionInitialState();

  @override
  List<Object?> get props => [];
}

/// [UserSessionLoading] is the state of the [UserSessionCubit] when it's loading.
@immutable
class UserSessionLoadingState extends UserSessionState {
  const UserSessionLoadingState();

  @override
  List<Object?> get props => [];
}

/// [UserSessionLoaded] is the state of the [UserSessionCubit] when it's loaded.
@immutable
class UserSessionValidState extends UserSessionState {
  const UserSessionValidState();

  @override
  List<Object?> get props => [];
}

/// [UserSessionLoaded] is the state of the [UserSessionCubit] when there is no user session.
@immutable
class UserSessionNoState extends UserSessionState {
  const UserSessionNoState();

  @override
  List<Object?> get props => [];
}
