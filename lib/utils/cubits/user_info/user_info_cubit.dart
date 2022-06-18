import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mooover/utils/cubits/user_info/user_info_states.dart';
import 'package:mooover/utils/domain/user.dart';
import 'package:mooover/utils/helpers/logger.dart';
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
    logger.d('User info state loading');
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
      logger.d('User info state loaded: $user');
    } catch (e) {
      emit(UserInfoErrorState(e.toString()));
      logger.e('User info state error: $e');
    }
  }

  /// This method is used to change the daily steps goal.
  Future<void> changeDailyStepsGoal(int newDailyStepsGoal) async {
    emit(const UserInfoLoadingState());
    logger.d('User daily steps goal state loading');
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
      logger.d('User daily steps goal state changed: $newDailyStepsGoal');
    } catch (e) {
      emit(UserInfoErrorState(e.toString()));
      logger.e('User daily steps goal state error: $e');
    }
  }

  /// This method is used to change the weekly steps goal.
  Future<void> changeWeeklyStepsGoal(int newWeeklyStepsGoal) async {
    emit(const UserInfoLoadingState());
    logger.d('User weekly steps goal state loading');
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
      logger.d('User weekly steps goal state changed: $newWeeklyStepsGoal');
    } catch (e) {
      emit(UserInfoErrorState(e.toString()));
      logger.e('User weekly steps goal state error: $e');
    }
  }
}
