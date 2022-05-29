import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mooover/utils/cubits/group_info/group_info_cubit.dart';
import 'package:mooover/utils/cubits/group_info/group_info_states.dart';
import 'package:mooover/widgets/error_display.dart';
import 'package:mooover/widgets/loading_display.dart';
import 'package:mooover/widgets/panel.dart';

/// A form to set the group settings
class GroupSettingsForm extends StatelessWidget {
  const GroupSettingsForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Panel(
      child: Center(
        child: BlocBuilder<GroupInfoCubit, GroupInfoState>(
          bloc: BlocProvider.of<GroupInfoCubit>(context),
          builder: (context, state) {
            if (state is GroupInfoLoadedState) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text(
                          'Daily steps goal',
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(
                          width: 80,
                          height: 30,
                          child: TextField(
                            controller: TextEditingController(
                                text: state.group.dailyStepsGoal.toString()),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              filled: true,
                            ),
                            onSubmitted: (String? value) {
                              if (value != null) {
                                BlocProvider.of<GroupInfoCubit>(context)
                                    .changeDailyStepsGoal(int.parse(value));
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text(
                          'Weekly steps goal',
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(
                          width: 80,
                          height: 30,
                          child: TextField(
                            controller: TextEditingController(
                                text: state.group.weeklyStepsGoal.toString()),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              filled: true,
                            ),
                            onSubmitted: (String? value) {
                              if (value != null) {
                                BlocProvider.of<GroupInfoCubit>(context)
                                    .changeWeeklyStepsGoal(int.parse(value));
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
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
              return const ErrorDisplay(
                transparent: true,
              );
            }
          },
        ),
      ),
    );
  }
}
