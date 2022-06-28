import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mooover/utils/cubits/user_info/user_info_cubit.dart';
import 'package:mooover/utils/cubits/user_info/user_info_states.dart';
import 'package:mooover/widgets/error_display.dart';
import 'package:mooover/widgets/loading_display.dart';

class UserInfoFields extends StatelessWidget {
  const UserInfoFields({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserInfoCubit, UserInfoState>(
      builder: (context, state) {
        if (state is UserInfoLoadedState) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5.0, horizontal: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Daily steps goal',
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(
                      width: 100,
                      height: 30,
                      child: TextField(
                        controller: TextEditingController(
                            text: state.dailyStepsGoal.toString()),
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
                            BlocProvider.of<UserInfoCubit>(context)
                                .changeDailyStepsGoal(int.parse(value));
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5.0, horizontal: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Weekly steps goal',
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(
                      width: 120,
                      height: 30,
                      child: TextField(
                        controller: TextEditingController(
                            text: state.weeklyStepsGoal.toString()),
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
                            BlocProvider.of<UserInfoCubit>(context)
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
        } else if (state is UserInfoLoadingState) {
          return LoadingDisplay(message: state.message);
        } else if (state is UserInfoErrorState) {
          return ErrorDisplay(message: state.message);
        } else {
          return const ErrorDisplay();
        }
      },
    );
  }
}
