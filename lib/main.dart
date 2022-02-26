import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mooover/config/routes/routing.gr.dart';
import 'package:mooover/utils/cubits/theme/theme_cubit.dart';
import 'package:mooover/utils/cubits/theme/theme_states.dart';
import 'package:mooover/utils/cubits/user_session/user_session_cubit.dart';
import 'package:mooover/utils/cubits/user_session/user_session_states.dart';

void main() {
  runApp(App());
}

/// The main application class.
///
/// It builds the theme and the [AppRouter].
class App extends StatelessWidget {
  final _router = AppRouter();

  App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => ThemeCubit(InitialThemeState())),
          BlocProvider(
              create: (_) => UserSessionCubit(LoadingUserSessionState())),
        ],
        child: BlocBuilder<ThemeCubit, ThemeState>(
          builder: (_, themeState) => MaterialApp.router(
            title: 'Mooover',
            debugShowCheckedModeBanner: false,
            theme: themeState.themeData,
            routerDelegate: _router.delegate(),
            routeInformationParser: _router.defaultRouteParser(),
          ),
        ));
  }
}
