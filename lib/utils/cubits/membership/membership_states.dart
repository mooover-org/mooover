import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mooover/utils/domain/group.dart';

@immutable
abstract class MembershipState extends Equatable {
  const MembershipState();

  @override
  List<Object?> get props => [];
}

@immutable
class MembershipLoadingState extends MembershipState {
  final String message;

  const MembershipLoadingState({this.message = ''});

  @override
  List<Object?> get props => [message];
}

@immutable
class MembershipLoadedState extends MembershipState {
  final String groupId;

  const MembershipLoadedState(this.groupId);

  @override
  List<Object?> get props => [groupId];
}

@immutable
class MembershipNoState extends MembershipState {
  final List<String> groupIds;

  const MembershipNoState(this.groupIds);

  @override
  List<Object?> get props => [groupIds];
}

@immutable
class MembershipErrorState extends MembershipState {
  final String message;

  const MembershipErrorState(this.message);

  @override
  List<Object?> get props => [message];
}