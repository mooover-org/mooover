import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mooover/utils/cubits/steps_info/user_steps_states.dart';
import 'package:mooover/utils/domain/initializable.dart';
import 'package:mooover/utils/domain/observer.dart';
import 'package:mooover/utils/services/steps_services.dart';
import 'package:mooover/utils/services/user_session_services.dart';

class UserStepsCubit extends Cubit<UserStepsState>
    implements Initializable, Observer {
  UserStepsCubit(
      {initialState = const UserStepsErrorState('User steps unavailable')})
      : super(initialState);

  @override
  Future<void> initialize() async {
    await load();
  }

  @override
  Future<void> dispose() async {
    emit(const UserStepsErrorState('User steps not available'));
  }

  @override
  void update() {
    hotReload();
  }

  Future<void> load() async {
    emit(const UserStepsLoadingState());
    try {
      final userSteps =
          await StepsServices().getUserSteps(UserSessionServices().getUserId());
      emit(UserStepsLoadedState(userSteps['today_steps'] as int,
          userSteps['this_week_steps'] as int));
      log('User steps loaded');
    } catch (e) {
      emit(UserStepsErrorState(e.toString()));
      log('User steps error: $e');
    }
  }

  Future<void> hotReload() async {
    try {
      final userSteps =
          await StepsServices().getUserSteps(UserSessionServices().getUserId());
      emit(UserStepsLoadedState(userSteps['today_steps'] as int,
          userSteps['this_week_steps'] as int));
      log('User steps loaded');
    } catch (e) {
      emit(UserStepsErrorState(e.toString()));
      log('User steps error: $e');
    }
  }
}
