import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mooover/utils/cubits/user_session/user_session_states.dart';
import 'package:mooover/utils/helpers/logger.dart';
import 'package:mooover/utils/services/user_session_services.dart';

/// The user session [Cubit].
///
/// It manages the [UserSessionState] changes.
class UserSessionCubit extends Cubit<UserSessionState> {
  UserSessionCubit({
    UserSessionState initialState = const UserSessionNoState(),
  }) : super(initialState) {
    loadLastSession();
  }

  /// Performs a last session loading action.
  Future<void> loadLastSession() async {
    emit(const UserSessionLoadingState());
    logger.d('User session state loading');
    try {
      await UserSessionServices().loadLastSession();
      emit(const UserSessionLoadedState());
      logger.d('User session state loaded');
    } catch (_) {
      emit(const UserSessionNoState());
      logger.d('User session state loaded: no session');
    }
  }

  /// Performs a login action.
  Future<void> login() async {
    emit(const UserSessionLoadingState());
    logger.d('User session state loading');
    try {
      await UserSessionServices().login();
      emit(const UserSessionLoadedState());
      logger.d('User session state loaded');
    } catch (_) {
      emit(const UserSessionNoState());
      logger.d('User session state loaded: no session');
    }
  }

  /// Performs a logout action.
  Future<void> logout() async {
    emit(const UserSessionLoadingState());
    logger.d('User session state loading');
    try {
      await UserSessionServices().logout();
      emit(const UserSessionNoState());
      logger.d('User session state loaded: no session');
    } catch (_) {
      if (UserSessionServices().liveUserSession()) {
        emit(const UserSessionLoadedState());
        logger.d('User session state loaded');
      } else {
        emit(const UserSessionNoState());
        logger.d('User session state loaded: no session');
      }
    }
  }
}
