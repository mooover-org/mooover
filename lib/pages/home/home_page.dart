import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mooover/config/routes/routing.gr.dart';
import 'package:mooover/pages/home/components/dashboard.dart';
import 'package:mooover/utils/cubits/user_session/user_session_cubit.dart';
import 'package:mooover/utils/cubits/user_session/user_session_states.dart';
import 'package:mooover/utils/services/user_session_services.dart';

/// The home page.
///
/// This is the main page of the app.
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserSessionCubit, UserSessionState>(
        bloc: BlocProvider.of<UserSessionCubit>(context),
        listener: (context, state) {
          if (!UserSessionServices().isLoggedIn()) {
            context.router.pushNamed('/login');
          }
        },
        builder: (context, state) {
          if (state is UserSessionLoadingState) {
            return _getLoadingDisplay();
          } else if (state is UserSessionLoadingState) {
            return _getLoadingDisplay();
          } else if (state is UserSessionValidState) {
            return _getLoadedDisplay();
          } else if (state is UserSessionNoState) {
            context.router.pushNamed('/login');
            return _getErrorDisplay();
          } else {
            return _getErrorDisplay();
          }
        });
  }

  /// This method returns the display for the home page.
  Widget _getLoadedDisplay() {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("MOOOVER")),
      ),
      body: const Dashboard(),
    );
  }

  /// This method returns the display for the loading state.
  Widget _getLoadingDisplay() {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  /// This method returns the display for the error state.
  Widget _getErrorDisplay() {
    return const Scaffold(
      body: Center(
        child: Text(
            "Oops! Something went wrong.\nPlease restart the app or try again later. (Home)"),
      ),
    );
  }
}
