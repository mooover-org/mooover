import 'package:flutter/material.dart';
import 'package:mooover/widgets/panel.dart';

/// This is the leaderboard component.
///
/// It is used to display the current groups standings in the weekly leaderboard.
class Leaderboard extends StatelessWidget {
  const Leaderboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Panel(
      child: Center(
        child: Text('Leaderboard'),
      ),
    );
  }
}
