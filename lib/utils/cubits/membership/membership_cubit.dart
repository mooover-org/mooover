import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mooover/utils/cubits/membership/membership_states.dart';
import 'package:mooover/utils/domain/group.dart';
import 'package:mooover/utils/helpers/logger.dart';
import 'package:mooover/utils/services/group_services.dart';
import 'package:mooover/utils/services/user_services.dart';
import 'package:mooover/utils/services/user_session_services.dart';

class MembershipCubit extends Cubit<MembershipState> {
  MembershipCubit(
      {MembershipState initialState = const MembershipLoadingState()})
      : super(initialState) {
    loadMembership();
  }

  Future<void> loadMembership() async {
    emit(const MembershipLoadingState());
    logger.d('Membership state loading');
    try {
      final group = await UserServices()
          .getGroupOfUser(UserSessionServices().getUserId());
      if (group != null) {
        emit(MembershipLoadedState(group.id));
        logger.d('Membership state loaded: ${group.id}');
      } else {
        final groups = await GroupServices().getGroups();
        emit(MembershipNoState(
            groups.map((Group group) => group.id).toList()));
        logger.d('Membership state loaded: no group');
      }
    } catch (e) {
      emit(MembershipErrorState(e.toString()));
      logger.e('Membership state error: $e');
    }
  }

  /// This method is used to create a new group.
  Future<void> createGroup(String nickname, String name) async {
    emit(const MembershipLoadingState());
    logger.d('Membership state loading');
    try {
      await GroupServices()
          .createGroup(UserSessionServices().getUserId(), nickname, name);
      emit(MembershipLoadedState(nickname));
      logger.d('Membership state changed: $nickname created');
    } catch (e) {
      emit(MembershipErrorState(e.toString()));
      logger.e('Membership state error: $e');
    }
  }

  /// This method is used to join a group.
  Future<void> joinGroup(String groupId) async {
    emit(const MembershipLoadingState());
    logger.d('Membership state loading');
    try {
      await GroupServices()
          .addMemberToGroup(UserSessionServices().getUserId(), groupId);
      emit(MembershipLoadedState(groupId));
      logger.d('Membership state changed: $groupId joined');
    } catch (e) {
      emit(MembershipErrorState(e.toString()));
      logger.e('Membership state error: $e');
    }
  }

  Future<void> leaveGroup() async {
    emit(const MembershipLoadingState());
    logger.d('Membership state loading');
    try {
      final group = await UserServices()
          .getGroupOfUser(UserSessionServices().getUserId());
      if (group != null) {
        await GroupServices()
            .removeMemberFromGroup(UserSessionServices().getUserId(), group.id);
        final groups = await GroupServices().getGroups();
        emit(MembershipNoState(
            groups.map((Group group) => group.id).toList()));
        logger.d('Membership state changed: left group');
      } else {
        emit(const MembershipErrorState('The user is not part of any group'));
        logger.e('Membership state error: The user is not part of any group');
      }
    } catch (e) {
      emit(MembershipErrorState(e.toString()));
      logger.e('Membership state error: $e');
    }
  }
}
