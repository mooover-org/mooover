import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mooover/config/routes/routing.dart';
import 'package:mooover/config/routes/routing.gr.dart';
import 'package:mooover/config/themes/theme_cubit.dart';
import 'package:mooover/config/themes/theme_state.dart';
import 'package:mooover/pages/sign_in_page.dart';

void main() {
  runApp(App());
}

/// The main application class.
///
/// It builds the theme and the [AppRouter].
class App extends StatelessWidget {
  final _router = AppRouter();
  final AppRouteObserver? routeObserver;

  App({Key? key, this.routeObserver}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => ThemeCubit(),
        child: BlocBuilder<ThemeCubit, ThemeState>(
          // builder: (context, themeState) => MaterialApp(
          //   title: 'Mooover',
          //   debugShowCheckedModeBanner: false,
          //   theme: themeState.themeData,
          //   home: const SignInPage(),
          // ),
          builder: (context, themeState) => MaterialApp.router(
            title: 'Mooover',
            debugShowCheckedModeBanner: false,
            theme: themeState.themeData,
            routerDelegate: AutoRouterDelegate(_router, navigatorObservers: () {
              if (routeObserver == null) {
                return [AppRouteObserver()];
              }
              return [routeObserver!];
            }),
            routeInformationParser: _router.defaultRouteParser(),
          ),
        ));
  }
}
