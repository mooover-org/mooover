import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mooover/utils/cubits/user_session/user_session_cubit.dart';
import 'package:mooover/utils/domain/user.dart';
import 'package:mooover/utils/services/user_services.dart';
import 'package:mooover/utils/services/user_session_services.dart';

/// This is the dashboard component.
///
/// It is used to display the most important information about the user, such as
/// the steps counter and heart points counter.
class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: UserServices().getUser(UserSessionServices().idToken!.userId),
        builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
          if (snapshot.hasData) {
            return _getDashboardDisplay(context, snapshot.data!);
          } else {
            return _getLoadingDisplay();
          }
        });
  }

  /// This method returns the display for the dashboard.
  Widget _getDashboardDisplay(BuildContext context, User user) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
            child: CircleAvatar(backgroundImage: NetworkImage(user.picture))),
        Center(child: Text("Welcome " + user.givenName + "!")),
        TextButton(
            onPressed: () => context.read<UserSessionCubit>().logout(),
            child: const Text("Log out")),
      ],
    );
  }

  /// This method returns the display for the loading state.
  Widget _getLoadingDisplay() {
    return const Center(child: CircularProgressIndicator());
  }
}
