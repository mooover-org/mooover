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
      final profilePicture = (await UserServices().getUser(UserSessionServices().getUserId())).picture;
      emit(DashboardLoadedState(0, 0, profilePicture));
    } catch (e) {
      emit(DashboardErrorState(e.toString()));
    }
  }
}
