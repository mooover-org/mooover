import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mooover/utils/cubits/groups/groups_cubit.dart';
import 'package:mooover/utils/cubits/groups/groups_states.dart';
import 'package:mooover/utils/cubits/membership/membership_cubit.dart';
import 'package:mooover/widgets/error_display.dart';
import 'package:mooover/widgets/loading_display.dart';
import 'package:mooover/widgets/panel.dart';

class GroupsList extends StatelessWidget {
  const GroupsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupsCubit, GroupsState>(
      builder: (context, state) {
        if (state is GroupsLoadedState) {
          if (state.groups.isEmpty) {
            return const Center(
              child: Text('No groups found'),
            );
          } else {
            return ListView.builder(
              itemCount: state.groups.length,
              itemBuilder: (context, index) {
                final group = state.groups[index];
                return Panel(
                  child: ListTile(
                    title: Text(group.name),
                    subtitle: Text(group.nickname),
                    leading: const Icon(
                      Icons.group,
                      size: 50,
                    ),
                    trailing: TextButton(
                      onPressed: () => BlocProvider.of<MembershipCubit>(context)
                          .joinGroup(group.id),
                      child: const Text('Join'),
                    ),
                  ),
                );
              },
            );
          }
        } else if (state is GroupsLoadingState) {
          return LoadingDisplay(message: state.message);
        } else if (state is GroupsErrorState) {
          return ErrorDisplay(message: state.message);
        } else {
          return const ErrorDisplay();
        }
      },
    );
  }
}
