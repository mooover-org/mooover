import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mooover/utils/cubits/group_steps/group_steps_cubit.dart';

/// The base state of the [GroupStepsCubit]
@immutable
abstract class GroupStepsState extends Equatable {
  const GroupStepsState();

  @override
  List<Object> get props => [];
}

/// The loading state of the [GroupStepsCubit]
@immutable
class GroupStepsLoadingState extends GroupStepsState {
  const GroupStepsLoadingState();

  @override
  List<Object> get props => [];
}

/// The loaded state of the [GroupStepsCubit]
@immutable
class GroupStepsLoadedState extends GroupStepsState {
  final int todaySteps;
  final int dailyStepsGoal;
  final int thisWeekSteps;
  final int weeklyStepsGoal;

  const GroupStepsLoadedState(this.todaySteps, this.dailyStepsGoal,
      this.thisWeekSteps, this.weeklyStepsGoal);

  @override
  List<Object> get props => [
        todaySteps,
        dailyStepsGoal,
        thisWeekSteps,
        weeklyStepsGoal,
      ];
}

/// The no state of the [GroupStepsCubit]
@immutable
class GroupStepsNoState extends GroupStepsState {
  const GroupStepsNoState();

  @override
  List<Object> get props => [];
}

/// The error state of the [GroupStepsCubit]
@immutable
class GroupStepsErrorState extends GroupStepsState {
  final String message;

  const GroupStepsErrorState(this.message);

  @override
  List<Object> get props => [message];
}
