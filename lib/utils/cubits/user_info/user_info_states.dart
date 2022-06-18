import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mooover/utils/cubits/user_info/user_info_cubit.dart';

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
  final String name;
  final String givenName;
  final String familyName;
  final String nickname;
  final String email;
  final String picture;
  final int dailyStepsGoal;
  final int weeklyStepsGoal;

  const UserInfoLoadedState(
    this.name,
    this.givenName,
    this.familyName,
    this.nickname,
    this.email,
    this.picture,
    this.dailyStepsGoal,
    this.weeklyStepsGoal,
  );

  @override
  List<Object> get props => [
        name,
        givenName,
        familyName,
        nickname,
        email,
        picture,
        dailyStepsGoal,
        weeklyStepsGoal,
      ];
}

/// The error state of the [UserInfoCubit]
@immutable
class UserInfoErrorState extends UserInfoState {
  final String message;

  const UserInfoErrorState(this.message);

  @override
  List<Object> get props => [message];
}
