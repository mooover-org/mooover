import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mooover/config/routes/routing.gr.dart';
import 'package:mooover/config/themes/themes.dart';
import 'package:mooover/utils/cubits/user_session/user_session_cubit.dart';
import 'package:mooover/utils/helpers/app_config.dart';
import 'package:mooover/utils/helpers/logger.dart';

import 'utils/cubits/app_theme/app_theme_cubit.dart';
import 'utils/cubits/app_theme/app_theme_states.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  logger.d('Widget binding initialized');
  if (kDebugMode) {
    await AppConfig.loadForDevelopment();
    logger.d('AppConfig loaded for development');
  } else {
    await AppConfig.loadForProduction();
    logger.d('AppConfig loaded for production');
  }
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  logger.d('SystemChrome set to portrait');
  logger.i('Starting app');
  runApp(App());
}

/// The main application widget.
class App extends StatelessWidget {
  final _router = AppRouter();
  final _appThemeCubit = AppThemeCubit();

  App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            logger.d('Providing app theme cubit');
            return _appThemeCubit;
          },
        ),
        BlocProvider(
          create: (context) {
            logger.d('Creating and providing user session cubit');
            return UserSessionCubit();
          },
        ),
      ],
      child: BlocBuilder<AppThemeCubit, AppThemeState>(
        bloc: _appThemeCubit,
        builder: (context, state) {
          return MaterialApp.router(
            title: 'Mooover',
            debugShowCheckedModeBanner: false,
            theme: appThemes[
                state is AppThemeLoadedState ? state.appTheme : AppTheme.light],
            routerDelegate: _router.delegate(),
            routeInformationParser: _router.defaultRouteParser(),
          );
        },
      ),
    );
  }
}
