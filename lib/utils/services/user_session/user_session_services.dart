import 'package:mooover/utils/domain/user.dart';

class UserSessionServices {
  static final _instance = UserSessionServices._();

  User? loggedUser;

  UserSessionServices._();

  factory UserSessionServices() => _instance;
}
