import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class GroupStepsState extends Equatable {
  const GroupStepsState();

  @override
  List<Object> get props => [];
}

@immutable
class GroupStepsLoadingState extends GroupStepsState {
  final String message;

  const GroupStepsLoadingState({this.message = ''});

  @override
  List<Object> get props => [message];
}

@immutable
class GroupStepsLoadedState extends GroupStepsState {
  final int todaySteps;
  final int thisWeekSteps;

  const GroupStepsLoadedState(this.todaySteps, this.thisWeekSteps);

  @override
  List<Object> get props => [todaySteps, thisWeekSteps];
}

@immutable
class GroupStepsErrorState extends GroupStepsState {
  final String message;

  const GroupStepsErrorState(this.message);

  @override
  List<Object> get props => [message];
}
