import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mooover/config/themes/themes.dart';
import 'package:mooover/utils/cubits/app_theme/app_theme_cubit.dart';
import 'package:mooover/utils/cubits/app_theme/app_theme_states.dart';
import 'package:mooover/widgets/loading_display.dart';

class AppThemePicker extends StatelessWidget {
  const AppThemePicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppThemeCubit, AppThemeState>(
      bloc: BlocProvider.of<AppThemeCubit>(context),
      builder: (context, state) {
        if (state is AppThemeLoadedState) {
          return DropdownButton(
            value: appThemeToString(state.appTheme),
            onChanged: (String? newValue) {
              if (newValue != null) {
                BlocProvider.of<AppThemeCubit>(context)
                    .changeAppTheme(appThemeFromString(newValue));
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
          );
        } else {
          return const LoadingDisplay(transparent: true, indicatorSize: 28);
        }
      },
    );
  }
}
