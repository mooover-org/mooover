import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mooover/config/themes/theme_cubit.dart';
import 'package:mooover/config/themes/themes.dart';

/// The screen used for signing in, password resetting and other related
/// activities.
class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign in!"),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(onPressed: () {
                context.read<ThemeCubit>().changeTheme(appThemes[AppThemeName.light]!);
              }, child: const Text("Light theme")),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(onPressed: () {
                context.read<ThemeCubit>().changeTheme(appThemes[AppThemeName.dark]!);
              }, child: const Text("Dark theme")),
            ),
          ],
        ),
      ),
    );
  }
}
