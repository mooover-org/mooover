import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mooover/pages/home/components/leaderboard/leaderboard_list_tile.dart';
import 'package:mooover/utils/cubits/leaderboard/leaderboard_cubit.dart';
import 'package:mooover/utils/cubits/leaderboard/leaderboard_states.dart';
import 'package:mooover/widgets/error_display.dart';
import 'package:mooover/widgets/loading_display.dart';

/// This is the leaderboard component.
///
/// It is used to display the current groups standings in the weekly leaderboard.
class Leaderboard extends StatelessWidget {
  const Leaderboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LeaderboardCubit, LeaderboardState>(
      builder: (context, state) {
        if (state is LeaderboardLoadedState) {
          if (state.groups.isEmpty) {
            return const Center(
              child: Text('No groups to available'),
            );
          } else {
            return ListView.builder(
              itemCount: state.groups.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Leaderboard',
                      textAlign: TextAlign.center,
                    ),
                  );
                } else {
                  final leaderboardEntry = state.groups[index - 1];
                  return LeaderboardListTile(
                    id: leaderboardEntry.id,
                    name: leaderboardEntry.name,
                    nickname: leaderboardEntry.nickname,
                    thisWeekSteps: leaderboardEntry.thisWeekSteps,
                  );
                }
              },
            );
          }
        } else if (state is LeaderboardLoadingState) {
          return const LoadingDisplay();
        } else if (state is LeaderboardErrorState) {
          return ErrorDisplay(message: state.message);
        } else {
          return const ErrorDisplay();
        }
      },
    );
  }
}
