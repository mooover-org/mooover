import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mooover/utils/cubits/user_steps/user_steps_states.dart';
import 'package:mooover/utils/services/steps_services.dart';
import 'package:mooover/utils/services/user_services.dart';
import 'package:mooover/utils/services/user_session_services.dart';

class UserStepsCubit extends Cubit<UserStepsState> {
  UserStepsCubit(
      {UserStepsState initialState = const UserStepsNoState()})
      : super(initialState);

  /// This method is used to load the steps info.
  Future<void> loadStepsData() async {
    emit(const UserStepsLoadingState());
    try {
      final user =
          await UserServices().getUser(UserSessionServices().getUserId());
      String pedestrianStatus = StepsServices().getPedestrianStatus();
      emit(UserStepsLoadedState(user.todaySteps, user.dailyStepsGoal,
          user.thisWeekSteps, user.weeklyStepsGoal, pedestrianStatus));
      log('Steps info loaded');
    } catch (e) {
      emit(UserStepsErrorState(e.toString()));
    }
  }

  /// This method is used to hot reload the steps info.
  Future<void> hotReloadStepsData() async {
    if (state is! UserStepsLoadedState) {
      emit(const UserStepsErrorState(
          'Trying to hot reload steps info when it is not loaded'));
      return;
    }
    try {
      final user =
          await UserServices().getUser(UserSessionServices().getUserId());
      String pedestrianStatus = StepsServices().getPedestrianStatus();
      emit(UserStepsLoadedState(user.todaySteps, user.dailyStepsGoal,
          user.thisWeekSteps, user.weeklyStepsGoal, pedestrianStatus));
      log('Steps info reloaded');
    } catch (e) {
      emit(UserStepsErrorState(e.toString()));
    }
  }

  /// This method is used to remove the steps info.
  Future<void> removeStepsData() async {
    emit(const UserStepsLoadingState());
    try {
      emit(const UserStepsNoState());
      log('Steps info removed');
    } catch (e) {
      emit(UserStepsErrorState(e.toString()));
    }
  }
}
