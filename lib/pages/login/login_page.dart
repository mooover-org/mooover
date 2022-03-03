import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mooover/config/routes/routing.gr.dart';
import 'package:mooover/utils/cubits/user_session/user_session_cubit.dart';
import 'package:mooover/utils/cubits/user_session/user_session_states.dart';

/// The login page
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
          return Scaffold(
            appBar: AppBar(
              title: const Center(child: Text("MOOOVER")),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Center(
                    child: Text("Welcome!\nWe are happy to have you here.")),
                TextButton(
                    onPressed: () => context.read<UserSessionCubit>().login(),
                    child: const Text("Get started")),
              ],
            ),
          );
        } else if (state is LoadingUserSessionState ||
            state is ValidUserSessionState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return const Center(
            child: Text("Something bad happened :/\n(login page)"),
          );
        }
      },
    );
  }
}
