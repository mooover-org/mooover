import 'dart:developer';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mooover/utils/cubits/dashboard/dashboard_states.dart';

/// A [Cubit] that handles the states of the [Dashboard].
class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit({DashboardState initialState = const DashboardInitialState()})
      : super(initialState);

  /// Performs a loading data action.
  Future<void> loadData() async {
    emit(const DashboardLoadingState());
    log('Loading data...');
    sleep(const Duration(seconds: 1));
    emit(const DashboardLoadedState(1000, 10, 'Adrian Pop'));
    log('Data loaded.');
  }
}
