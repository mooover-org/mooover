import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mooover/utils/cubits/user_session/user_session_cubit.dart';

/// [UserSessionState] is the base state of the [UserSessionCubit].
@immutable
abstract class UserSessionState extends Equatable {
  const UserSessionState();

  @override
  List<Object?> get props => [];
}

/// [UserSessionLoadingState] is the state of the [UserSessionCubit] when it's loading.
@immutable
class UserSessionLoadingState extends UserSessionState {
  final String? message;
  
  const UserSessionLoadingState({this.message});

  @override
  List<Object?> get props => [message];
}

/// [UserSessionLoadedState] is the state of the [UserSessionCubit] when 
/// the user is logged in.
@immutable
class UserSessionLoadedState extends UserSessionState {
  const UserSessionLoadedState();

  @override
  List<Object?> get props => [];
}

/// [UserSessionNoState] is the state of the [UserSessionCubit] when
/// the user is logged out.
@immutable
class UserSessionNoState extends UserSessionState {
  const UserSessionNoState();

  @override
  List<Object?> get props => [];
}

/// [UserSessionErrorState] is the state of the [UserSessionCubit] when there is an error.
@immutable
class UserSessionErrorState extends UserSessionState {
  final String? message;

  const UserSessionErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
