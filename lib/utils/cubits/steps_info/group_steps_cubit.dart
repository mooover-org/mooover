import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mooover/utils/cubits/steps_info/group_steps_states.dart';
import 'package:mooover/utils/domain/observer.dart';
import 'package:mooover/utils/services/steps_services.dart';
import 'package:mooover/utils/services/user_services.dart';
import 'package:mooover/utils/services/user_session_services.dart';

class GroupStepsCubit extends Cubit<GroupStepsState> implements Observer {
  GroupStepsCubit(
      {initialState = const GroupStepsErrorState('Group steps unavailable')})
      : super(initialState);

  @override
  void update() {
    hotReload();
  }

  Future<void> hotReload() async {
    try {
      final group = await UserServices()
          .getGroupOfUser(UserSessionServices().getUserId());
      if (group != null) {
        final groupSteps = await StepsServices().getGroupSteps(group.id);
        emit(GroupStepsLoadedState(groupSteps['today_steps'] as int,
            groupSteps['this_week_steps'] as int));
        log('Group steps loaded');
      } else {
        emit(const GroupStepsErrorState('Group steps unavailable'));
        log('Group steps error');
      }
    } catch (e) {
      emit(GroupStepsErrorState(e.toString()));
      log('Group steps error: $e');
    }
  }
}
