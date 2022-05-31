import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mooover/utils/cubits/group_info/group_info_cubit.dart';
import 'package:mooover/utils/cubits/group_info/group_info_states.dart';
import 'package:mooover/utils/cubits/group_steps/group_steps_cubit.dart';
import 'package:mooover/utils/cubits/group_steps/group_steps_states.dart';
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
                    BlocBuilder<GroupStepsCubit, GroupStepsState>(
                        bloc: BlocProvider.of<GroupStepsCubit>(context),
                        builder: (context, state) {
                          if (state is GroupStepsLoadedState) {
                            return Text(
                              "Daily steps: ${state.todaySteps} / ${state.dailyStepsGoal}",
                              textAlign: TextAlign.center,
                            );
                          } else if (state is GroupStepsLoadingState) {
                            return const LoadingDisplay(
                              transparent: true,
                            );
                          } else if (state is GroupStepsErrorState) {
                            return ErrorDisplay(
                              message: state.message,
                              transparent: true,
                            );
                          } else {
                            return const ErrorDisplay(
                              transparent: true,
                            );
                          }
                        }),
                    BlocBuilder<GroupStepsCubit, GroupStepsState>(
                        bloc: BlocProvider.of<GroupStepsCubit>(context),
                        builder: (context, state) {
                          if (state is GroupStepsLoadedState) {
                            return Text(
                              "Weekly steps: ${state.thisWeekSteps} / ${state
                                  .weeklyStepsGoal}",
                              textAlign: TextAlign.center,
                            );
                          } else if (state is GroupStepsLoadingState) {
                            return const LoadingDisplay(
                              transparent: true,
                            );
                          } else if (state is GroupStepsErrorState) {
                            return ErrorDisplay(
                              message: state.message,
                              transparent: true,
                            );
                          } else {
                            return const ErrorDisplay(
                              transparent: true,
                            );
                          }
                        }),
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
