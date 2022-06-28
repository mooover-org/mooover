import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mooover/utils/cubits/group_info/group_info_states.dart';
import 'package:mooover/utils/domain/observer.dart';
import 'package:mooover/utils/helpers/logger.dart';
import 'package:mooover/utils/services/group_services.dart';
import 'package:mooover/utils/services/user_services.dart';
import 'package:mooover/utils/services/user_session_services.dart';

class GroupInfoCubit extends Cubit<GroupInfoState> implements Observer {
  GroupInfoCubit(
      {GroupInfoState initialState =
          const GroupInfoErrorState('No group info available')})
      : super(initialState) {
    loadGroupInfo();
    GroupServices().addObserver(this);
  }

  @override
  Future<void> close() {
    GroupServices().removeObserver(this);
    return super.close();
  }

  @override
  void update() {
    reloadGroupInfo();
  }

  /// This method is used to load the group info.
  Future<void> loadGroupInfo() async {
    emit(const GroupInfoLoadingState());
    logger.d('Group info state loading');
    try {
      final group = await UserServices()
          .getGroupOfUser(UserSessionServices().getUserId());
      if (group != null) {
        emit(GroupInfoLoadedState(
          group.nickname,
          group.name,
          group.dailyStepsGoal,
          group.weeklyStepsGoal,
        ));
        logger.d('Group info state loaded: $group');
      } else {
        emit(const GroupInfoErrorState('No group info available'));
        logger.d('Group info state error: No group info available');
      }
    } catch (e) {
      emit(GroupInfoErrorState(e.toString()));
      logger.e('Group info state error: $e');
    }
  }

  /// This method is used to reload the group info.
  Future<void> reloadGroupInfo() async {
    logger.d('Group info state reloading');
    try {
      final group = await UserServices()
          .getGroupOfUser(UserSessionServices().getUserId());
      if (group != null) {
        emit(GroupInfoLoadedState(
          group.nickname,
          group.name,
          group.dailyStepsGoal,
          group.weeklyStepsGoal,
        ));
        logger.d('Group info state reloaded: $group');
      } else {
        emit(const GroupInfoErrorState('No group info available'));
        logger.d('Group info state error: No group info available');
      }
    } catch (e) {
      emit(GroupInfoErrorState(e.toString()));
      logger.e('Group info state error: $e');
    }
  }

  /// This method is used to change the daily steps goal.
  Future<void> changeDailyStepsGoal(int newDailyStepsGoal) async {
    emit(const GroupInfoLoadingState());
    logger.d('Group info state loading');
    try {
      final group = await UserServices()
          .getGroupOfUser(UserSessionServices().getUserId());
      if (group != null) {
        group.dailyStepsGoal = newDailyStepsGoal;
        await GroupServices().updateGroup(group);
        emit(GroupInfoLoadedState(
          group.nickname,
          group.name,
          group.dailyStepsGoal,
          group.weeklyStepsGoal,
        ));
        logger.d('Group daily steps goal state changed: $newDailyStepsGoal');
      } else {
        emit(const GroupInfoErrorState('The user is not part of any group'));
        logger.d(
            'Group daily steps goal state error: The user is not part of any group');
      }
    } catch (e) {
      emit(GroupInfoErrorState(e.toString()));
      logger.e('Group daily steps goal state error: $e');
    }
  }

  /// This method is used to change the weekly steps goal.
  Future<void> changeWeeklyStepsGoal(int newWeeklyStepsGoal) async {
    emit(const GroupInfoLoadingState());
    logger.d('Group info state loading');
    try {
      final group = await UserServices()
          .getGroupOfUser(UserSessionServices().getUserId());
      if (group != null) {
        group.weeklyStepsGoal = newWeeklyStepsGoal;
        await GroupServices().updateGroup(group);
        emit(GroupInfoLoadedState(
          group.nickname,
          group.name,
          group.dailyStepsGoal,
          group.weeklyStepsGoal,
        ));
        logger.d('Group weekly steps goal state changed: $newWeeklyStepsGoal');
      } else {
        emit(const GroupInfoErrorState('The user is not part of any group'));
        logger.d(
            'Group weekly steps goal state error: The user is not part of any group');
      }
    } catch (e) {
      emit(GroupInfoErrorState(e.toString()));
      logger.e('Group weekly steps goal state error: $e');
    }
  }
}
