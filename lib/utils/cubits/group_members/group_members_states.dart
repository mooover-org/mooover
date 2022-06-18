import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mooover/utils/domain/user.dart';

/// The base state of the [GroupMembersCubit]
@immutable
abstract class GroupMembersState extends Equatable {
  const GroupMembersState();

  @override
  List<Object> get props => [];
}

/// The loading state of the [GroupMembersCubit]
@immutable
class GroupMembersLoadingState extends GroupMembersState {
  final String message;

  const GroupMembersLoadingState({this.message = ''});

  @override
  List<Object> get props => [message];
}

/// The loaded state of the [GroupMembersCubit]
@immutable
class GroupMembersLoadedState extends GroupMembersState {
  final List<User> members;

  const GroupMembersLoadedState(this.members);

  @override
  List<Object> get props => [members];
}

/// The error state of the [GroupMembersCubit]
@immutable
class GroupMembersErrorState extends GroupMembersState {
  final String message;

  const GroupMembersErrorState(this.message);

  @override
  List<Object> get props => [message];
}
