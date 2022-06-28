import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mooover/utils/cubits/group_members/group_members_cubit.dart';
import 'package:mooover/utils/cubits/group_members/group_members_states.dart';
import 'package:mooover/utils/services/user_session_services.dart';
import 'package:mooover/widgets/error_display.dart';
import 'package:mooover/widgets/loading_display.dart';
import 'package:mooover/widgets/panel.dart';

class GroupMembersList extends StatelessWidget {
  const GroupMembersList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupMembersCubit, GroupMembersState>(
      builder: (context, state) {
        if (state is GroupMembersLoadedState) {
          return ListView.builder(
            itemCount: state.members.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Members',
                    textAlign: TextAlign.center,
                  ),
                );
              } else {
                final member = state.members[index - 1];
                return Panel(
                  child: ListTile(
                    title: Text(member.name),
                    subtitle: Text(member.nickname),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(member.picture),
                    ),
                    trailing: Text("Steps: ${member.thisWeekSteps.toString()}"),
                    textColor: member.id == UserSessionServices().getUserId()
                        ? Theme.of(context).accentColor
                        : null,
                  ),
                );
              }
            },
          );
        } else if (state is GroupMembersLoadingState) {
          return LoadingDisplay(message: state.message);
        } else if (state is GroupMembersErrorState) {
          return ErrorDisplay(message: state.message);
        } else {
          return const ErrorDisplay();
        }
      },
    );
  }
}
