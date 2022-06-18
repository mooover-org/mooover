import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class UserStepsState extends Equatable {
  const UserStepsState();

  @override
  List<Object> get props => [];
}

@immutable
class UserStepsLoadingState extends UserStepsState {
  final String message;

  const UserStepsLoadingState({this.message = ''});

  @override
  List<Object> get props => [message];
}

@immutable
class UserStepsLoadedState extends UserStepsState {
  final int todaySteps;
  final int thisWeekSteps;

  const UserStepsLoadedState(this.todaySteps, this.thisWeekSteps);

  @override
  List<Object> get props => [todaySteps, thisWeekSteps];
}

@immutable
class UserStepsErrorState extends UserStepsState {
  final String message;

  const UserStepsErrorState(this.message);

  @override
  List<Object> get props => [message];
}