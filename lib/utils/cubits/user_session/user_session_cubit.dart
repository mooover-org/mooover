import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mooover/utils/cubits/user_session/user_session_states.dart';
import 'package:mooover/utils/services/user_session_services.dart';

/// The user session [Cubit].
///
/// It manages the [UserSessionState] changes.
class UserSessionCubit extends Cubit<UserSessionState> {
  UserSessionCubit({initialState})
      : super(initialState ?? const UserSessionInitialState()) {
    if (!UserSessionServices().isLoggedIn()) {
      loadLastSession();
    }
  }

  /// Performs a last session loading action.
  Future<void> loadLastSession() async {
    emit(const UserSessionLoadingState());
    try {
      await UserSessionServices().loadLastSession();
      emit(const UserSessionValidState());
    } catch (_) {
      emit(const UserSessionNoState());
    }
  }

  /// Performs a login action.
  Future<void> login() async {
    emit(const UserSessionLoadingState());
    try {
      await UserSessionServices().login();
      emit(const UserSessionValidState());
    } catch (_) {
      emit(const UserSessionNoState());
    }
  }

  /// Performs a logout action.
  Future<void> logout() async {
    emit(const UserSessionLoadingState());
    try {
      await UserSessionServices().logout();
      emit(const UserSessionNoState());
    } catch (_) {
      if (UserSessionServices().isLoggedIn()) {
        emit(const UserSessionValidState());
      } else {
        emit(const UserSessionNoState());
      }
    }
  }
}
