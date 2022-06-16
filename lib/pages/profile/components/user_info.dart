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
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: CircleAvatar(
                      radius: 80,
                      backgroundImage: NetworkImage(state.user.picture),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 5.0),
                    child: Text(
                      state.user.name,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      state.user.nickname,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0,
                        horizontal: 30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Given name:',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.caption,
                        ),
                        Text(
                          state.user.givenName,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium,
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0,
                        horizontal: 30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Family name:',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.caption,
                        ),
                        Text(
                          state.user.familyName,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium,
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0,
                        horizontal: 30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Email:',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.caption,
                        ),
                        Text(
                          state.user.email,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium,
                        )
                      ],
                    ),
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
