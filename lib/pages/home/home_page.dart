import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mooover/pages/home/components/dashboard/dashboard.dart';
import 'package:mooover/pages/home/components/leaderboard/leaderboard.dart';
import 'package:mooover/pages/home/components/profile_button.dart';
import 'package:mooover/utils/cubits/leaderboard/leaderboard_cubit.dart';
import 'package:mooover/utils/cubits/membership/membership_cubit.dart';
import 'package:mooover/utils/cubits/user_info/user_info_cubit.dart';
import 'package:mooover/utils/helpers/logger.dart';

/// The home page.
///
/// This is the main page of the app.
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          onPressed: () async => await AutoRouter.of(context)
              .pushNamed('/group')
              .then((value) => BlocProvider.of<LeaderboardCubit>(context)
                  .loadLeaderboard()),
        ),
        actions: [
          BlocProvider<UserInfoCubit>.value(
            value: BlocProvider.of<UserInfoCubit>(context),
            child: const ProfileButton(),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BlocProvider<UserInfoCubit>.value(
            value: BlocProvider.of<UserInfoCubit>(context),
            child: const Dashboard(),
          ),
          Expanded(
            child: MultiBlocProvider(
              providers: [
                BlocProvider<LeaderboardCubit>.value(
                  value: BlocProvider.of<LeaderboardCubit>(context),
                ),
                BlocProvider<MembershipCubit>.value(
                  value: BlocProvider.of<MembershipCubit>(context),
                ),
              ],
              child: const Leaderboard(),
            ),
          ),
        ],
      ),
    );
  }
}
