import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mooover/pages/home/components/dashboard/dashboard.dart';
import 'package:mooover/pages/home/components/leaderboard/leaderboard.dart';
import 'package:mooover/pages/home/components/profile_button.dart';
import 'package:mooover/utils/cubits/leaderboard/leaderboard_cubit.dart';
import 'package:mooover/utils/cubits/membership/membership_cubit.dart';
import 'package:mooover/utils/cubits/user_info/user_info_cubit.dart';
import 'package:mooover/utils/cubits/user_session/user_session_cubit.dart';
import 'package:mooover/utils/cubits/user_session/user_session_states.dart';
import 'package:mooover/utils/helpers/logger.dart';
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
      listener: (context, state) async {
        if (state is UserSessionNoState) {
          AutoRouter.of(context).pushNamed('/login');
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
                BlocProvider<UserInfoCubit>(
                  create: (context) {
                    logger.d('Creating and providing user info cubit');
                    return UserInfoCubit();
                  },
                  child: const ProfileButton(),
                ),
              ],
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BlocProvider<UserInfoCubit>(
                  create: (context) {
                    logger.d('Creating and providing user info cubit');
                    return UserInfoCubit();
                  },
                  child: const Dashboard(),
                ),
                Expanded(
                  child: MultiBlocProvider(
                    providers: [
                      BlocProvider<LeaderboardCubit>(
                        create: (context) {
                          logger.d('Creating and providing leaderboard cubit');
                          return LeaderboardCubit();
                        },
                      ),
                      BlocProvider<MembershipCubit>(
                        create: (context) {
                          logger.d('Creating and providing membership cubit');
                          return MembershipCubit();
                        },
                      ),
                    ],
                    child: const Leaderboard(),
                  ),
                ),
              ],
            ),
          );
        } else if (state is UserSessionNoState) {
          return const ErrorDisplay(
            message: 'You are not logged in!',
            transparent: false,
          );
        } else if (state is UserSessionLoadingState) {
          return LoadingDisplay(
            message: state.message,
            transparent: false,
          );
        } else if (state is UserSessionErrorState) {
          return ErrorDisplay(
            message: state.message,
            transparent: false,
          );
        } else {
          return const ErrorDisplay(transparent: false);
        }
      },
    );
  }
}
