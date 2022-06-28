import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mooover/utils/cubits/app_theme/app_theme_cubit.dart';
import 'package:mooover/utils/cubits/group_info/group_info_cubit.dart';
import 'package:mooover/utils/cubits/group_steps/group_steps_cubit.dart';
import 'package:mooover/utils/cubits/membership/membership_cubit.dart';
import 'package:mooover/utils/cubits/user_info/user_info_cubit.dart';
import 'package:mooover/utils/cubits/user_session/user_session_cubit.dart';
import 'package:mooover/utils/cubits/user_session/user_session_states.dart';
import 'package:mooover/utils/cubits/user_steps/user_steps_cubit.dart';
import 'package:mooover/widgets/loading_display.dart';

class GreetingsPage extends StatelessWidget {
  const GreetingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserSessionCubit, UserSessionState>(
      listener: (context, state) async {
        if (state is UserSessionLoadedState) {
          AutoRouter.of(context).popUntilRoot();
          await BlocProvider.of<AppThemeCubit>(context).loadAppTheme();
          await BlocProvider.of<UserInfoCubit>(context).loadUserInfo();
          await BlocProvider.of<MembershipCubit>(context).loadMembership();
          await BlocProvider.of<GroupInfoCubit>(context).loadGroupInfo();
          await BlocProvider.of<UserStepsCubit>(context).loadUserSteps();
          await BlocProvider.of<GroupStepsCubit>(context).loadGroupSteps();
          AutoRouter.of(context).pushNamed('/home');
        } else if (state is UserSessionNoState) {
          AutoRouter.of(context).popUntilRoot();
          await BlocProvider.of<AppThemeCubit>(context).removeAppTheme();
          AutoRouter.of(context).pushNamed('/login');
        }
      },
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                'Mooover!',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: LoadingDisplay(),
            ),
          ],
        ),
      ),
    );
  }
}
