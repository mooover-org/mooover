import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mooover/utils/cubits/user_session/user_session_states.dart';
import 'package:mooover/utils/domain/initializable.dart';
import 'package:mooover/utils/services/user_session_services.dart';

/// The user session [Cubit].
///
/// It manages the [UserSessionState] changes.
class UserSessionCubit extends Cubit<UserSessionState> implements Initializable {
  List<Initializable> cubits;

  UserSessionCubit({
    UserSessionState initialState = const UserSessionNoState(),
    this.cubits = const [],
  }) : super(initialState);

  @override
  Future<void> initialize() async {
    await loadLastSession();
  }

  @override
  Future<void> dispose() async {
    await logout();
  }

  /// Performs a last session loading action.
  Future<void> loadLastSession() async {
    emit(const UserSessionLoadingState());
    try {
      await UserSessionServices().loadLastSession();
      Future.wait(cubits.map((cubit) => cubit.initialize()));
      emit(const UserSessionLoadedState());
      log('Last user session loaded');
    } catch (_) {
      emit(const UserSessionNoState());
      log('No last user session found');
    }
  }

  /// Performs a login action.
  Future<void> login() async {
    emit(const UserSessionLoadingState());
    try {
      await UserSessionServices().login();
      Future.wait(cubits.map((cubit) => cubit.initialize()));
      emit(const UserSessionLoadedState());
      log('User session logged in');
    } catch (_) {
      emit(const UserSessionNoState());
      log('User session login failed');
    }
  }

  /// Performs a logout action.
  Future<void> logout() async {
    emit(const UserSessionLoadingState());
    try {
      await UserSessionServices().logout();
      Future.wait(cubits.map((cubit) => cubit.dispose()));
      emit(const UserSessionNoState());
      log('User session logged out');
    } catch (_) {
      if (UserSessionServices().liveUserSession()) {
        emit(const UserSessionLoadedState());
        log('User session still logged in');
      } else {
        emit(const UserSessionNoState());
        log('User session logout failed');
      }
    }
  }
}
