import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mooover/utils/cubits/user_info/user_info_states.dart';
import 'package:mooover/utils/domain/user.dart';
import 'package:mooover/utils/services/user_services.dart';
import 'package:mooover/utils/services/user_session_services.dart';

class UserInfoCubit extends Cubit<UserInfoState> {
  UserInfoCubit(
      {UserInfoState initialState =
          const UserInfoErrorState('No user info available')})
      : super(initialState) {
    loadUserInfo();
  }

  /// This method is used to load the user info.
  Future<void> loadUserInfo() async {
    emit(const UserInfoLoadingState());
    try {
      User user =
          await UserServices().getUser(UserSessionServices().getUserId());
      emit(UserInfoLoadedState(
        user.name,
        user.givenName,
        user.familyName,
        user.nickname,
        user.email,
        user.picture,
        user.dailyStepsGoal,
        user.weeklyStepsGoal,
      ));
      log('User info loaded');
    } catch (e) {
      emit(UserInfoErrorState(e.toString()));
      log('User info error: $e');
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
      emit(UserInfoLoadedState(
        user.name,
        user.givenName,
        user.familyName,
        user.nickname,
        user.email,
        user.picture,
        user.dailyStepsGoal,
        user.weeklyStepsGoal,
      ));
      log('User daily steps goal changed');
    } catch (e) {
      emit(UserInfoErrorState(e.toString()));
      log('User info error: $e');
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
      emit(UserInfoLoadedState(
        user.name,
        user.givenName,
        user.familyName,
        user.nickname,
        user.email,
        user.picture,
        user.dailyStepsGoal,
        user.weeklyStepsGoal,
      ));
      log('User weekly steps goal changed');
    } catch (e) {
      emit(UserInfoErrorState(e.toString()));
      log('User info error: $e');
    }
  }
}
