import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mooover/config/routes/routing.gr.dart';
import 'package:mooover/utils/cubits/dashboard/dashboard_cubit.dart';
import 'package:mooover/utils/cubits/theme/theme_cubit.dart';
import 'package:mooover/utils/cubits/theme/theme_states.dart';
import 'package:mooover/utils/cubits/user_session/user_session_cubit.dart';
import 'package:mooover/utils/helpers/app_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kDebugMode) {
    await AppConfig.loadForDevelopment();
  } else {
    await AppConfig.loadForProduction();
  }
  runApp(App());
}

/// The main application widget.
class App extends StatelessWidget {
  final _router = AppRouter();

  App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ThemeCubit(),
        ),
        BlocProvider(
          create: (_) => UserSessionCubit(),
        ),
        BlocProvider(
          create: (_) => DashboardCubit(),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (_, state) {
          return MaterialApp.router(
            title: 'Mooover',
            debugShowCheckedModeBanner: false,
            theme: state.themeData,
            routerDelegate: _router.delegate(),
            routeInformationParser: _router.defaultRouteParser(),
          );
        },
      ),
    );
  }
}
