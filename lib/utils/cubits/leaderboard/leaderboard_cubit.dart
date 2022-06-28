import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mooover/utils/cubits/leaderboard/leaderboard_states.dart';
import 'package:mooover/utils/domain/group.dart';
import 'package:mooover/utils/domain/observer.dart';
import 'package:mooover/utils/helpers/logger.dart';
import 'package:mooover/utils/services/group_services.dart';

class LeaderboardCubit extends Cubit<LeaderboardState> implements Observer {
  LeaderboardCubit({initialState = const LeaderboardLoadedState([])})
      : super(initialState) {
    loadLeaderboard();
    GroupServices().addObserver(this);
  }

  @override
  Future<void> close() {
    GroupServices().removeObserver(this);
    return super.close();
  }

  @override
  void update() {
    reloadLeaderboard();
  }

  /// Performs a leaderboard loading action.
  Future<void> loadLeaderboard() async {
    emit(const LeaderboardLoadingState());
    logger.d('Leaderboard state loading');
    try {
      List<Group> groups =
          await GroupServices().getGroups(orderedBySteps: true);
      if (groups.isEmpty) {
        emit(const LeaderboardErrorState('No groups to show'));
        logger.d('Leaderboard state loaded: No groups to show');
      } else {
        emit(LeaderboardLoadedState(groups));
        logger.d('Leaderboard state loaded: $groups');
      }
    } catch (e) {
      emit(LeaderboardErrorState(e.toString()));
      logger.e('Leaderboard state error: $e');
    }
  }

  /// Performs a leaderboard reloading action.
  Future<void> reloadLeaderboard() async {
    logger.d('Leaderboard state reloading');
    try {
      List<Group> groups =
      await GroupServices().getGroups(orderedBySteps: true);
      if (groups.isEmpty) {
        emit(const LeaderboardErrorState('No groups to show'));
        logger.d('Leaderboard state reloaded: No groups to show');
      } else {
        emit(LeaderboardLoadedState(groups));
        logger.d('Leaderboard state reloaded: $groups');
      }
    } catch (e) {
      emit(LeaderboardErrorState(e.toString()));
      logger.e('Leaderboard state error: $e');
    }
  }
}
