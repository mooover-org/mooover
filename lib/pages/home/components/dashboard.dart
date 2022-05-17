import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mooover/utils/cubits/dashboard/dashboard_cubit.dart';
import 'package:mooover/utils/cubits/dashboard/dashboard_states.dart';
import 'package:mooover/widgets/error_display.dart';
import 'package:mooover/widgets/loading_display.dart';

/// This is the dashboard component.
///
/// It is used to display the most important information about the user, such as
/// the steps counter and heart points counter.
class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardCubit, DashboardState>(
      bloc: DashboardCubit(),
      builder: (context, state) {
        if (state is DashboardInitialState) {
          return const LoadingDisplay();
        } else if (state is DashboardLoadingState) {
          return const LoadingDisplay();
        } else if (state is DashboardLoadedState) {
          return _getLoadedDisplay(context, state);
        } else if (state is DashboardErrorState) {
          return ErrorDisplay(message: state.errorMessage);
        } else {
          return const ErrorDisplay();
        }
      },
    );
  }

  /// This method returns the display for the dashboard.
  Widget _getLoadedDisplay(BuildContext context, DashboardLoadedState state) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          IconButton(
            iconSize: 100,
            icon: CircleAvatar(
              radius: 100,
              backgroundImage: NetworkImage(state.profilePicture),
            ),
            onPressed: () {
              context.router.pushNamed('/user_profile');
            },
          ),
          Text(
            'Steps: ${state.steps}',
            textAlign: TextAlign.center,
          ),
          Text(
            'Heart Points: ${state.heartPoints}',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
