import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// The base state of the [UserProfileCubit]
@immutable
abstract class UserProfileInfoState extends Equatable {
  const UserProfileInfoState();

  @override
  List<Object> get props => [];
}

/// The initial state of the [UserProfileCubit]
@immutable
class UserProfileInfoInitialState extends UserProfileInfoState {
  const UserProfileInfoInitialState();

  @override
  List<Object> get props => [];
}

/// The state of the [UserProfileCubit] when the user user_profile is loading
@immutable
class UserProfileInfoLoadingState extends UserProfileInfoState {
  const UserProfileInfoLoadingState();

  @override
  List<Object> get props => [];
}

/// The state of the [UserProfileCubit] when the user user_profile is loaded
@immutable
class UserProfileInfoLoadedState extends UserProfileInfoState {
  final String givenName;
  final String familyName;
  final String name;
  final String nickname;
  final String email;
  final String picture;

  const UserProfileInfoLoadedState(this.givenName, this.familyName, this.name,
      this.nickname, this.email, this.picture);

  @override
  List<Object> get props =>
      [givenName, familyName, name, nickname, email, picture];
}

/// The state of the [UserProfileCubit] when the user user_profile page throws an error
@immutable
class UserProfileInfoErrorState extends UserProfileInfoState {
  final String errorMessage;

  const UserProfileInfoErrorState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
