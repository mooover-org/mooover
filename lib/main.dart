import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mooover/config/themes/theme_cubit.dart';
import 'package:mooover/config/themes/theme_state.dart';
import 'package:mooover/screens/sign_in_screen.dart';

void main() {
  runApp(const App());
}

/// The main application class.
///
/// It builds the theme and the [SignInScreen].
class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => ThemeCubit(),
        child: BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, themeState) => MaterialApp(
            title: 'Mooover',
            debugShowCheckedModeBanner: false,
            theme: themeState.themeData,
            home: const SignInScreen(),
          ),
        ));
  }
}
