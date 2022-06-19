import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mooover/utils/cubits/membership/membership_cubit.dart';
import 'package:mooover/utils/cubits/membership/membership_states.dart';

class GroupPageAddButton extends StatelessWidget {
  const GroupPageAddButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MembershipCubit, MembershipState>(
      builder: (context, state) {
        if (state is MembershipNoState) {
          return FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () => showDialog(
              context: context,
              builder: (context) {
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
                            } else if (state.groupIds.contains(value)) {
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
                          BlocProvider.of<MembershipCubit>(context).createGroup(
                              _nicknameController.value.text,
                              _nameController.value.text);
                        }
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
