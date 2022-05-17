import 'package:flutter/material.dart';
import 'package:mooover/pages/user_profile/components/user_profile_info.dart';

/// The user profile page.
///
/// This page is used to display the user's profile.
class UserProfilePage extends StatelessWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Profile"),
          centerTitle: true,
        ),
        body: const UserProfileInfo());
  }
}
