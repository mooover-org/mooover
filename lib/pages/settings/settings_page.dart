import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mooover/pages/group/components/group_info.dart';
import 'package:mooover/pages/settings/components/group_settings/group_settings.dart';
import 'package:mooover/pages/settings/components/user_settings/user_settings.dart';
import 'package:mooover/utils/cubits/app_theme/app_theme_cubit.dart';
import 'package:mooover/utils/cubits/group_info/group_info_cubit.dart';
import 'package:mooover/utils/cubits/membership/membership_cubit.dart';
import 'package:mooover/utils/cubits/membership/membership_states.dart';
import 'package:mooover/utils/cubits/user_info/user_info_cubit.dart';
import 'package:mooover/utils/helpers/logger.dart';
import 'package:mooover/widgets/loading_display.dart';
import 'package:mooover/widgets/panel.dart';

/// The settings page.
///
/// This page is used to change the settings of the app, user and other.
class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          MultiBlocProvider(
            providers: [
              BlocProvider<UserInfoCubit>(
                create: (context) {
                  logger.d('Creating and providing user info cubit');
                  return UserInfoCubit();
                },
              ),
              BlocProvider<AppThemeCubit>(
                create: (context) {
                  logger.d('Creating and providing app theme cubit');
                  return AppThemeCubit();
                },
              ),
            ],
            child: const UserSettings(),
          ),
          MultiBlocProvider(
            providers: [
              BlocProvider<MembershipCubit>(
                create: (context) {
                  logger.d('Creating and providing membership cubit');
                  return MembershipCubit();
                },
              ),
              BlocProvider<GroupInfoCubit>(
                create: (context) {
                  logger.d('Creating and providing group info cubit');
                  return GroupInfoCubit();
                },
              ),
            ],
            child: const GroupSettings(),
          ),
        ],
      ),
    );
  }
}
