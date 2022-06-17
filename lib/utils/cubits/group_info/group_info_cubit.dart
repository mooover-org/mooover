import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mooover/utils/cubits/group_info/group_info_states.dart';
import 'package:mooover/utils/domain/group.dart';
import 'package:mooover/utils/services/group_services.dart';
import 'package:mooover/utils/services/user_services.dart';
import 'package:mooover/utils/services/user_session_services.dart';

class GroupInfoCubit extends Cubit<GroupInfoState> {
  GroupInfoCubit(
      {GroupInfoState initialState = const GroupInfoNoState(<Group>[])})
      : super(initialState);

  /// This method is used to load the group info.
  Future<void> loadGroupInfo() async {
    emit(const GroupInfoLoadingState());
    try {
      final group = await UserServices()
          .getGroupOfUser(UserSessionServices().getUserId());
      if (group != null) {
        final groups = await GroupServices().getGroups();
        final members = await GroupServices().getMembersOfGroup(group.id);
        emit(GroupInfoLoadedState(groups, group, members));
        log('Group info loaded');
      } else {
        List<Group> groups = await GroupServices().getGroups();
        emit(GroupInfoNoState(groups));
        log('Group list loaded');
      }
    } catch (e) {
      emit(GroupInfoErrorState(e.toString()));
    }
  }

  /// This method is used to remove the group info.
  Future<void> removeGroupInfo() async {
    emit(const GroupInfoLoadingState());
    try {
      List<Group> groups = await GroupServices().getGroups();
      emit(GroupInfoNoState(groups));
      log('Group info removed');
    } catch (e) {
      emit(GroupInfoErrorState(e.toString()));
    }
  }

  /// This method is used to change the daily steps goal.
  Future<void> changeDailyStepsGoal(int newDailyStepsGoal) async {
    emit(const GroupInfoLoadingState());
    try {
      final group = await UserServices()
          .getGroupOfUser(UserSessionServices().getUserId());
      if (group != null) {
        group.dailyStepsGoal = newDailyStepsGoal;
        await GroupServices().updateGroup(group);
        final groups = await GroupServices().getGroups();
        final members = await GroupServices().getMembersOfGroup(group.id);
        emit(GroupInfoLoadedState(groups, group, members));
        log('Group daily steps goal changed');
      } else {
        emit(const GroupInfoErrorState('The user is not part of any group'));
      }
    } catch (e) {
      emit(GroupInfoErrorState(e.toString()));
    }
  }

  /// This method is used to change the weekly steps goal.
  Future<void> changeWeeklyStepsGoal(int newWeeklyStepsGoal) async {
    emit(const GroupInfoLoadingState());
    try {
      final group = await UserServices()
          .getGroupOfUser(UserSessionServices().getUserId());
      if (group != null) {
        group.weeklyStepsGoal = newWeeklyStepsGoal;
        await GroupServices().updateGroup(group);
        final groups = await GroupServices().getGroups();
        final members = await GroupServices().getMembersOfGroup(group.id);
        emit(GroupInfoLoadedState(groups, group, members));
        log('Group weekly steps goal changed');
      } else {
        emit(const GroupInfoErrorState('The user is not part of any group'));
      }
    } catch (e) {
      emit(GroupInfoErrorState(e.toString()));
    }
  }

  /// This method is used to filter the groups by their nickname.
  Future<void> filterGroups(String nickname) async {
    emit(const GroupInfoLoadingState());
    try {
      final groups = await GroupServices().getGroups(nickname: nickname);
      emit(GroupInfoNoState(groups));
      log('Searched group loaded');
    } catch (e) {
      emit(GroupInfoErrorState(e.toString()));
    }
  }

  /// This method is used to create a new group.
  Future<void> createGroup(String nickname, String name) async {
    emit(const GroupInfoLoadingState());
    try {
      await GroupServices()
          .createGroup(UserSessionServices().getUserId(), nickname, name);
      final group = await UserServices()
          .getGroupOfUser(UserSessionServices().getUserId());
      final groups = await GroupServices().getGroups();
      final members = await GroupServices().getMembersOfGroup(group!.id);
      emit(GroupInfoLoadedState(groups, group, members));
      log('Group created');
    } catch (e) {
      emit(GroupInfoErrorState(e.toString()));
    }
  }

  /// This method is used to join a group.
  Future<void> joinGroup(String nickname) async {
    emit(const GroupInfoLoadingState());
    try {
      await GroupServices()
          .addMemberToGroup(UserSessionServices().getUserId(), nickname);
      final group = await UserServices()
          .getGroupOfUser(UserSessionServices().getUserId());
      final groups = await GroupServices().getGroups();
      final members = await GroupServices().getMembersOfGroup(group!.id);
      emit(GroupInfoLoadedState(groups, group, members));
      log('Group joined');
    } catch (e) {
      emit(GroupInfoErrorState(e.toString()));
    }
  }

  Future<void> leaveGroup() async {
    emit(const GroupInfoLoadingState());
    try {
      final group = await UserServices()
          .getGroupOfUser(UserSessionServices().getUserId());
      await GroupServices()
          .removeMemberFromGroup(UserSessionServices().getUserId(), group!.id);
      final groups = await GroupServices().getGroups();
      emit(GroupInfoNoState(groups));
      log('Group left');
    } catch (e) {
      emit(GroupInfoErrorState(e.toString()));
    }
  }
}
