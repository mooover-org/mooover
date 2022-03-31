import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mooover/utils/cubits/user_session/user_session_states.dart';
import 'package:mooover/utils/services/user_session_services.dart';

/// The user session [Cubit].
///
/// It manages the [UserSessionState] changes.
class UserSessionCubit extends Cubit<UserSessionState> {
  UserSessionCubit({initialState})
      : super(initialState ?? const InitialUserSessionState());

  /// Performs a last session loading action.
  Future<void> loadLastSession() async {
    emit(const LoadingUserSessionState());
    try {
      await UserSessionServices().loadLastSession();
      emit(const ValidUserSessionState());
    } catch (_) {
      emit(const NoUserSessionState());
    }
  }

  /// Performs a login action.
  Future<void> login() async {
    emit(const LoadingUserSessionState());
    try {
      await UserSessionServices().login();
      emit(const ValidUserSessionState());
    } catch (_) {
      emit(const NoUserSessionState());
    }
  }

  /// Performs a logout action.
  Future<void> logout() async {
    emit(const LoadingUserSessionState());
    try {
      await UserSessionServices().logout();
      emit(const NoUserSessionState());
    } catch (_) {
      emit(const ValidUserSessionState());
    }
  }
}
