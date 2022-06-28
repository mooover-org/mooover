import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mooover/utils/cubits/user_info/user_info_cubit.dart';
import 'package:mooover/utils/cubits/user_info/user_info_states.dart';

class ProfileButton extends StatelessWidget {
  const ProfileButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 50,
      icon: BlocBuilder<UserInfoCubit, UserInfoState>(
        builder: (context, state) {
          if (state is UserInfoLoadedState) {
            return CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                  state.picture,
                ));
          } else if (state is UserInfoLoadingState) {
            return const Icon(
              Icons.person,
              size: 50,
            );
          } else {
            return const Icon(
              Icons.error,
              size: 50,
            );
          }
        },
      ),
      onPressed: () => AutoRouter.of(context).pushNamed('/profile'),
    );
  }
}
