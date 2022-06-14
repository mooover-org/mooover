import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mooover/utils/cubits/group_steps/group_steps_states.dart';
import 'package:mooover/utils/services/user_services.dart';
import 'package:mooover/utils/services/user_session_services.dart';

class GroupStepsCubit extends Cubit<GroupStepsState> {
  GroupStepsCubit({GroupStepsState initialState = const GroupStepsNoState()})
      : super(initialState);

  /// This method is used to load the steps info.
  Future<void> loadStepsData() async {
    emit(const GroupStepsLoadingState());
    try {
      final group =
          await UserServices().getGroupOfUser(UserSessionServices().getUserId());
      if (group != null) {
        emit(GroupStepsLoadedState(group.todaySteps, group.dailyStepsGoal,
            group.thisWeekSteps, group.weeklyStepsGoal));
        log('Steps info loaded');
      } else {
        emit(const GroupStepsNoState());
      }
    } catch (e) {
      emit(GroupStepsErrorState(e.toString()));
    }
  }

  /// This method is used to hot reload the steps info.
  Future<void> hotReloadStepsData() async {
    if (state is! GroupStepsLoadedState) {
      emit(const GroupStepsErrorState(
          'Trying to hot reload steps info when it is not loaded'));
      return;
    }
    try {
      final group =
          await UserServices().getGroupOfUser(UserSessionServices().getUserId());
      if (group != null) {
        emit(GroupStepsLoadedState(group.todaySteps, group.dailyStepsGoal,
            group.thisWeekSteps, group.weeklyStepsGoal));
        log('Steps info hot reloaded');
      } else {
        emit(const GroupStepsNoState());
      }
    } catch (e) {
      emit(GroupStepsErrorState(e.toString()));
    }
  }

  /// This method is used to remove the steps info.
  Future<void> removeStepsData() async {
    emit(const GroupStepsLoadingState());
    try {
      emit(const GroupStepsNoState());
      log('Steps info removed');
    } catch (e) {
      emit(GroupStepsErrorState(e.toString()));
    }
  }
}
