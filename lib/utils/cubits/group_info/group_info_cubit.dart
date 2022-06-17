import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mooover/utils/cubits/group_info/group_info_states.dart';
import 'package:mooover/utils/domain/group.dart';
import 'package:mooover/utils/domain/initializable.dart';
import 'package:mooover/utils/services/group_services.dart';
import 'package:mooover/utils/services/user_services.dart';
import 'package:mooover/utils/services/user_session_services.dart';

class GroupInfoCubit extends Cubit<GroupInfoState> implements Initializable {
  GroupInfoCubit(
      {GroupInfoState initialState = const GroupInfoNoState(<Group>[])})
      : super(initialState);

  @override
  Future<void> initialize() async {
    await load();
  }

  @override
  Future<void> dispose() async {
    emit(const GroupInfoErrorState('Group info not available'));
  }

  /// This method is used to load the group info.
  Future<void> load() async {
    emit(const GroupInfoLoadingState());
    try {
      final group = await UserServices()
          .getGroupOfUser(UserSessionServices().getUserId());
      if (group != null) {
        final members = await GroupServices()
            .getMembersOfGroup(group.id, orderedBySteps: true);
        emit(GroupInfoLoadedState(group, members));
        log('Group info loaded');
      } else {
        List<Group> groups = await GroupServices().getGroups();
        emit(GroupInfoNoState(groups));
        log('Groups list loaded');
      }
    } catch (e) {
      emit(GroupInfoErrorState(e.toString()));
      log('Group info error: $e');
    }
  }

  Future<void> hotReload() async {
    try {
      final group = await UserServices()
          .getGroupOfUser(UserSessionServices().getUserId());
      if (group != null) {
        final members = await GroupServices()
            .getMembersOfGroup(group.id, orderedBySteps: true);
        emit(GroupInfoLoadedState(group, members));
        log('Group info hot reloaded');
      } else {
        List<Group> groups = await GroupServices().getGroups();
        emit(GroupInfoNoState(groups));
        log('Groups list hot reloaded');
      }
    } catch (e) {
      emit(GroupInfoErrorState(e.toString()));
      log('Group info error: $e');
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
        final members = await GroupServices()
            .getMembersOfGroup(group.id, orderedBySteps: true);
        emit(GroupInfoLoadedState(group, members));
        log('Group daily steps goal changed');
      } else {
        emit(const GroupInfoErrorState('The user is not part of any group'));
        log('The user is not part of any group');
      }
    } catch (e) {
      emit(GroupInfoErrorState(e.toString()));
      log('Group info error: $e');
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
        final members = await GroupServices()
            .getMembersOfGroup(group.id, orderedBySteps: true);
        emit(GroupInfoLoadedState(group, members));
        log('Group weekly steps goal changed');
      } else {
        emit(const GroupInfoErrorState('The user is not part of any group'));
        log('The user is not part of any group');
      }
    } catch (e) {
      emit(GroupInfoErrorState(e.toString()));
      log('Group info error: $e');
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
      log('Groups list error: $e');
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
      if (group != null) {
        final members = await GroupServices()
            .getMembersOfGroup(group.id, orderedBySteps: true);
        emit(GroupInfoLoadedState(group, members));
        log('Group created');
      } else {
        emit(const GroupInfoErrorState('The user is not part of any group'));
        log('The user is not part of any group');
      }
    } catch (e) {
      emit(GroupInfoErrorState(e.toString()));
      log('Group info error: $e');
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
      if (group != null) {
        final members = await GroupServices()
            .getMembersOfGroup(group.id, orderedBySteps: true);
        emit(GroupInfoLoadedState(group, members));
        log('Group joined');
      } else {
        emit(const GroupInfoErrorState('The user is not part of any group'));
        log('The user is not part of any group');
      }
    } catch (e) {
      emit(GroupInfoErrorState(e.toString()));
      log('Group info error: $e');
    }
  }

  Future<void> leaveGroup() async {
    emit(const GroupInfoLoadingState());
    try {
      final group = await UserServices()
          .getGroupOfUser(UserSessionServices().getUserId());
      if (group != null) {
        await GroupServices()
            .removeMemberFromGroup(UserSessionServices().getUserId(), group.id);
        final groups = await GroupServices().getGroups();
        emit(GroupInfoNoState(groups));
        log('Group left');
      } else {
        emit(const GroupInfoErrorState('The user is not part of any group'));
        log('The user is not part of any group');
      }
    } catch (e) {
      emit(GroupInfoErrorState(e.toString()));
      log('Group info error: $e');
    }
  }
}
