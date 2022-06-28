import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mooover/utils/cubits/group_steps/group_steps_cubit.dart';
import 'package:mooover/utils/cubits/group_steps/group_steps_states.dart';
import 'package:mooover/widgets/error_display.dart';
import 'package:mooover/widgets/loading_display.dart';
import 'package:percent_indicator/percent_indicator.dart';

class GroupTodayStepsIndicator extends StatelessWidget {
  final int dailyStepsGoal;

  const GroupTodayStepsIndicator({Key? key, required this.dailyStepsGoal})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupStepsCubit, GroupStepsState>(
      builder: (context, state) {
        if (state is GroupStepsLoadedState) {
          return CircularPercentIndicator(
            radius: 60,
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
            center: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                state.todaySteps.toString(),
                textAlign: TextAlign.center,
              ),
            ),
            progressColor: Theme.of(context).primaryColor,
            backgroundColor: Theme.of(context).backgroundColor,
            circularStrokeCap: CircularStrokeCap.round,
          );
        } else if (state is GroupStepsLoadingState) {
          return LoadingDisplay(message: state.message);
        } else if (state is GroupStepsErrorState) {
          return ErrorDisplay(message: state.message);
        } else {
          return const ErrorDisplay();
        }
      },
    );
  }
}
