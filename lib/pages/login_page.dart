import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mooover/utils/cubits/user_session/user_session_cubit.dart';
import 'package:mooover/utils/cubits/user_session/user_session_states.dart';

/// The screen used for logging in, password resetting and other related
/// activities.
class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
          future: context.read<UserSessionCubit>().refreshPastSession(),
          builder: (_, __) {
            if (context.read<UserSessionCubit>().state
                is ValidUserSessionState) {
              context.router.pushNamed("/hub-page");
            } else if (context.read<UserSessionCubit>().state
                    is NoUserSessionState ||
                context.read<UserSessionCubit>().state
                    is InvalidUserSessionState) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Welcome to MOOOVER!"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                          onPressed: () async {
                            await context.read<UserSessionCubit>().loginAction();
                            if (context.read<UserSessionCubit>().state is ValidUserSessionState) {
                              context.router.pushNamed("/hub-page");
                            }
                          },
                          child: const Text("Get Started!")),
                    ),
                  ],
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }
}
