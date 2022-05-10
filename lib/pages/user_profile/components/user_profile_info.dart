import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mooover/utils/cubits/user_profile/user_profile_info_cubit.dart';
import 'package:mooover/utils/cubits/user_profile/user_profile_info_states.dart';

/// This is the profile info component.
///
/// It displays the user's profile information.
class UserProfileInfo extends StatelessWidget {
  const UserProfileInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserProfileInfoCubit, UserProfileInfoState>(
      bloc: UserProfileInfoCubit(),
      builder: (_, state) {
        if (state is UserProfileInfoInitialState) {
          return _getLoadingDisplay();
        } else if (state is UserProfileInfoLoadingState) {
          return _getLoadingDisplay();
        } else if (state is UserProfileInfoLoadedState) {
          return _getLoadedDisplay(context, state);
        } else if (state is UserProfileInfoErrorState) {
          return _getErrorDisplay(state);
        } else {
          return _getErrorDisplay(null);
        }
      },
    );
  }

  /// This method returns the display for the profile info.
  Widget _getLoadedDisplay(
      BuildContext context, UserProfileInfoLoadedState state) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Center(
          child: CircleAvatar(
            radius: 100,
            backgroundImage: NetworkImage(state.picture),
          ),
        ),
        Center(
          child: Text(
            state.name,
          ),
        ),
        Center(
          child: Text(
            state.nickname,
          ),
        ),
        Center(
          child: Text(
            state.email,
          ),
        ),
        Center(
          child: IconButton(
            iconSize: 50,
            icon: const Icon(
              Icons.settings,
              size: 50,
            ),
            onPressed: () {
              context.router.pushNamed('/settings');
            },
          ),
        ),
      ],
    );
  }

  /// This method returns the display for the loading state.
  Widget _getLoadingDisplay() {
    return const Center(child: CircularProgressIndicator());
  }

  /// This method returns the display for the error state.
  Widget _getErrorDisplay(UserProfileInfoErrorState? state) {
    String errorMessage = state?.errorMessage ?? "An error occurred";
    return Center(child: Text("Error: $errorMessage"));
  }
}
