import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mooover/utils/cubits/group_info/group_info_cubit.dart';
import 'package:mooover/utils/cubits/group_info/group_info_states.dart';
import 'package:mooover/widgets/error_display.dart';
import 'package:mooover/widgets/loading_display.dart';
import 'package:mooover/widgets/panel.dart';

/// This is the leaderboard component.
///
/// It is used to display the current groups standings in the weekly leaderboard.
class Leaderboard extends StatelessWidget {
  const Leaderboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupInfoCubit, GroupInfoState>(
      bloc: BlocProvider.of<GroupInfoCubit>(context),
      builder: (context, state) {
        if (state is GroupInfoLoadedState) {
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
                return Panel(
                  child: ListTile(
                    title: Text(
                      leaderboardEntry.name,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      leaderboardEntry.nickname,
                      overflow: TextOverflow.ellipsis,
                    ),
                    leading: const Icon(
                      Icons.group,
                      size: 50,
                    ),
                    trailing: Text(
                        "Steps: ${leaderboardEntry.thisWeekSteps.toString()}"),
                    textColor: leaderboardEntry.id == state.group.id
                        ? Theme.of(context).accentColor
                        : null,
                  ),
                );
              }
            },
          );
        } else if (state is GroupInfoNoState) {
          return state.groups.isEmpty
              ? const Center(
                  child: Text('No groups available'),
                )
              : ListView.builder(
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
                      return Panel(
                        child: ListTile(
                          title: Text(
                            leaderboardEntry.name,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Text(
                            leaderboardEntry.nickname,
                            overflow: TextOverflow.ellipsis,
                          ),
                          leading: const Icon(
                            Icons.group,
                            size: 50,
                          ),
                          trailing: Text(
                              "Steps: ${leaderboardEntry.thisWeekSteps.toString()}"),
                        ),
                      );
                    }
                  },
                );
        } else if (state is GroupInfoLoadingState) {
          return const LoadingDisplay(
            transparent: true,
          );
        } else if (state is GroupInfoErrorState) {
          return ErrorDisplay(
            message: state.message,
            transparent: true,
          );
        } else {
          return const ErrorDisplay(
            transparent: true,
          );
        }
      },
    );
  }
}
