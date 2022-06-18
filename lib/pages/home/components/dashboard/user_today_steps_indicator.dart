import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mooover/pages/home/components/dashboard/pedestrian_status_icon.dart';
import 'package:mooover/utils/cubits/pedestrian_status/pedestrian_status_cubit.dart';
import 'package:mooover/utils/cubits/steps_info/user_steps_cubit.dart';
import 'package:mooover/utils/cubits/steps_info/user_steps_states.dart';
import 'package:mooover/utils/helpers/logger.dart';
import 'package:mooover/widgets/error_display.dart';
import 'package:mooover/widgets/loading_display.dart';
import 'package:percent_indicator/percent_indicator.dart';

class UserTodayStepsIndicator extends StatelessWidget {
  final int dailyStepsGoal;

  const UserTodayStepsIndicator({Key? key, required this.dailyStepsGoal})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserStepsCubit, UserStepsState>(
      builder: (context, state) {
        if (state is UserStepsLoadedState) {
          return CircularPercentIndicator(
            radius: 90,
            lineWidth: 20,
            percent: state.todaySteps <= dailyStepsGoal
                ? state.todaySteps / dailyStepsGoal
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
                BlocProvider<PedestrianStatusCubit>(
                    create: (context) {
                      logger
                          .d('Creating and providing pedestrian status cubit');
                      return PedestrianStatusCubit();
                    },
                    child: const PedestrianStatusIcon()),
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
          );
        } else if (state is UserStepsLoadingState) {
          return LoadingDisplay(message: state.message);
        } else if (state is UserStepsErrorState) {
          return ErrorDisplay(message: state.message);
        } else {
          return const ErrorDisplay();
        }
      },
    );
  }
}
