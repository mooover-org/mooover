import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mooover/config/themes/themes.dart';
import 'package:mooover/utils/cubits/app_settings/app_settings_cubit.dart';
import 'package:mooover/utils/cubits/app_settings/app_settings_states.dart';
import 'package:mooover/utils/cubits/user_session/user_session_cubit.dart';
import 'package:mooover/widgets/error_display.dart';
import 'package:mooover/widgets/loading_display.dart';
import 'package:mooover/widgets/panel.dart';

/// A form to set the app settings.
class AppSettingsForm extends StatelessWidget {
  const AppSettingsForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppSettingsCubit, AppSettingsState>(
      bloc: BlocProvider.of<AppSettingsCubit>(context),
      builder: (context, state) {
        if (state is AppSettingsInitialState) {
          return const LoadingDisplay();
        } else if (state is AppSettingsLoadingState) {
          return const LoadingDisplay();
        } else if (state is AppSettingsLoadedState) {
          return _getLoadedDisplay(context, state);
        } else if (state is AppSettingsErrorState) {
          return ErrorDisplay(message: state.errorMessage);
        } else {
          return const ErrorDisplay();
        }
      },
    );
  }

  /// This method returns the display for the app settings form.
  Widget _getLoadedDisplay(BuildContext context, AppSettingsLoadedState state) {
    return Panel(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text(
                  'App theme:',
                  textAlign: TextAlign.start,
                ),
                DropdownButton(
                  value: appThemeToString(state.appTheme),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      BlocProvider.of<AppSettingsCubit>(context)
                          .changeTheme(appThemeFromString(newValue));
                    }
                  },
                  items: AppTheme.values
                      .map<DropdownMenuItem<String>>((AppTheme appTheme) {
                    return DropdownMenuItem<String>(
                      value: appThemeToString(appTheme),
                      child: Text(appThemeToString(appTheme)),
                    );
                  }).toList(),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
              ],
            ),
            OutlinedButton(
                child: const Text(
                  'Log out',
                  textAlign: TextAlign.center,
                ),
                onPressed: () =>
                    BlocProvider.of<UserSessionCubit>(context).logout()),
          ],
        ),
      ),
    );
  }
}
