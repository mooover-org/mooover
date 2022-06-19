import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mooover/pages/group/components/group_page_contents/group_info/group_info.dart';
import 'package:mooover/pages/group/components/group_page_contents/group_info/group_members_list.dart';
import 'package:mooover/pages/group/components/group_page_contents/groups_list/groups_list.dart';
import 'package:mooover/pages/group/components/group_page_contents/groups_list/groups_search_bar.dart';
import 'package:mooover/utils/cubits/group_info/group_info_cubit.dart';
import 'package:mooover/utils/cubits/group_members/group_members_cubit.dart';
import 'package:mooover/utils/cubits/groups/groups_cubit.dart';
import 'package:mooover/utils/cubits/membership/membership_cubit.dart';
import 'package:mooover/utils/cubits/membership/membership_states.dart';
import 'package:mooover/utils/helpers/logger.dart';
import 'package:mooover/widgets/error_display.dart';
import 'package:mooover/widgets/loading_display.dart';

class GroupPageContents extends StatelessWidget {
  const GroupPageContents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MembershipCubit, MembershipState>(
      builder: (context, state) {
        if (state is MembershipLoadedState) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BlocProvider<GroupInfoCubit>(
                create: (context) {
                  logger.d('Creating and providing group info cubit');
                  return GroupInfoCubit();
                },
                child: const GroupInfo(),
              ),
              Expanded(
                child: BlocProvider<GroupMembersCubit>(
                  create: (context) {
                    logger.d('Creating and providing group members cubit');
                    return GroupMembersCubit();
                  },
                  child: const GroupMembersList(),
                ),
              ),
            ],
          );
        } else if (state is MembershipNoState) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BlocProvider<GroupsCubit>(
                create: (context) {
                  logger.d('Creating and providing groups cubit');
                  return GroupsCubit();
                },
                child: GroupsSearchBar(),
              ),
              Expanded(
                child: BlocProvider<GroupsCubit>(
                  create: (context) {
                    logger.d('Creating and providing groups cubit');
                    return GroupsCubit();
                  },
                  child: const GroupsList(),
                ),
              ),
            ],
          );
        } else if (state is MembershipLoadingState) {
          return LoadingDisplay(message: state.message);
        } else if (state is MembershipErrorState) {
          return ErrorDisplay(message: state.message);
        } else {
          return const ErrorDisplay();
        }
      },
    );
  }
}
