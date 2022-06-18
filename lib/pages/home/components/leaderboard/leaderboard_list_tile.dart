import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mooover/utils/cubits/membership/membership_cubit.dart';
import 'package:mooover/utils/cubits/membership/membership_states.dart';
import 'package:mooover/widgets/panel.dart';

class LeaderboardListTile extends StatelessWidget {
  final String id;
  final String name;
  final String nickname;
  final int thisWeekSteps;

  const LeaderboardListTile({
    Key? key,
    required this.id,
    required this.name,
    required this.nickname,
    required this.thisWeekSteps,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MembershipCubit, MembershipState>(
      builder: (context, membershipState) {
        Color? textColor;
        if (membershipState is MembershipLoadedState &&
            id == membershipState.groupId) {
          textColor = Theme.of(context).accentColor;
        }
        return Panel(
          child: ListTile(
            title: Text(
              name,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              nickname,
              overflow: TextOverflow.ellipsis,
            ),
            leading: const Icon(
              Icons.group,
              size: 50,
            ),
            trailing: Text("Steps: ${thisWeekSteps.toString()}"),
            textColor: textColor,
          ),
        );
      },
    );
  }
}
