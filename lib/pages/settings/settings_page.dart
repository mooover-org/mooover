import 'package:flutter/material.dart';
import 'package:mooover/pages/settings/components/app_settings_form.dart';

/// The settings page.
///
/// This page is used to change the settings of the app, user and other.
class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Settings")),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          AppSettingsForm(),
        ],
      ),
    );
  }
}
