import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mooover/config/routes/routing.gr.dart';
import 'package:mooover/config/themes/themes.dart';
import 'package:mooover/utils/cubits/group_info/group_info_cubit.dart';
import 'package:mooover/utils/cubits/leaderboard/leaderboard_cubit.dart';
import 'package:mooover/utils/cubits/pedestrian_status/pedestrian_status_cubit.dart';
import 'package:mooover/utils/cubits/user_info/user_info_cubit.dart';
import 'package:mooover/utils/cubits/user_session/user_session_cubit.dart';
import 'package:mooover/utils/cubits/user_session/user_session_states.dart';
import 'package:mooover/utils/domain/initializable.dart';
import 'package:mooover/utils/helpers/app_config.dart';

import 'utils/cubits/app_theme/app_theme_cubit.dart';
import 'utils/cubits/app_theme/app_theme_states.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kDebugMode) {
    await AppConfig.loadForDevelopment();
  } else {
    await AppConfig.loadForProduction();
  }
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(App());
}

/// The main application widget.
class App extends StatelessWidget {
  final _router = AppRouter();
  final _appThemeCubit = AppThemeCubit();
  final _leaderboardCubit = LeaderboardCubit();
  final _userInfoCubit = UserInfoCubit();
  final _groupInfoCubit = GroupInfoCubit();
  final _userSessionCubit = UserSessionCubit();
  final _pedestrianStatusCubit = PedestrianStatusCubit();

  App({Key? key}) : super(key: key) {
    _userSessionCubit.cubits = <Initializable>[
      _appThemeCubit,
      _leaderboardCubit,
      _userInfoCubit,
      _groupInfoCubit,
    ];
    _userSessionCubit.initialize();
    _runFast();
    _runSlow();
  }

  Future<void> _runFast() async {
    while (true) {
      await Future.delayed(Duration(seconds: AppConfig().stepsUpdateInterval));
      if (_userSessionCubit.state is UserSessionLoadedState) {
        _pedestrianStatusCubit.hotReload();
      }
    }
  }

  Future<void> _runSlow() async {
    while (true) {
      await Future.delayed(Duration(seconds: AppConfig().stepsUpdateInterval
          * 2));
      if (_userSessionCubit.state is UserSessionLoadedState) {
        _userInfoCubit.hotReload();
        _groupInfoCubit.hotReload();
        _leaderboardCubit.hotReload();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => _appThemeCubit,
        ),
        BlocProvider(
          create: (context) => _leaderboardCubit,
        ),
        BlocProvider(
          create: (context) => _userInfoCubit,
        ),
        BlocProvider(
          create: (context) => _groupInfoCubit,
        ),
        BlocProvider(
          create: (context) => _userSessionCubit,
        ),
        BlocProvider(
          create: (context) => _pedestrianStatusCubit,
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
