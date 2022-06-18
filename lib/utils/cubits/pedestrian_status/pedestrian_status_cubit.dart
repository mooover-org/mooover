import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mooover/utils/cubits/pedestrian_status/pedestrian_status_states.dart';
import 'package:mooover/utils/helpers/logger.dart';
import 'package:mooover/utils/services/steps_services.dart';

class PedestrianStatusCubit extends Cubit<PedestrianStatusState> {
  PedestrianStatusCubit(
      {initialState =
          const PedestrianStatusLoadedState(Icons.accessibility_new)})
      : super(initialState);

  Future<void> loadPedestrianStatus() async {
    emit(const PedestrianStatusLoadingState());
    logger.d('Pedestrian status state loading');
    try {
      final newPedestrianStatus = StepsServices().getPedestrianStatus();
      if (newPedestrianStatus == 'walking') {
        emit(const PedestrianStatusLoadedState(Icons.directions_walk));
        logger.d('Pedestrian status state loaded: walking');
      } else if (newPedestrianStatus == 'stopped') {
        emit(const PedestrianStatusLoadedState(Icons.accessibility_new));
        logger.d('Pedestrian status state loaded: stopped');
      } else {
        emit(const PedestrianStatusLoadedState(Icons.question_mark));
        logger.d('Pedestrian status state loaded: unknown');
      }
    } catch (e) {
      emit(PedestrianStatusErrorState(e.toString()));
      logger.e('Pedestrian status state error: $e');
    }
  }

  Future<void> changeStatus(String newPedestrianStatus) async {
    emit(const PedestrianStatusLoadingState());
    logger.d('Pedestrian status state loading');
    try {
      if (newPedestrianStatus == 'walking') {
        emit(const PedestrianStatusLoadedState(Icons.directions_walk));
        logger.d('Pedestrian status state loaded: walking');
      } else if (newPedestrianStatus == 'stopped') {
        emit(const PedestrianStatusLoadedState(Icons.accessibility_new));
        logger.d('Pedestrian status state loaded: stopped');
      } else {
        emit(const PedestrianStatusLoadedState(Icons.question_mark));
        logger.d('Pedestrian status state loaded: unknown');
      }
    } catch (e) {
      emit(PedestrianStatusErrorState(e.toString()));
      logger.e('Pedestrian status state error: $e');
    }
  }
}
