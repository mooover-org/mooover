import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mooover/utils/cubits/pedestrian_status/pedestrian_status_cubit.dart';
import 'package:mooover/utils/cubits/pedestrian_status/pedestrian_status_states.dart';
import 'package:mooover/widgets/error_display.dart';
import 'package:mooover/widgets/loading_display.dart';

class PedestrianStatusIcon extends StatelessWidget {
  const PedestrianStatusIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PedestrianStatusCubit, PedestrianStatusState>(
      builder: (context, state) {
        if (state is PedestrianStatusLoadedState) {
          return Icon(
            state.status,
            size: 70,
            color: Theme.of(context).textTheme.caption?.color,
          );
        } else if (state is PedestrianStatusLoadingState) {
          return LoadingDisplay(
            message: state.message,
            indicatorSize: 28,
          );
        } else if (state is PedestrianStatusErrorState) {
          return const ErrorDisplay(
            message: "Error loading pedestrian status",
          );
        } else {
          return const ErrorDisplay();
        }
      },
    );
  }
}
