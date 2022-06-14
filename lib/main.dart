import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mooover/config/routes/routing.gr.dart';
import 'package:mooover/config/themes/themes.dart';
import 'package:mooover/utils/cubits/group_info/group_info_cubit.dart';
import 'package:mooover/utils/cubits/group_steps/group_steps_cubit.dart';
import 'package:mooover/utils/cubits/user_info/user_info_cubit.dart';
import 'package:mooover/utils/cubits/user_session/user_session_cubit.dart';
import 'package:mooover/utils/cubits/user_steps/user_steps_cubit.dart';
import 'package:mooover/utils/helpers/app_config.dart';
import 'package:mooover/utils/services/steps_services.dart';

import 'utils/cubits/app_theme/app_theme_cubit.dart';
import 'utils/cubits/app_theme/app_theme_states.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kDebugMode) {
    await AppConfig.loadForDevelopment();
  } else {
    await AppConfig.loadForProduction();
  }
  runApp(const App());
}

/// The main application widget.
class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final _router = AppRouter();
  final _appThemeCubit = AppThemeCubit();
  final _userStepsCubit = UserStepsCubit();
  final _groupStepsCubit = GroupStepsCubit();

  @override
  void initState() {
    super.initState();
    StepsServices(hotReloadCallback: () {
      _userStepsCubit.hotReloadStepsData();
      _groupStepsCubit.hotReloadStepsData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => UserSessionCubit(),
        ),
        BlocProvider(
          create: (_) => UserInfoCubit(),
        ),
        BlocProvider(
          create: (_) => _userStepsCubit,
        ),
        BlocProvider(
          create: (_) => GroupInfoCubit(),
        ),
        BlocProvider(
          create: (_) => _groupStepsCubit,
        ),
        BlocProvider(
          create: (_) => _appThemeCubit,
        ),
      ],
      child: BlocBuilder<AppThemeCubit, AppThemeState>(
        bloc: _appThemeCubit,
        builder: (context, state) {
          if (state is AppThemeLoadedState) {
            return MaterialApp.router(
              title: 'Mooover',
              debugShowCheckedModeBanner: false,
              theme: appThemes[state.appTheme],
              routerDelegate: _router.delegate(),
              routeInformationParser: _router.defaultRouteParser(),
            );
          } else {
            return MaterialApp.router(
              title: 'Mooover',
              debugShowCheckedModeBanner: false,
              theme: appThemes[AppTheme.light],
              routerDelegate: _router.delegate(),
              routeInformationParser: _router.defaultRouteParser(),
            );
          }
        },
      ),
    );
  }
}
