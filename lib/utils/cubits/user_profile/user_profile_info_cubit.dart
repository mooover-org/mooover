import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mooover/utils/cubits/user_profile/user_profile_info_states.dart';
import 'package:mooover/utils/domain/user.dart';
import 'package:mooover/utils/services/user_services.dart';
import 'package:mooover/utils/services/user_session_services.dart';

class UserProfileInfoCubit extends Cubit<UserProfileInfoState> {
  UserProfileInfoCubit(
      {UserProfileInfoState initialState = const UserProfileInfoInitialState()})
      : super(initialState) {
    loadUserProfileInfo();
  }

  Future<void> loadUserProfileInfo() async {
    emit(const UserProfileInfoLoadingState());
    try {
      User user =
          await UserServices().getUser(UserSessionServices().getUserId());
      emit(UserProfileInfoLoadedState(user.givenName, user.familyName,
          user.name, user.nickname, user.email, user.picture));
    } catch (e) {
      emit(UserProfileInfoErrorState(e.toString()));
    }
  }
}
