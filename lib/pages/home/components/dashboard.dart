import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mooover/utils/cubits/pedestrian_status/pedestrian_status_cubit.dart';
import 'package:mooover/utils/cubits/pedestrian_status/pedestrian_status_states.dart';
import 'package:mooover/utils/cubits/user_info/user_info_cubit.dart';
import 'package:mooover/utils/cubits/user_info/user_info_states.dart';
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
      child: BlocBuilder<UserInfoCubit, UserInfoState>(
        bloc: BlocProvider.of<UserInfoCubit>(context),
        builder: (context, state) {
          if (state is UserInfoLoadedState) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CircularPercentIndicator(
                  radius: 90,
                  lineWidth: 20,
                  percent: state.user.todaySteps <= state.user.dailyStepsGoal
                      ? state.user.todaySteps / state.user.dailyStepsGoal
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
                      BlocBuilder<PedestrianStatusCubit, PedestrianStatusState>(
                        bloc: BlocProvider.of<PedestrianStatusCubit>(context),
                        builder: (context, state) {
                          if (state is PedestrianStatusLoadedState) {
                            return Icon(
                              state.status,
                              size: 70,
                              color: Theme.of(context).textTheme.caption?.color,
                            );
                          } else if (state is PedestrianStatusLoadingState) {
                            return const LoadingDisplay(
                              transparent: true,
                              size: 28,
                            );
                          } else if (state is PedestrianStatusErrorState) {
                            return const ErrorDisplay(
                              message: "Error loading pedestrian status",
                              transparent: true,
                            );
                          } else {
                            return const ErrorDisplay(
                              transparent: true,
                            );
                          }
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          state.user.todaySteps.toString(),
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
                        percent: state.user.thisWeekSteps <=
                                state.user.weeklyStepsGoal
                            ? state.user.thisWeekSteps /
                                state.user.weeklyStepsGoal
                            : 1,
                        center: Text(
                          '${state.user.thisWeekSteps}',
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
          } else if (state is UserInfoLoadingState) {
            return const LoadingDisplay(
              transparent: true,
            );
          } else if (state is UserInfoErrorState) {
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
