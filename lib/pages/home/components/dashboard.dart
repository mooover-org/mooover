import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mooover/utils/cubits/user_steps/user_steps_cubit.dart';
import 'package:mooover/utils/cubits/user_steps/user_steps_states.dart';
import 'package:mooover/widgets/error_display.dart';
import 'package:mooover/widgets/loading_display.dart';
import 'package:mooover/widgets/panel.dart';

/// This is the dashboard component.
///
/// It is used to display the most important information about the user, such as
/// the steps counter.
class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Panel(
      child: BlocBuilder<UserStepsCubit, UserStepsState>(
        bloc: BlocProvider.of<UserStepsCubit>(context),
        builder: (context, state) {
          if (state is UserStepsLoadedState) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Daily steps: ${state.todaySteps} / ${state.dailyStepsGoal}.',
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Weekly steps: ${state.thisWeekSteps} / ${state.weeklyStepsGoal}.',
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Pedestrian Status: ${state.pedestrianStatus}.',
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            );
          } else if (state is UserStepsLoadingState) {
            return const LoadingDisplay(
              transparent: true,
            );
          } else if (state is UserStepsErrorState) {
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
      ),
    );
  }
}
