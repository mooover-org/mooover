import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mooover/utils/cubits/user_info/user_info_cubit.dart';
import 'package:mooover/utils/domain/user.dart';

/// The base state of the [UserInfoCubit]
@immutable
abstract class UserInfoState extends Equatable {
  const UserInfoState();

  @override
  List<Object> get props => [];
}

/// The loading state of the [UserInfoCubit]
@immutable
class UserInfoLoadingState extends UserInfoState {
  final String message;

  const UserInfoLoadingState({this.message = ''});

  @override
  List<Object> get props => [message];
}

/// The loaded state of the [UserInfoCubit]
@immutable
class UserInfoLoadedState extends UserInfoState {
  final User user;

  const UserInfoLoadedState(this.user);

  @override
  List<Object> get props => [user];
}

/// The error state of the [UserInfoCubit]
@immutable
class UserInfoErrorState extends UserInfoState {
  final String message;

  const UserInfoErrorState(this.message);

  @override
  List<Object> get props => [message];
}
