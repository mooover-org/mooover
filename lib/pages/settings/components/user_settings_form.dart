import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mooover/config/themes/themes.dart';
import 'package:mooover/utils/cubits/app_theme/app_theme_cubit.dart';
import 'package:mooover/utils/cubits/app_theme/app_theme_states.dart';
import 'package:mooover/utils/cubits/user_info/user_info_cubit.dart';
import 'package:mooover/utils/cubits/user_info/user_info_states.dart';
import 'package:mooover/utils/cubits/user_session/user_session_cubit.dart';
import 'package:mooover/widgets/error_display.dart';
import 'package:mooover/widgets/loading_display.dart';
import 'package:mooover/widgets/panel.dart';

/// A form to set the user settings.
class UserSettingsForm extends StatelessWidget {
  const UserSettingsForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Panel(
      child: Center(
        child: BlocBuilder<UserInfoCubit, UserInfoState>(
          bloc: BlocProvider.of<UserInfoCubit>(context),
          builder: (context, state) {
            if (state is UserInfoLoadedState) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "User settings",
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
                          'App theme',
                          textAlign: TextAlign.start,
                        ),
                        BlocBuilder<AppThemeCubit, AppThemeState>(
                          bloc: BlocProvider.of<AppThemeCubit>(context),
                          builder: (context, state) {
                            if (state is AppThemeLoadedState) {
                              return DropdownButton(
                                value: appThemeToString(state.appTheme),
                                onChanged: (String? newValue) {
                                  if (newValue != null) {
                                    BlocProvider.of<AppThemeCubit>(context)
                                        .changeAppTheme(
                                            appThemeFromString(newValue));
                                  }
                                },
                                items: AppTheme.values
                                    .map<DropdownMenuItem<String>>(
                                        (AppTheme appTheme) {
                                  return DropdownMenuItem<String>(
                                    value: appThemeToString(appTheme),
                                    child: Text(appThemeToString(appTheme)),
                                  );
                                }).toList(),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                              );
                            } else {
                              return const LoadingDisplay(transparent: true,
                                  size: 28);
                            }
                          },
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
                          'Daily steps goal',
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(
                          width: 80,
                          height: 30,
                          child: TextField(
                            controller: TextEditingController(
                                text: state.user.dailyStepsGoal.toString()),
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
                                text: state.user.weeklyStepsGoal.toString()),
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
                  const Divider(
                    indent: 10,
                    endIndent: 10,
                    thickness: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OutlinedButton(
                      child: const Text(
                        'Log out',
                        textAlign: TextAlign.center,
                      ),
                      onPressed: () =>
                          BlocProvider.of<UserSessionCubit>(context).logout(),
                    ),
                  ),
                ],
              );
            } else if (state is UserInfoLoadingState) {
              return const LoadingDisplay(transparent: true);
            } else if (state is UserInfoErrorState) {
              return ErrorDisplay(message: state.message, transparent: true);
            } else {
              return const ErrorDisplay(transparent: true);
            }
          },
        ),
      ),
    );
  }
}
