import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mooover/utils/domain/group.dart';

/// The base state of the [GroupsCubit]
@immutable
abstract class GroupsState extends Equatable {
  const GroupsState();

  @override
  List<Object> get props => [];
}

/// The loading state of the [GroupsCubit]
@immutable
class GroupsLoadingState extends GroupsState {
  final String message;

  const GroupsLoadingState({this.message = ''});

  @override
  List<Object> get props => [message];
}

/// The loaded state of the [GroupsCubit]
@immutable
class GroupsLoadedState extends GroupsState {
  final List<Group> groups;

  const GroupsLoadedState(this.groups);

  @override
  List<Object> get props => [groups];
}

/// The error state of the [GroupsCubit]
@immutable
class GroupsErrorState extends GroupsState {
  final String message;

  const GroupsErrorState(this.message);

  @override
  List<Object> get props => [message];
}
