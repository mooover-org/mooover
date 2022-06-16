import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mooover/utils/cubits/user_steps/user_steps_cubit.dart';
import 'package:mooover/utils/cubits/user_steps/user_steps_states.dart';
import 'package:mooover/widgets/error_display.dart';
import 'package:mooover/widgets/loading_display.dart';
import 'package:mooover/widgets/panel.dart';
import 'package:percent_indicator/percent_indicator.dart';

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
              children: [
                CircularPercentIndicator(
                  radius: 90,
                  lineWidth: 20,
                  percent: state.todaySteps <= state.dailyStepsGoal
                      ? state.todaySteps / state.dailyStepsGoal
                      : 1,
                  animation: true,
                  animateFromLastPercent: true,
                  header: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      "This Day's Steps",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ),
                  center: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        state.pedestrianStatus == "walking"
                            ? Icons.directions_walk
                            : state.pedestrianStatus == "stopped"
                                ? Icons.accessibility_new
                                : Icons.question_mark,
                        size: 70,
                        color: Theme.of(context).textTheme.caption?.color,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          state.todaySteps.toString(),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  progressColor: Theme.of(context).primaryColor,
                  backgroundColor: Theme.of(context).backgroundColor,
                  circularStrokeCap: CircularStrokeCap.round,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Text(
                    "This Week's Steps",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.caption,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width - 100,
                      child: LinearPercentIndicator(
                        width: MediaQuery.of(context).size.width - 100,
                        lineHeight: 20,
                        animation: true,
                        animateFromLastPercent: true,
                        percent: state.thisWeekSteps <= state.weeklyStepsGoal
                            ? state.thisWeekSteps / state.weeklyStepsGoal
                            : 1,
                        center: Text(
                          '${state.thisWeekSteps}',
                          textAlign: TextAlign.center,
                        ),
                        progressColor: Theme.of(context).primaryColor,
                        backgroundColor: Theme.of(context).backgroundColor,
                        barRadius: const Radius.circular(20),
                      ),
                    ),
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
