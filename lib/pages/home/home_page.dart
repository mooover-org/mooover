import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mooover/pages/home/components/dashboard.dart';
import 'package:mooover/utils/cubits/app_theme/app_theme_cubit.dart';
import 'package:mooover/utils/cubits/user_info/user_info_cubit.dart';
import 'package:mooover/utils/cubits/user_info/user_info_states.dart';
import 'package:mooover/utils/cubits/user_session/user_session_cubit.dart';
import 'package:mooover/utils/cubits/user_session/user_session_states.dart';
import 'package:mooover/widgets/error_display.dart';
import 'package:mooover/widgets/loading_display.dart';

/// The home page.
///
/// This is the main page of the app.
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserSessionCubit, UserSessionState>(
        bloc: BlocProvider.of<UserSessionCubit>(context),
        listener: (context, state) async {
          log('HomePage: listener: state is $state');
          if (state is UserSessionNoState) {
            log('HomePage: listener: not logged in');
            await BlocProvider.of<UserInfoCubit>(context).removeUserInfo();
            await BlocProvider.of<AppThemeCubit>(context).removeAppTheme();
            log('HomePage: listener: user info removed');
            context.router.pushNamed('/login');
            log('HomePage: listener: pushed login');
          } else if (state is UserSessionLoadedState && BlocProvider.of<UserInfoCubit>(context).state is UserInfoNoState) {
            log('HomePage: listener: logged in and user info not loaded');
            await BlocProvider.of<UserInfoCubit>(context).loadUserInfo();
            await BlocProvider.of<AppThemeCubit>(context).loadAppTheme();
            log('HomePage: listener: user info loading');
          }
        },
        builder: (context, state) {
          if (state is UserSessionLoadedState) {
            return Scaffold(
              appBar: AppBar(
                title: const Text("Mooover!"),
                centerTitle: true,
                leading: IconButton(
                  iconSize: 50,
                  icon: const Icon(
                    Icons.group,
                    size: 50,
                  ),
                  onPressed: () => AutoRouter.of(context).pushNamed('/group'),
                ),
                actions: [
                  IconButton(
                    iconSize: 50,
                    icon: BlocBuilder<UserInfoCubit, UserInfoState>(
                      builder: (context, state) {
                        if (state is UserInfoLoadedState) {
                          return CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(
                                state.user.picture,
                              ));
                        } else {
                          return const Icon(
                            Icons.person,
                            size: 50,
                          );
                        }
                      },
                    ),
                    onPressed: () =>
                        AutoRouter.of(context).pushNamed('/profile'),
                  ),
                ],
              ),
              body: const Dashboard(),
            );
          } else if (state is UserSessionLoadingState) {
            return const LoadingDisplay();
          } else if (state is UserSessionNoState) {
            return const ErrorDisplay(
              message: 'You are not logged in.',
            );
          } else if (state is UserSessionErrorState) {
            return ErrorDisplay(
              message: state.message,
            );
          } else {
            return const ErrorDisplay();
          }
        });
  }
}
