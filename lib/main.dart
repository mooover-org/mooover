import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mooover/config/routes/routing.gr.dart';
import 'package:mooover/config/themes/themes.dart';
import 'package:mooover/utils/cubits/app_settings/app_settings_cubit.dart';
import 'package:mooover/utils/cubits/app_settings/app_settings_states.dart';
import 'package:mooover/utils/cubits/user_session/user_session_cubit.dart';
import 'package:mooover/utils/helpers/app_config.dart';
import 'package:mooover/widgets/error_display.dart';

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
          create: (_) => AppSettingsCubit(),
        ),
        BlocProvider(
          create: (_) => UserSessionCubit(),
        ),
      ],
      child: BlocBuilder<AppSettingsCubit, AppSettingsState>(
        builder: (context, state) {
          if (state is AppSettingsInitialState) {
            return _getLoadedApp(state);
          } else if (state is AppSettingsLoadingState) {
            return _getLoadingApp();
          } else if (state is AppSettingsLoadedState) {
            return _getLoadedApp(state);
          } else if (state is AppSettingsErrorState) {
            return _getErrorApp();
          } else {
            return _getErrorApp();
          }
        },
      ),
    );
  }

  /// Returns the loading app.
  MaterialApp _getLoadingApp() {
    return MaterialApp.router(
      title: 'Mooover',
      debugShowCheckedModeBanner: false,
      theme: appThemes[AppTheme.light],
      routerDelegate: _router.delegate(),
      routeInformationParser: _router.defaultRouteParser(),
    );
  }

  /// Returns the loaded app.
  MaterialApp _getLoadedApp(AppSettingsLoadedState state) {
    return MaterialApp.router(
      title: 'Mooover',
      debugShowCheckedModeBanner: false,
      theme: appThemes[state.appTheme],
      routerDelegate: _router.delegate(),
      routeInformationParser: _router.defaultRouteParser(),
    );
  }

  /// Returns the error app.
  MaterialApp _getErrorApp() {
    return MaterialApp(
        title: 'Mooover',
        debugShowCheckedModeBanner: false,
        theme: appThemes[AppTheme.light],
        home: const ErrorDisplay());
  }
}
