import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mooover/utils/cubits/group_steps/group_steps_states.dart';
import 'package:mooover/utils/helpers/logger.dart';
import 'package:mooover/utils/services/steps_services.dart';
import 'package:mooover/utils/services/user_services.dart';
import 'package:mooover/utils/services/user_session_services.dart';

class GroupStepsCubit extends Cubit<GroupStepsState> {
  GroupStepsCubit(
      {initialState = const GroupStepsErrorState('Group steps unavailable')})
      : super(initialState) {
    loadGroupSteps();
  }

  Future<void> loadGroupSteps() async {
    emit(const GroupStepsLoadingState());
    logger.d('Group steps state loading');
    try {
      final group = await UserServices()
          .getGroupOfUser(UserSessionServices().getUserId());
      if (group != null) {
        final groupSteps = await StepsServices().getGroupSteps(group.id);
        emit(GroupStepsLoadedState(groupSteps['today_steps'] as int,
            groupSteps['this_week_steps'] as int));
        logger.d('Group steps state loaded: $groupSteps');
      } else {
        emit(const GroupStepsErrorState('Group steps unavailable'));
        logger.e('Group steps state error: Group steps unavailable');
      }
    } catch (e) {
      emit(GroupStepsErrorState(e.toString()));
      logger.e('Group steps state error: $e');
    }
  }

  Future<void> reloadGroupSteps() async {
    logger.d('Group steps state reloading');
    try {
      final group = await UserServices()
          .getGroupOfUser(UserSessionServices().getUserId());
      if (group != null) {
        final groupSteps = await StepsServices().getGroupSteps(group.id);
        emit(GroupStepsLoadedState(groupSteps['today_steps'] as int,
            groupSteps['this_week_steps'] as int));
        logger.d('Group steps state reloaded: $groupSteps');
      } else {
        emit(const GroupStepsErrorState('Group steps unavailable'));
        logger.e('Group steps state error: Group steps unavailable');
      }
    } catch (e) {
      emit(GroupStepsErrorState(e.toString()));
      logger.e('Group steps state error: $e');
    }
  }
}
