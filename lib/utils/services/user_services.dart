import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';
import 'package:mooover/utils/domain/group.dart';
import 'package:mooover/utils/domain/user.dart';
import 'package:mooover/utils/helpers/app_config.dart';
import 'package:mooover/utils/helpers/auth_interceptor.dart';

/// The services for the user entity.
class UserServices {
  static final _instance = UserServices._();

  UserServices._();

  factory UserServices() => _instance;

  final http.Client httpClient = InterceptedClient.build(interceptors: [
    AuthInterceptor(),
  ]);

  /// Gets the user with the given id.
  Future<User> getUser(String userId) async {
    final user = User.fromJson(jsonDecode((await httpClient.get(
            (AppConfig().userServicesUrl + '/$userId').toUri(),
            headers: {'Content-Type': 'application/json'}))
        .body));
    log('Got user: ${user.toJson()}');
    return user;
  }

  /// Updates the user with the given id.
  Future<void> updateUser(User user) async {
    await httpClient.put((AppConfig().userServicesUrl + '/${user.sub}').toUri(),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(user.toJson()));
    log('Modified user: ${user.sub}');
  }

  /// Gets the group of the user with the given id.
  Future<Group?> getGroupOfUser(String userId) async {
    final response = (await httpClient.get(
        (AppConfig().userServicesUrl + '/$userId/group').toUri(),
        headers: {'Content-Type': 'application/json'}));
    if (response.statusCode == 200) {
      final group = Group.fromJson(jsonDecode(response.body));
      log('Got group of user: ${group.toJson()}');
      return group;
    } else if (response.statusCode == 204) {
      log('User has no group');
      return null;
    } else {
      log('Failed to get group of user: ${response.statusCode}');
      throw Exception('Failed to get group of user');
    }
  }
}
