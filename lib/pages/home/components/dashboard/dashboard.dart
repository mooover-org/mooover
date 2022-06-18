import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mooover/pages/home/components/dashboard/user_this_week_steps_indicator.dart';
import 'package:mooover/pages/home/components/dashboard/user_today_steps_indicator.dart';
import 'package:mooover/utils/cubits/user_info/user_info_cubit.dart';
import 'package:mooover/utils/cubits/user_info/user_info_states.dart';
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
      child: BlocBuilder<UserInfoCubit, UserInfoState>(
        builder: (context, state) {
          if (state is UserInfoLoadedState) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                UserTodayStepsIndicator(
                  dailyStepsGoal: state.dailyStepsGoal,
                ),
                UserThisWeekStepsIndicator(
                  weeklyStepsGoal: state.weeklyStepsGoal,
                ),
              ],
            );
          } else if (state is UserInfoLoadingState) {
            return LoadingDisplay(message: state.message);
          } else if (state is UserInfoErrorState) {
            return ErrorDisplay(message: state.message);
          } else {
            return const ErrorDisplay();
          }
        },
      ),
    );
  }
}
