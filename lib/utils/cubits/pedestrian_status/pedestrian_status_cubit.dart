import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mooover/utils/cubits/pedestrian_status/pedestrian_status_states.dart';
import 'package:mooover/utils/domain/observer.dart';
import 'package:mooover/utils/services/steps_services.dart';

class PedestrianStatusCubit extends Cubit<PedestrianStatusState>
    implements Observer {
  PedestrianStatusCubit(
      {initialState =
          const PedestrianStatusLoadedState(Icons.accessibility_new)})
      : super(initialState);

  @override
  void update() {
    hotReload();
  }

  Future<void> hotReload() async {
    try {
      final newPedestrianStatus = StepsServices().getPedestrianStatus();
      if (newPedestrianStatus == 'walking') {
        emit(const PedestrianStatusLoadedState(Icons.directions_walk));
      } else if (newPedestrianStatus == 'stopped') {
        emit(const PedestrianStatusLoadedState(Icons.accessibility_new));
      } else {
        emit(const PedestrianStatusLoadedState(Icons.question_mark));
      }
      log('Pedestrian status hot reloaded');
    } catch (e) {
      emit(PedestrianStatusErrorState(e.toString()));
      log('Pedestrian status error: $e');
    }
  }

  Future<void> changeStatus(String newPedestrianStatus) async {
    emit(const PedestrianStatusLoadingState());
    try {
      if (newPedestrianStatus == 'walking') {
        emit(const PedestrianStatusLoadedState(Icons.directions_walk));
      } else if (newPedestrianStatus == 'stopped') {
        emit(const PedestrianStatusLoadedState(Icons.accessibility_new));
      } else {
        emit(const PedestrianStatusLoadedState(Icons.question_mark));
      }
      log('Pedestrian status changed');
    } catch (e) {
      emit(PedestrianStatusErrorState(e.toString()));
      log('Pedestrian status error: $e');
    }
  }
}
