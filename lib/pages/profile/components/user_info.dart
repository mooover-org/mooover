import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mooover/utils/cubits/user_info/user_info_cubit.dart';
import 'package:mooover/utils/cubits/user_info/user_info_states.dart';
import 'package:mooover/widgets/error_display.dart';
import 'package:mooover/widgets/loading_display.dart';
import 'package:mooover/widgets/panel.dart';

/// This is the user info component.
///
/// It displays the user's profile information.
class UserInfo extends StatelessWidget {
  const UserInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserInfoCubit, UserInfoState>(
      bloc: BlocProvider.of<UserInfoCubit>(context),
      builder: (context, state) {
        if (state is UserInfoLoadedState) {
          return Panel(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    radius: 100,
                    backgroundImage: NetworkImage(state.user.picture),
                  ),
                  Text(
                    state.user.name,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    state.user.nickname,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    state.user.email,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        } else if (state is UserInfoLoadingState) {
          return const LoadingDisplay(transparent: true,);
        } else if (state is UserInfoErrorState) {
          return ErrorDisplay(
            message: state.message,
            transparent: true,
          );
        } else {
          return const ErrorDisplay(transparent: true,);
        }
      },
    );
  }
}
