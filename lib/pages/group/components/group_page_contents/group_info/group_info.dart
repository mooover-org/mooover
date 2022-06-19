import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mooover/pages/group/components/group_page_contents/group_info/group_this_week_steps_indicator.dart';
import 'package:mooover/pages/group/components/group_page_contents/group_info/group_today_steps_indicator.dart';
import 'package:mooover/utils/cubits/group_info/group_info_cubit.dart';
import 'package:mooover/utils/cubits/group_info/group_info_states.dart';
import 'package:mooover/utils/cubits/group_steps/group_steps_cubit.dart';
import 'package:mooover/utils/cubits/membership/membership_cubit.dart';
import 'package:mooover/utils/helpers/logger.dart';
import 'package:mooover/widgets/error_display.dart';
import 'package:mooover/widgets/loading_display.dart';
import 'package:mooover/widgets/panel.dart';

class GroupInfo extends StatelessWidget {
  const GroupInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Panel(
      child: BlocBuilder<GroupInfoCubit, GroupInfoState>(
        builder: (context, state) {
          if (state is GroupInfoLoadedState) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
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
                              state.name,
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
                              state.nickname,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ),
                        ),
                      ],
                    ),
                    BlocProvider<GroupStepsCubit>(
                      create: (context) {
                        logger.d('Creating and providing group steps cubit');
                        return GroupStepsCubit();
                      },
                      child: GroupTodayStepsIndicator(
                        dailyStepsGoal: state.dailyStepsGoal,
                      ),
                    ),
                  ],
                ),
                BlocProvider<GroupStepsCubit>(
                  create: (context) {
                    logger.d('Creating and providing group steps cubit');
                    return GroupStepsCubit();
                  },
                  child: GroupThisWeekStepsIndicator(
                    weeklyStepsGoal: state.weeklyStepsGoal,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: OutlinedButton(
                    onPressed: () =>
                        BlocProvider.of<MembershipCubit>(context).leaveGroup(),
                    child: const Text('Leave'),
                  ),
                ),
              ],
            );
          } else if (state is GroupInfoLoadingState) {
            return const LoadingDisplay();
          } else if (state is GroupInfoErrorState) {
            return ErrorDisplay(message: state.message);
          } else {
            return const ErrorDisplay();
          }
        },
      ),
    );
  }
}
