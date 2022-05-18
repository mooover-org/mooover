import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mooover/pages/profile/components/user_info.dart';

/// The user profile page.
///
/// This page is used to display the user's profile.
class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Profile"),
          centerTitle: true,
          actions: [
            IconButton(
              iconSize: 50,
              icon: const Icon(
                Icons.settings,
                size: 50,
              ),
              onPressed: () => AutoRouter.of(context).pushNamed('/settings'),
            ),
          ],
        ),
        body: const UserInfo());
  }
}
