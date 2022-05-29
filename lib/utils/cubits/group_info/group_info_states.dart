import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mooover/utils/cubits/group_info/group_info_cubit.dart';
import 'package:mooover/utils/domain/group.dart';
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
  const GroupInfoLoadingState();

  @override
  List<Object> get props => [];
}

/// The loaded state of the [GroupInfoCubit]
@immutable
class GroupInfoLoadedState extends GroupInfoState {
  final List<Group> groups;
  final Group group;
  final List<User> members;

  const GroupInfoLoadedState(this.groups, this.group, this.members);

  @override
  List<Object> get props => [groups, group, members];
}

/// The no state of the [GroupInfoCubit]
@immutable
class GroupInfoNoState extends GroupInfoState {
  final List<Group> groups;

  const GroupInfoNoState(this.groups);

  @override
  List<Object> get props => [groups];
}

/// The error state of the [GroupInfoCubit]
@immutable
class GroupInfoErrorState extends GroupInfoState {
  final String message;

  const GroupInfoErrorState(this.message);

  @override
  List<Object> get props => [message];
}
