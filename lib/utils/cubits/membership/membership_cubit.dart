import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mooover/utils/cubits/membership/membership_states.dart';
import 'package:mooover/utils/helpers/logger.dart';
import 'package:mooover/utils/services/group_services.dart';
import 'package:mooover/utils/services/user_services.dart';
import 'package:mooover/utils/services/user_session_services.dart';

class MembershipCubit extends Cubit<MembershipState> {
  MembershipCubit({MembershipState initialState = const MembershipNoState()})
      : super(initialState) {
    load();
  }

  Future<void> load() async {
    emit(const MembershipLoadingState());
    try {
      final group = await UserServices()
          .getGroupOfUser(UserSessionServices().getUserId());
      if (group != null) {
        emit(MembershipLoadedState(group.id));
        logger.d('Membership state loaded: ${group.id}');
      } else {
        emit(const MembershipNoState());
        logger.d('No membership state loaded');
      }
    } catch (e) {
      emit(MembershipErrorState(e.toString()));
      logger.e('Membership error state loaded: $e');
    }
  }

  /// This method is used to join a group.
  Future<void> joinGroup(String groupId) async {
    emit(const MembershipLoadingState());
    try {
      await GroupServices()
          .addMemberToGroup(UserSessionServices().getUserId(), groupId);
      emit(MembershipLoadedState(groupId));
      logger.d('Membership state loaded: $groupId');
    } catch (e) {
      emit(MembershipErrorState(e.toString()));
      logger.e('Membership error state loaded: $e');
    }
  }

  Future<void> leaveGroup() async {
    emit(const MembershipLoadingState());
    try {
      final group = await UserServices()
          .getGroupOfUser(UserSessionServices().getUserId());
      if (group != null) {
        await GroupServices()
            .removeMemberFromGroup(UserSessionServices().getUserId(), group.id);
        emit(const MembershipNoState());
        logger.d('No membership state loaded');
      } else {
        emit(const MembershipErrorState('The user is not part of any group'));
        logger.w(
            'Membership error state loaded: The user is not part of any group');
      }
    } catch (e) {
      emit(MembershipErrorState(e.toString()));
      logger.e('Membership error state loaded: $e');
    }
  }
}
