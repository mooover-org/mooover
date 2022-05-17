import 'package:flutter/material.dart';
import 'package:mooover/widgets/panel.dart';

/// A form to set the user settings.
class UserSettingsForm extends StatelessWidget {
  const UserSettingsForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Panel(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                Text(
                  'Daily steps target',
                  textAlign: TextAlign.start,
                ),
                Text(
                  '5000',
                  textAlign: TextAlign.end,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
