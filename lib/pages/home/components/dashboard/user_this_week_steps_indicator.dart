import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mooover/utils/cubits/steps_info/user_steps_cubit.dart';
import 'package:mooover/utils/cubits/steps_info/user_steps_states.dart';
import 'package:mooover/widgets/error_display.dart';
import 'package:mooover/widgets/loading_display.dart';
import 'package:percent_indicator/percent_indicator.dart';

class UserThisWeekStepsIndicator extends StatelessWidget {
  final int weeklyStepsGoal;

  const UserThisWeekStepsIndicator({Key? key, required this.weeklyStepsGoal})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 5.0, left: 5.0, right: 5.0),
          child: Text(
            "This Week's Steps",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.caption,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: BlocBuilder<UserStepsCubit, UserStepsState>(
            builder: (context, state) {
              if (state is UserStepsLoadedState) {
                return SizedBox(
                  width: MediaQuery.of(context).size.width - 100,
                  child: LinearPercentIndicator(
                    width: MediaQuery.of(context).size.width - 100,
                    lineHeight: 20,
                    animation: true,
                    animateFromLastPercent: true,
                    percent: state.thisWeekSteps <= weeklyStepsGoal
                        ? state.thisWeekSteps / weeklyStepsGoal
                        : 1,
                    center: Text(
                      '${state.thisWeekSteps}',
                      textAlign: TextAlign.center,
                    ),
                    progressColor: Theme.of(context).primaryColor,
                    backgroundColor: Theme.of(context).backgroundColor,
                    barRadius: const Radius.circular(20),
                  ),
                );
              } else if (state is UserStepsLoadingState) {
                return LoadingDisplay(message: state.message);
              } else if (state is UserStepsErrorState) {
                return ErrorDisplay(message: state.message);
              } else {
                return const ErrorDisplay();
              }
            },
          ),
        ),
      ],
    );
  }
}
