import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mooover/utils/cubits/groups/groups_states.dart';
import 'package:mooover/utils/domain/observer.dart';
import 'package:mooover/utils/helpers/logger.dart';
import 'package:mooover/utils/services/group_services.dart';

class GroupsCubit extends Cubit<GroupsState> implements Observer {
  GroupsCubit(
      {GroupsState initialState =
          const GroupsErrorState('No groups available')})
      : super(initialState) {
    loadGroups();
    GroupServices().addObserver(this);
  }

  @override
  Future<void> close() {
    GroupServices().removeObserver(this);
    return super.close();
  }

  @override
  void update() {
    reloadGroups();
  }

  /// This method is used to load the groups.
  Future<void> loadGroups() async {
    emit(const GroupsLoadingState());
    logger.d('Groups state loading');
    try {
      final groups = await GroupServices().getGroups();
      emit(GroupsLoadedState(groups));
      logger.d('Groups state loaded: $groups');
    } catch (e) {
      emit(GroupsErrorState(e.toString()));
      logger.e('Groups state error: $e');
    }
  }

  /// This method is used to reload the groups.
  Future<void> reloadGroups() async {
    logger.d('Groups state reloading');
    try {
      final groups = await GroupServices().getGroups();
      emit(GroupsLoadedState(groups));
      logger.d('Groups state reloaded: $groups');
    } catch (e) {
      emit(GroupsErrorState(e.toString()));
      logger.e('Groups state error: $e');
    }
  }

  /// This method is used to filter the groups by their nickname.
  Future<void> filterGroups(String nickname) async {
    emit(const GroupsLoadingState());
    logger.d('Groups state loading');
    try {
      final groups = await GroupServices().getGroups(nickname: nickname);
      emit(GroupsLoadedState(groups));
      logger.d('Groups state changed: $groups');
    } catch (e) {
      emit(GroupsErrorState(e.toString()));
      logger.e('Groups state error: $e');
    }
  }
}
