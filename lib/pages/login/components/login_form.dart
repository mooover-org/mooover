import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mooover/utils/cubits/user_session/user_session_cubit.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Center(child: Text("Welcome!\nWe are happy to have you here.")),
        TextButton(
            onPressed: () => context.read<UserSessionCubit>().login(),
            child: const Text("Get started")),
      ],
    );
  }
}
