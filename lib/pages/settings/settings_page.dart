import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mooover/pages/settings/components/group_settings/group_settings.dart';
import 'package:mooover/pages/settings/components/user_settings/user_settings.dart';
import 'package:mooover/utils/cubits/membership/membership_cubit.dart';
import 'package:mooover/utils/helpers/logger.dart';

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
          const UserSettings(),
          BlocProvider<MembershipCubit>.value(
            value: BlocProvider.of<MembershipCubit>(context),
            child: const GroupSettings(),
          ),
        ],
      ),
    );
  }
}
