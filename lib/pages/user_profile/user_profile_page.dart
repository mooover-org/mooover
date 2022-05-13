import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mooover/pages/user_profile/components/user_profile_info.dart';
import 'package:mooover/utils/cubits/user_session/user_session_cubit.dart';
import 'package:mooover/utils/cubits/user_session/user_session_states.dart';
import 'package:mooover/utils/services/user_session_services.dart';

/// The user profile page.
///
/// This page is used to display the user's profile.
class UserProfilePage extends StatelessWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserSessionCubit, UserSessionState>(
      bloc: BlocProvider.of<UserSessionCubit>(context),
      listener: (context, state) {
        // log('UserProfilePage.listener: $state');
        // if (!UserSessionServices().isLoggedIn()) {
        //   log('UserProfilePage.listener: not logged in');
        //   context.router.pushNamed('/login');
        //   log('UserProfilePage.listener: pushed login');
        // }
      },
      child: Scaffold(
          appBar: AppBar(
            title: const Center(child: Text("Profile")),
          ),
          body: const UserProfileInfo()),
    );
  }
}
