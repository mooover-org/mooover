
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// The base state of the [PedestrianStatusCubit]
@immutable
abstract class PedestrianStatusState extends Equatable {
  const PedestrianStatusState();

  @override
  List<Object> get props => [];
}

/// The loading state of the [PedestrianStatusCubit]
@immutable
class PedestrianStatusLoadingState extends PedestrianStatusState {
  final String message;

  const PedestrianStatusLoadingState({this.message = ''});

  @override
  List<Object> get props => [message];
}

/// The loaded state of the [PedestrianStatusCubit]
@immutable
class PedestrianStatusLoadedState extends PedestrianStatusState {
  final IconData status;

  const PedestrianStatusLoadedState(this.status);

  @override
  List<Object> get props => [status];
}

/// The error state of the [PedestrianStatusCubit]
@immutable
class PedestrianStatusErrorState extends PedestrianStatusState {
  final String message;

  const PedestrianStatusErrorState(this.message);

  @override
  List<Object> get props => [message];
}
