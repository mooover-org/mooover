import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mooover/pages/settings/components/group_settings/group_info_fields.dart';
import 'package:mooover/utils/cubits/membership/membership_cubit.dart';
import 'package:mooover/utils/cubits/membership/membership_states.dart';
import 'package:mooover/widgets/error_display.dart';
import 'package:mooover/widgets/loading_display.dart';
import 'package:mooover/widgets/panel.dart';

/// A form to set the group settings
class GroupSettings extends StatelessWidget {
  const GroupSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MembershipCubit, MembershipState>(
      builder: (context, state) {
        if (state is MembershipLoadedState) {
          return Panel(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    "Group settings",
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
                const Divider(
                  indent: 10,
                  endIndent: 10,
                  thickness: 1,
                ),
                const GroupInfoFields(),
              ],
            ),
          );
        } else if (state is MembershipNoState) {
          return Container();
        } else if (state is MembershipLoadingState) {
          return Panel(
            child: LoadingDisplay(message: state.message),
          );
        } else if (state is MembershipErrorState) {
          return Panel(
            child: ErrorDisplay(message: state.message),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
