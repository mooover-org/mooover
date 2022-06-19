import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mooover/utils/cubits/groups/groups_cubit.dart';

class GroupsSearchBar extends StatelessWidget {
  final _searchFormKey = GlobalKey<FormState>();
  final _searchController = TextEditingController();

  GroupsSearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _searchFormKey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width - 100,
            height: 80,
            child: TextFormField(
              controller: _searchController,
              validator: (value) {
                return null;
              },
              onEditingComplete: () {
                if (_searchFormKey.currentState!.validate()) {
                  BlocProvider.of<GroupsCubit>(context)
                      .filterGroups(_searchController.value.text);
                }
              },
              decoration: const InputDecoration(
                labelText: 'Search',
                hintText: 'nickname or name',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
