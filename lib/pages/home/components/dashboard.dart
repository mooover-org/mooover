import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mooover/utils/cubits/dashboard/dashboard_cubit.dart';
import 'package:mooover/utils/cubits/dashboard/dashboard_states.dart';

/// This is the dashboard component.
///
/// It is used to display the most important information about the user, such as
/// the steps counter and heart points counter.
class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    BlocProvider.of<DashboardCubit>(context).loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardCubit, DashboardState>(
      bloc: context.read<DashboardCubit>(),
      builder: (_, state) {
        if (state is DashboardInitialState) {
          return _getLoadingDisplay();
        } else if (state is DashboardLoadingState) {
          return _getLoadingDisplay();
        } else if (state is DashboardLoadedState) {
          return _getLoadedDisplay(state);
        } else if (state is DashboardErrorState) {
          return _getErrorDisplay(state);
        } else {
          return _getErrorDisplay(null);
        }
      },
    );
  }

  /// This method returns the display for the dashboard.
  Widget _getLoadedDisplay(DashboardLoadedState state) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
          child: IconButton(
            iconSize: 100,
            icon: CircleAvatar(
              radius: 100,
              backgroundImage: NetworkImage(state.profilePicture),
            ),
            onPressed: () {
              context.router.pushNamed('/user_profile');
            },
          ),
        ),
        Center(
          child: Text(
            'Steps: ${state.steps}',
          ),
        ),
        Center(
          child: Text(
            'Heart Points: ${state.heartPoints}',
          ),
        ),
      ],
    );
  }

  /// This method returns the display for the loading state.
  Widget _getLoadingDisplay() {
    return const Center(child: CircularProgressIndicator());
  }

  /// This method returns the display for the error state.
  Widget _getErrorDisplay(DashboardErrorState? state) {
    String errorMessage = state?.errorMessage ?? "An error occurred";
    return Center(child: Text("Error: $errorMessage"));
  }
}
