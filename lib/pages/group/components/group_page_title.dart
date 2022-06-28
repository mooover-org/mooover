import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mooover/utils/cubits/membership/membership_cubit.dart';
import 'package:mooover/utils/cubits/membership/membership_states.dart';

class GroupPageTitle extends StatelessWidget {
  const GroupPageTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MembershipCubit, MembershipState>(
      builder: (context, state) {
        if (state is MembershipLoadedState) {
          return const Text("Group");
        } else {
          return const Text("Groups");
        }
      },
    );
  }
}
