import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mooover/utils/cubits/group_info/group_info_cubit.dart';
import 'package:mooover/utils/cubits/group_info/group_info_states.dart';
import 'package:mooover/widgets/error_display.dart';
import 'package:mooover/widgets/loading_display.dart';
import 'package:mooover/widgets/panel.dart';
import 'package:percent_indicator/percent_indicator.dart';

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
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: SizedBox(
                                width: 175,
                                child: Text(
                                  state.group.name,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.headlineSmall,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: SizedBox(
                                width: 175,
                                child: Text(
                                  state.group.nickname,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ),
                            ),
                          ],
                        ),
                        CircularPercentIndicator(
                          radius: 60,
                          lineWidth: 20,
                          percent: state.group.todaySteps <=
                              state.group.dailyStepsGoal
                              ? state.group.todaySteps / state.group.dailyStepsGoal
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
                              state.group.todaySteps.toString(),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          progressColor: Theme.of(context).primaryColor,
                          backgroundColor: Theme.of(context).backgroundColor,
                          circularStrokeCap: CircularStrokeCap.round,
                        ),
                      ],
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
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width - 100,
                        child: LinearPercentIndicator(
                          width: MediaQuery.of(context).size.width - 100,
                          lineHeight: 20,
                          animation: true,
                          animateFromLastPercent: true,
                          percent: state.group.thisWeekSteps <=
                                  state.group.weeklyStepsGoal
                              ? state.group.thisWeekSteps /
                                  state.group.weeklyStepsGoal
                              : 1,
                          center: Text(
                            '${state.group.thisWeekSteps}',
                            textAlign: TextAlign.center,
                          ),
                          progressColor: Theme.of(context).primaryColor,
                          backgroundColor: Theme.of(context).backgroundColor,
                          barRadius: const Radius.circular(20),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: OutlinedButton(
                        onPressed: () =>
                            BlocProvider.of<GroupInfoCubit>(context).leaveGroup(),
                        child: const Text('Leave'),
                      ),
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
