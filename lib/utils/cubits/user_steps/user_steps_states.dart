import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mooover/utils/cubits/user_steps/user_steps_cubit.dart';

/// The base state of the [UserStepsCubit]
@immutable
abstract class UserStepsState extends Equatable {
  const UserStepsState();

  @override
  List<Object> get props => [];
}

/// The loading state of the [UserStepsCubit]
@immutable
class UserStepsLoadingState extends UserStepsState {
  const UserStepsLoadingState();

  @override
  List<Object> get props => [];
}

/// The loaded state of the [UserStepsCubit]
@immutable
class UserStepsLoadedState extends UserStepsState {
  final int todaySteps;
  final int dailyStepsGoal;
  final int thisWeekSteps;
  final int weeklyStepsGoal;
  final String pedestrianStatus;

  const UserStepsLoadedState(this.todaySteps, this.dailyStepsGoal,
      this.thisWeekSteps, this.weeklyStepsGoal, this.pedestrianStatus);

  @override
  List<Object> get props => [
        todaySteps,
        dailyStepsGoal,
        thisWeekSteps,
        weeklyStepsGoal,
        pedestrianStatus
      ];
}

/// The no state of the [UserStepsCubit]
@immutable
class UserStepsNoState extends UserStepsState {
  const UserStepsNoState();

  @override
  List<Object> get props => [];
}

/// The error state of the [UserStepsCubit]
@immutable
class UserStepsErrorState extends UserStepsState {
  final String message;

  const UserStepsErrorState(this.message);

  @override
  List<Object> get props => [message];
}
