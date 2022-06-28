import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mooover/utils/cubits/group_info/group_info_cubit.dart';
import 'package:mooover/utils/domain/user.dart';

/// The base state of the [GroupInfoCubit]
@immutable
abstract class GroupInfoState extends Equatable {
  const GroupInfoState();

  @override
  List<Object> get props => [];
}

/// The loading state of the [GroupInfoCubit]
@immutable
class GroupInfoLoadingState extends GroupInfoState {
  final String message;

  const GroupInfoLoadingState({this.message = ''});

  @override
  List<Object> get props => [message];
}

/// The loaded state of the [GroupInfoCubit]
@immutable
class GroupInfoLoadedState extends GroupInfoState {
  final String nickname;
  final String name;
  final int dailyStepsGoal;
  final int weeklyStepsGoal;

  const GroupInfoLoadedState(
    this.nickname,
    this.name,
    this.dailyStepsGoal,
    this.weeklyStepsGoal,
  );

  @override
  List<Object> get props => [
        nickname,
        name,
        dailyStepsGoal,
        weeklyStepsGoal,
      ];
}

/// The error state of the [GroupInfoCubit]
@immutable
class GroupInfoErrorState extends GroupInfoState {
  final String message;

  const GroupInfoErrorState(this.message);

  @override
  List<Object> get props => [message];
}
