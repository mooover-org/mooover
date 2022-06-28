import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mooover/utils/cubits/user_steps/user_steps_states.dart';
import 'package:mooover/utils/domain/observer.dart';
import 'package:mooover/utils/helpers/logger.dart';
import 'package:mooover/utils/services/steps_services.dart';
import 'package:mooover/utils/services/user_session_services.dart';

class UserStepsCubit extends Cubit<UserStepsState> implements Observer {
  UserStepsCubit(
      {initialState = const UserStepsErrorState('User steps unavailable')})
      : super(initialState) {
    loadUserSteps();
    StepsServices().addObserver(this);
  }

  @override
  Future<void> close() {
    StepsServices().removeObserver(this);
    return super.close();
  }

  @override
  void update() {
    reloadUserSteps();
  }

  Future<void> loadUserSteps() async {
    emit(const UserStepsLoadingState());
    logger.d('User steps state loading');
    try {
      final userSteps =
          await StepsServices().getUserSteps(UserSessionServices().getUserId());
      emit(UserStepsLoadedState(userSteps['today_steps'] as int,
          userSteps['this_week_steps'] as int));
      logger.d('User steps state loaded: $userSteps');
    } catch (e) {
      emit(UserStepsErrorState(e.toString()));
      logger.e('User steps state error: $e');
    }
  }

  Future<void> reloadUserSteps() async {
    logger.d('User steps state reloading');
    try {
      final userSteps =
          await StepsServices().getUserSteps(UserSessionServices().getUserId());
      emit(UserStepsLoadedState(userSteps['today_steps'] as int,
          userSteps['this_week_steps'] as int));
      logger.d('User steps state reloaded: $userSteps');
    } catch (e) {
      emit(UserStepsErrorState(e.toString()));
      logger.e('User steps state error: $e');
    }
  }
}
