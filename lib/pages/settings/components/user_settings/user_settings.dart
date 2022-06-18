import 'package:flutter/material.dart';
import 'package:mooover/pages/settings/components/user_settings/app_theme_picker.dart';
import 'package:mooover/pages/settings/components/user_settings/user_info_fields.dart';
import 'package:mooover/widgets/panel.dart';

/// A form to set the user settings.
class UserSettings extends StatelessWidget {
  const UserSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Panel(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              "User settings",
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
          ),
          const Divider(
            indent: 10,
            endIndent: 10,
            thickness: 1,
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 5.0, horizontal: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'App theme',
                  textAlign: TextAlign.start,
                ),
                AppThemePicker(),
              ],
            ),
          ),
          const UserInfoFields(),
        ],
      ),
    );
  }
}
