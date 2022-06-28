import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mooover/utils/cubits/leaderboard/leaderboard_cubit.dart';
import 'package:mooover/utils/domain/group.dart';

/// The base state of the [LeaderboardCubit]
@immutable
abstract class LeaderboardState extends Equatable {
  const LeaderboardState();
  
  @override
  List<Object> get props => [];
}

/// The loading state of the [LeaderboardCubit]
@immutable
class LeaderboardLoadingState extends LeaderboardState {
  final String message;
  
  const LeaderboardLoadingState({this.message = ''});

  @override
  List<Object> get props => [message];
}

/// The loaded state of the [LeaderboardCubit]
@immutable
class LeaderboardLoadedState extends LeaderboardState {
  final List<Group> groups;
  
  const LeaderboardLoadedState(this.groups);
  
  @override
  List<Object> get props => [groups];
}

/// The error state of the [LeaderboardCubit]
@immutable
class LeaderboardErrorState extends LeaderboardState {
  final String message;

  const LeaderboardErrorState(this.message);

  @override
  List<Object> get props => [message];
}
