import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mooover/config/routes/routing.gr.dart';
import 'package:mooover/pages/home/components/dashboard.dart';
import 'package:mooover/utils/cubits/user_session/user_session_cubit.dart';
import 'package:mooover/utils/cubits/user_session/user_session_states.dart';
import 'package:mooover/utils/services/user_session_services.dart';

/// The home page.
///
/// Page for seeing at a glance all the important user data, like the steps
/// counter and heart points counter.
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    log("called initState on HomePage");
    if (UserSessionServices().accessToken == null) {
      context.read<UserSessionCubit>().loadLastSession();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserSessionCubit, UserSessionState>(
        listener: (_, state) {
      if (state is NoUserSessionState) {
        context.router.replace(const LoginPageRoute());
      }
    }, builder: (_, state) {
      if (state is ValidUserSessionState) {
        return const Dashboard();
      } else if (state is LoadingUserSessionState ||
          state is NoUserSessionState) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else {
        return const Center(
          child: Text("Something bad happened :/\n(home page)"),
        );
      }
    });
  }
}
