import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mooover/utils/cubits/user_info/user_info_states.dart';
import 'package:mooover/utils/domain/user.dart';
import 'package:mooover/utils/services/user_services.dart';
import 'package:mooover/utils/services/user_session_services.dart';

class UserInfoCubit extends Cubit<UserInfoState> {
  UserInfoCubit({UserInfoState initialState = const UserInfoNoState()})
      : super(initialState);

  /// This method is used to load the user info.
  Future<void> loadUserInfo() async {
    emit(const UserInfoLoadingState());
    try {
      User user =
          await UserServices().getUser(UserSessionServices().getUserId());
      emit(UserInfoLoadedState(user));
      log('User info loaded');
    } catch (e) {
      emit(UserInfoErrorState(e.toString()));
    }
  }

  /// This method is used to remove the user info.
  Future<void> removeUserInfo() async {
    emit(const UserInfoLoadingState());
    try {
      emit(const UserInfoNoState());
      log('User info removed');
    } catch (e) {
      emit(UserInfoErrorState(e.toString()));
    }
  }

  /// This method is used to change the daily steps goal.
  Future<void> changeDailyStepsGoal(int newDailyStepsGoal) async {
    emit(const UserInfoLoadingState());
    try {
      User user =
          await UserServices().getUser(UserSessionServices().getUserId());
      user.dailyStepsGoal = newDailyStepsGoal;
      await UserServices().updateUser(user);
      emit(UserInfoLoadedState(user));
      log('User daily steps goal changed');
    } catch (e) {
      emit(UserInfoErrorState(e.toString()));
    }
  }

  /// This method is used to change the weekly steps goal.
  Future<void> changeWeeklyStepsGoal(int newWeeklyStepsGoal) async {
    emit(const UserInfoLoadingState());
    try {
      User user =
      await UserServices().getUser(UserSessionServices().getUserId());
      user.weeklyStepsGoal = newWeeklyStepsGoal;
      await UserServices().updateUser(user);
      emit(UserInfoLoadedState(user));
      log('User weekly steps goal changed');
    } catch (e) {
      emit(UserInfoErrorState(e.toString()));
    }
  }
}
