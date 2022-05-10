import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mooover/utils/cubits/app_settings/app_settings_cubit.dart';
import 'package:mooover/utils/cubits/app_settings/app_settings_states.dart';
import 'package:mooover/utils/cubits/user_session/user_session_cubit.dart';

/// A form to set the app settings.
class AppSettingsForm extends StatelessWidget {
  const AppSettingsForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppSettingsCubit, AppSettingsState>(
      bloc: BlocProvider.of<AppSettingsCubit>(context),
      builder: (context, state) {
        if (state is AppSettingsInitialState) {
          return _getLoadingDisplay();
        } else if (state is AppSettingsLoadingState) {
          return _getLoadingDisplay();
        } else if (state is AppSettingsLoadedState) {
          return _getLoadedDisplay(context, state);
        } else if (state is AppSettingsErrorState) {
          return _getErrorDisplay(state);
        } else {
          return _getErrorDisplay(null);
        }
      },
    );
  }

  /// This method returns the display for the app settings form.
  Widget _getLoadedDisplay(BuildContext context, AppSettingsLoadedState state) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
          child: Text('App theme: ${state.appTheme}'),
        ),
        Center(
          child: TextButton(
              child: const Text('Log out'),
              onPressed: () => BlocProvider.of<UserSessionCubit>(context).logout()),
        ),
      ],
    );
  }

  /// This method returns the display for the loading state.
  Widget _getLoadingDisplay() {
    return const Center(child: CircularProgressIndicator());
  }

  /// This method returns the display for the error state.
  Widget _getErrorDisplay(AppSettingsErrorState? state) {
    String errorMessage = state?.errorMessage ?? "An error occurred";
    return Center(child: Text("Error: $errorMessage"));
  }
}
