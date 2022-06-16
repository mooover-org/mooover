import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mooover/pages/group/components/group_actions_bar.dart';
import 'package:mooover/pages/group/components/group_info.dart';
import 'package:mooover/utils/cubits/group_info/group_info_cubit.dart';
import 'package:mooover/utils/cubits/group_info/group_info_states.dart';
import 'package:mooover/utils/services/user_session_services.dart';
import 'package:mooover/widgets/error_display.dart';
import 'package:mooover/widgets/loading_display.dart';
import 'package:mooover/widgets/panel.dart';

/// The group page.
///
/// This is the page that displays the group's information and available groups
/// to join.
class GroupPage extends StatelessWidget {
  const GroupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<GroupInfoCubit, GroupInfoState>(
          bloc: BlocProvider.of<GroupInfoCubit>(context),
          builder: (context, state) {
            if (state is GroupInfoLoadedState) {
              return const Text("Group");
            } else {
              return const Text("Groups");
            }
          },
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_forward),
            onPressed: () => AutoRouter.of(context).pop(),
          ),
        ],
      ),
      body: BlocBuilder<GroupInfoCubit, GroupInfoState>(
          bloc: BlocProvider.of<GroupInfoCubit>(context),
          builder: (context, state) {
            if (state is GroupInfoNoState) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  GroupActionsBar(),
                  Expanded(
                    child: state.groups.isEmpty
                        ? const Center(
                            child: Text('No groups available'),
                          )
                        : ListView.builder(
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
                                    onPressed: () =>
                                        BlocProvider.of<GroupInfoCubit>(context)
                                            .joinGroup(group.nickname),
                                    child: const Text('Join'),
                                  ),
                                ),
                              );
                            }),
                  ),
                ],
              );
            } else if (state is GroupInfoLoadedState) {
              return Column(
                children: [
                  const Expanded(child: GroupInfo()),
                  Expanded(
                      child: ListView.builder(
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
                            trailing: Text(
                                "Steps: ${member.thisWeekSteps.toString()}"),
                            textColor:
                                member.id == UserSessionServices().getUserId()
                                    ? Theme.of(context).accentColor
                                    : null,
                          ),
                        );
                      }
                    },
                  )),
                ],
              );
            } else if (state is GroupInfoLoadingState) {
              return const LoadingDisplay(
                transparent: true,
              );
            } else if (state is GroupInfoErrorState) {
              return ErrorDisplay(
                message: state.message,
                transparent: true,
              );
            } else {
              return const ErrorDisplay();
            }
          }),
      floatingActionButton: BlocBuilder<GroupInfoCubit, GroupInfoState>(
          bloc: BlocProvider.of<GroupInfoCubit>(context),
          builder: (context, state) {
            if (state is GroupInfoNoState) {
              return FloatingActionButton(
                  child: const Icon(Icons.add),
                  onPressed: () => showDialog(
                      context: context,
                      builder: (context) =>
                          buildCreateGroupDialog(state, context)));
            } else {
              return Container();
            }
          }),
    );
  }

  AlertDialog buildCreateGroupDialog(
      GroupInfoNoState state, BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final _nicknameController = TextEditingController();
    final _nameController = TextEditingController();

    return AlertDialog(
      title: const Text('Create group'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: _nicknameController,
              decoration: const InputDecoration(
                labelText: 'Group nickname',
                hintText: 'nickname',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'You need to enter a group nickname';
                } else if (state.groups
                    .map((group) => group.nickname)
                    .contains(value)) {
                  return 'Group with this nickname already exists';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Group name',
                hintText: 'name',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'You need to enter a group name';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          child: const Text('Cancel'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        OutlinedButton(
          child: const Text('Create'),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              BlocProvider.of<GroupInfoCubit>(context).createGroup(
                  _nicknameController.value.text, _nameController.value.text);
            }
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
