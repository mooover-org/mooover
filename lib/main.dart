import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mooover/config/routes/routing.gr.dart';
import 'package:mooover/config/themes/theme_cubit.dart';
import 'package:mooover/config/themes/theme_state.dart';
import 'package:mooover/screens/sign_in_screen.dart';

void main() {
  runApp(App());
}

/// The main application class.
///
/// It builds the theme and the [SignInScreen].
class App extends StatelessWidget {
  final _router = AppRouter();

  App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => ThemeCubit(),
        child: BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, themeState) => MaterialApp.router(
            title: 'Mooover',
            debugShowCheckedModeBanner: false,
            theme: themeState.themeData,
            routerDelegate: _router.delegate(),
            routeInformationParser: _router.defaultRouteParser(),
          ),
        ));
  }
}
