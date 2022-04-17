import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mooover/config/routes/routing.gr.dart';
import 'package:mooover/pages/login/components/login_form.dart';
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
        if (state is UserSessionValidState) {
          context.router.replace(const HomePageRoute());
        }
      },
      builder: (_, state) {
        if (state is UserSessionNoState) {
          return _getLoginPageDisplay();
        } else if (state is UserSessionLoadingState ||
            state is UserSessionValidState) {
          return _getLoadingDisplay();
        } else {
          return _getErrorDisplay();
        }
      },
    );
  }

  /// This method returns the display for the login page.
  Widget _getLoginPageDisplay() {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("MOOOVER")),
      ),
      body: const LoginForm(),
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
