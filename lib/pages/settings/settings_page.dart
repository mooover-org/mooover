import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mooover/pages/settings/components/group_settings_form.dart';
import 'package:mooover/pages/settings/components/user_settings_form.dart';
import 'package:mooover/utils/cubits/group_info/group_info_cubit.dart';
import 'package:mooover/utils/cubits/group_info/group_info_states.dart';
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
      body: ListView(children: [
        const UserSettingsForm(),
        BlocBuilder<GroupInfoCubit, GroupInfoState>(
            bloc: BlocProvider.of<GroupInfoCubit>(context),
            builder: (context, state) {
              if (state is GroupInfoLoadedState) {
                return const GroupSettingsForm();
              } else if (state is GroupInfoLoadingState) {
                return const Panel(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: LoadingDisplay(transparent: true,),
                  ),
                );
              }
              return Container();
            })
      ]),
    );
  }
}
