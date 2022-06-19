import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mooover/pages/group/components/group_page_contents/groups_list/groups_search_bar.dart';
import 'package:mooover/pages/group/components/group_page_contents/group_info/group_info.dart';
import 'package:mooover/pages/group/components/group_page_add_button.dart';
import 'package:mooover/pages/group/components/group_page_contents/group_page_contents.dart';
import 'package:mooover/pages/group/components/group_page_title.dart';
import 'package:mooover/utils/cubits/group_info/group_info_cubit.dart';
import 'package:mooover/utils/cubits/group_info/group_info_states.dart';
import 'package:mooover/utils/cubits/membership/membership_cubit.dart';
import 'package:mooover/utils/helpers/logger.dart';
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
        title: BlocProvider<MembershipCubit>(
          create: (context) {
            logger.d('Creating and providing membership cubit');
            return MembershipCubit();
          },
          child: const GroupPageTitle(),
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
      body: BlocProvider<MembershipCubit>(
        create: (context) {
          logger.d('Creating and providing membership cubit');
          return MembershipCubit();
        },
        child: const GroupPageContents(),
      ),
      floatingActionButton: BlocProvider<MembershipCubit>(
        create: (context) {
          logger.d('Creating and providing membership cubit');
          return MembershipCubit();
        },
        child: const GroupPageAddButton(),
      ),
    );
  }

}
