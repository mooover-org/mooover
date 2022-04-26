import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mooover/utils/cubits/dashboard/dashboard_states.dart';
import 'package:mooover/utils/services/user_services.dart';
import 'package:mooover/utils/services/user_session_services.dart';

/// A [Cubit] that handles the states of the [Dashboard].
class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit({DashboardState initialState = const DashboardInitialState()})
      : super(initialState);

  /// Performs a loading data action.
  Future<void> loadData() async {
    emit(const DashboardLoadingState());
    try {
      final steps = await UserServices().getUserSteps(UserSessionServices().getUserId());
      final heartPoints = await UserServices().getUserHeartPoints(UserSessionServices().getUserId());
      final name = (await UserServices().getUser(UserSessionServices().getUserId())).name;
      emit(DashboardLoadedState(steps, heartPoints, name));
    } catch (e) {
      emit(DashboardErrorState(e.toString()));
    }
  }
}
