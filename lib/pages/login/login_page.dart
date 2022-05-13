import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mooover/pages/login/components/login_form.dart';
import 'package:mooover/utils/cubits/user_session/user_session_cubit.dart';
import 'package:mooover/utils/cubits/user_session/user_session_states.dart';
import 'package:mooover/widgets/error_display.dart';
import 'package:mooover/widgets/loading_display.dart';

/// The login page.
///
/// Page used for logging in, password resetting and other related
/// activities.
class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserSessionCubit, UserSessionState>(
        bloc: BlocProvider.of<UserSessionCubit>(context),
        listener: (context, state) {
          log('LoginPage: listener: state is $state');
          if (state is UserSessionValidState) {
            log('LoginPage: listener: logged in');
            context.router.pop();
            log('LoginPage: listener: popped');
          }
        },
        builder: (context, state) {
          if (state is UserSessionInitialState) {
            return const LoadingDisplay();
          } else if (state is UserSessionLoadingState) {
            return const LoadingDisplay();
          } else if (state is UserSessionNoState) {
            return _getLoadedDisplay();
          } else if (state is UserSessionValidState) {
            return const ErrorDisplay(
              message: 'You are already logged in.',
            );
          } else {
            return const ErrorDisplay();
          }
        });
  }

  /// Returns the loaded display.
  Widget _getLoadedDisplay() {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: const Text(
          "Hello!",
          textAlign: TextAlign.center,
        ),
        actions: const [],
      ),
      body: const LoginForm(),
    );
  }
}
