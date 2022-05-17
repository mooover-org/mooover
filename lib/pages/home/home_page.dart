import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mooover/pages/home/components/dashboard.dart';
import 'package:mooover/utils/cubits/user_session/user_session_cubit.dart';
import 'package:mooover/utils/cubits/user_session/user_session_states.dart';
import 'package:mooover/widgets/error_display.dart';
import 'package:mooover/widgets/loading_display.dart';

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
          log('HomePage: listener: state is $state');
          if (state is UserSessionNoState) {
            log('HomePage: listener: not logged in');
            context.router.pushNamed('/login');
            log('HomePage: listener: pushed login');
          }
        },
        builder: (context, state) {
          if (state is UserSessionInitialState) {
            return const LoadingDisplay();
          } else if (state is UserSessionLoadingState) {
            return const LoadingDisplay();
          } else if (state is UserSessionValidState) {
            return _getLoadedDisplay();
          } else if (state is UserSessionNoState) {
            return const ErrorDisplay(
              message: 'You are not logged in.',
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
        title: const Text("Mooover!"),
        centerTitle: true,
      ),
      body: const Dashboard(),
    );
  }
}
