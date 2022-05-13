import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mooover/config/themes/themes.dart';
import 'package:mooover/utils/cubits/app_settings/app_settings_cubit.dart';
import 'package:mooover/utils/cubits/app_settings/app_settings_states.dart';
import 'package:mooover/utils/cubits/user_session/user_session_cubit.dart';
import 'package:mooover/widgets/error_display.dart';
import 'package:mooover/widgets/loading_display.dart';

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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                'App theme: ',
                textAlign: TextAlign.start,
              ),
              DropdownButton<String>(
                value: state.appTheme.toString(),
                icon: const Icon(Icons.arrow_drop_down),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    BlocProvider.of<AppSettingsCubit>(context).changeTheme(
                        AppTheme.values.firstWhere(
                            (element) => element.toString() == newValue,
                            orElse: () => AppTheme.light));
                  }
                },
                items: AppTheme.values.map<String>((AppTheme appTheme) {
                  return appTheme.toString();
                }).map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextButton(
              child: const Text(
                'Log out',
                textAlign: TextAlign.center,
              ),
              onPressed: () =>
                  BlocProvider.of<UserSessionCubit>(context).logout()),
        ),
      ],
    );
  }
}
