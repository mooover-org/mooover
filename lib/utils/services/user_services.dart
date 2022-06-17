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

  final http.Client _httpClient = InterceptedClient.build(interceptors: [
    AuthInterceptor(),
  ]);

  /// Gets the user with the given [userId].
  Future<User> getUser(String userId) async {
    final response = (await _httpClient.get(
        Uri.http(
            AppConfig().apiDomain, '${AppConfig().userServicesPath}/$userId'),
        headers: {'Content-Type': 'application/json'}));
    if (response.statusCode == 200) {
      final user = User.fromJson(jsonDecode(response.body));
      log('Got user: ${user.toJson()}');
      return user;
    } else {
      throw Exception(
          'Failed to get user: ${jsonDecode(response.body)["detail"]}');
    }
  }

  /// Updates the [user].
  Future<void> updateUser(User user) async {
    final response = await _httpClient.put(
        Uri.http(AppConfig().apiDomain, '${AppConfig().userServicesPath}/${user.sub}'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(user.toJson()));
    if (response.statusCode == 200) {
      log('Modified user: ${user.sub}');
    } else {
      throw Exception(
          'Failed to modify user: ${jsonDecode(response.body)["detail"]}');
    }
  }

  /// Gets the group of the user with the given [userId].
  Future<Group?> getGroupOfUser(String userId) async {
    final response = (await _httpClient.get(
        Uri.http(AppConfig().apiDomain, '${AppConfig().userServicesPath}/$userId/group'),
        headers: {'Content-Type': 'application/json'}));
    if (response.statusCode == 200) {
      final group = Group.fromJson(jsonDecode(response.body));
      log('Got group of user: ${group.toJson()}');
      return group;
    } else if (response.statusCode == 204) {
      log('User has no group');
      return null;
    } else {
      throw Exception(
          'Failed to get group of user: ${jsonDecode(response.body)["detail"]}');
    }
  }
}
