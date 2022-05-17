import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mooover/utils/cubits/user_session/user_session_cubit.dart';

/// LoginForm is the form that the user uses to login.
class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "Welcome!\nWe are happy to have you here.",
            textAlign: TextAlign.center,
          ),
          OutlinedButton(
              onPressed: () => context.read<UserSessionCubit>().login(),
              child: const Text(
                "Get started",
                textAlign: TextAlign.center,
              )),
        ],
      ),
    );
  }
}
