import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mooover/utils/cubits/group_info/group_info_cubit.dart';
import 'package:mooover/utils/cubits/group_info/group_info_states.dart';
import 'package:mooover/widgets/error_display.dart';
import 'package:mooover/widgets/loading_display.dart';
import 'package:mooover/widgets/panel.dart';

class GroupInfo extends StatelessWidget {
  const GroupInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupInfoCubit, GroupInfoState>(
        bloc: BlocProvider.of<GroupInfoCubit>(context),
        builder: (context, state) {
          if (state is GroupInfoLoadedState) {
            return Panel(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      state.group.nickname,
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      state.group.name,
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "Daily steps: ${state.group.steps} / ${state.group.dailyStepsGoal}",
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "Weekly steps: ${state.group.steps} / ${state.group.weeklyStepsGoal}",
                      textAlign: TextAlign.center,
                    ),
                    OutlinedButton(
                      onPressed: () =>
                          BlocProvider.of<GroupInfoCubit>(context).leaveGroup(),
                      child: const Text('Leave'),
                    ),
                  ],
                ),
              ),
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
        });
  }
}
