import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mooover/utils/cubits/leaderboard/leaderboard_states.dart';
import 'package:mooover/utils/domain/group.dart';
import 'package:mooover/utils/domain/initializable.dart';
import 'package:mooover/utils/domain/observer.dart';
import 'package:mooover/utils/services/group_services.dart';
import 'package:mooover/utils/services/user_services.dart';
import 'package:mooover/utils/services/user_session_services.dart';

class LeaderboardCubit extends Cubit<LeaderboardState>
    implements Initializable, Observer {
  LeaderboardCubit({initialState = const LeaderboardLoadedState([])})
      : super(initialState);

  @override
  Future<void> initialize() async {
    await load();
  }

  @override
  Future<void> dispose() async {
    emit(const LeaderboardErrorState('Leaderboard unavailable'));
  }

  @override
  void update() {
    hotReload();
  }

  /// Performs a leaderboard loading action.
  Future<void> load() async {
    emit(const LeaderboardLoadingState());
    try {
      List<Group> groups =
          await GroupServices().getGroups(orderedBySteps: true);
      if (groups.isEmpty) {
        emit(const LeaderboardErrorState('No groups to show'));
        log('No groups to show');
      } else {
        Group? group = await UserServices()
            .getGroupOfUser(UserSessionServices().getUserId());
        if (group == null) {
          emit(LeaderboardLoadedState(groups));
          log('Leaderboard loaded: ${groups.map((g) => g.thisWeekSteps)}');
        } else {
          emit(LeaderboardMembershipState(groups, group));
          log('Leaderboard loaded with membership: ${groups.map((g) => g.thisWeekSteps)}');
        }
      }
    } catch (e) {
      emit(LeaderboardErrorState(e.toString()));
      log('Leaderboard error: $e');
    }
  }

  /// Performs a leaderboard hot reloading action (no loading prompt).
  Future<void> hotReload() async {
    try {
      List<Group> groups =
          await GroupServices().getGroups(orderedBySteps: true);
      if (groups.isEmpty) {
        emit(const LeaderboardErrorState('No groups to show'));
        log('No groups to show');
      } else {
        Group? group = await UserServices()
            .getGroupOfUser(UserSessionServices().getUserId());
        if (group == null) {
          emit(LeaderboardLoadedState(groups));
          log('Leaderboard hot reloaded loaded: ${groups.map((g) => g.thisWeekSteps)}');
        } else {
          emit(LeaderboardMembershipState(groups, group));
          log('Leaderboard hot reloaded with membership: ${groups.map((g) => g.thisWeekSteps)}');
        }
      }
    } catch (e) {
      log('Leaderboard error: $e');
    }
  }
}
