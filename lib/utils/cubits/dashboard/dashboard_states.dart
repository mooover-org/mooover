import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// The base state of the [DashboardCubit].
@immutable
abstract class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object> get props => [];
}

/// The initial state of the [DashboardCubit].
@immutable
class DashboardInitialState extends DashboardState {
  const DashboardInitialState();

  @override
  List<Object> get props => [];
}

/// The state of the [DashboardCubit] when the dashboard is loading.
@immutable
class DashboardLoadingState extends DashboardState {
  const DashboardLoadingState();

  @override
  List<Object> get props => [];
}

/// The state of the [DashboardCubit] when the dashboard is loaded.
@immutable
class DashboardLoadedState extends DashboardState {
  final int steps;
  final int heartPoints;
  final String profilePicture;

  const DashboardLoadedState(this.steps, this.heartPoints, this.profilePicture);

  @override
  List<Object> get props => [steps, heartPoints, profilePicture];
}

/// The state of the [DashboardCubit] when the dashboard throws an error.
@immutable
class DashboardErrorState extends DashboardState {
  final String errorMessage;

  const DashboardErrorState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
