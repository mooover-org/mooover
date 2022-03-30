import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mooover/config/routes/routing.gr.dart';
import 'package:mooover/utils/cubits/user_session/user_session_cubit.dart';
import 'package:mooover/utils/cubits/user_session/user_session_states.dart';

/// The login page.
///
/// Page used for logging in, password resetting and other related
/// activities.
class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserSessionCubit, UserSessionState>(
      listener: (_, state) {
        if (state is ValidUserSessionState) {
          context.router.replace(const HomePageRoute());
        }
      },
      builder: (_, state) {
        if (state is NoUserSessionState) {
          return _getLoginPageDisplay(context);
        } else if (state is LoadingUserSessionState ||
            state is ValidUserSessionState) {
          return _getLoadingDisplay();
        } else {
          return _getErrorDisplay();
        }
      },
    );
  }

  /// This method returns the display for the login page.
  Widget _getLoginPageDisplay(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("MOOOVER")),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Center(child: Text("Welcome!\nWe are happy to have you here.")),
          TextButton(
              onPressed: () => context.read<UserSessionCubit>().login(),
              child: const Text("Get started")),
        ],
      ),
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
            "Oops! Something went wrong.\nPlease restart the app or try again later."),
      ),
    );
  }
}
