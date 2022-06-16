import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';
import 'package:mooover/utils/domain/group.dart';
import 'package:mooover/utils/domain/user.dart';
import 'package:mooover/utils/helpers/app_config.dart';
import 'package:mooover/utils/helpers/auth_interceptor.dart';

/// The services for the group entity.
class GroupServices {
  static final _instance = GroupServices._();

  GroupServices._();

  factory GroupServices() => _instance;

  final http.Client _httpClient = InterceptedClient.build(interceptors: [
    AuthInterceptor(),
  ]);

  /// Gets the group with the given [groupId].
  Future<Group> getGroup(String groupId) async {
    final response = (await _httpClient.get(
        (AppConfig().groupServicesUrl + '/$groupId').toUri(),
        headers: {'Content-Type': 'application/json'}));
    if (response.statusCode == 200) {
      final group = Group.fromJson(jsonDecode(response.body));
      log('Got group: ${group.toJson()}');
      return group;
    } else {
      throw Exception(
          'Failed to get group: ${jsonDecode(response.body)["detail"]}');
    }
  }

  /// Gets multiple groups, with or without a [nicknameFilter] applied
  Future<List<Group>> getGroups({String nicknameFilter = ""}) async {
    final response = (await _httpClient.get(
        (AppConfig().groupServicesUrl +
                (nicknameFilter == '' ? '' : '?nickname=$nicknameFilter'))
            .toUri(),
        headers: {'Content-Type': 'application/json'}));
    if (response.statusCode == 200) {
      final List<Group> groups = jsonDecode(response.body)
          .map<Group>((group) => Group.fromJson(group))
          .toList();
      if (nicknameFilter == '') {
        groups.sort((a, b) => a.thisWeekSteps - b.thisWeekSteps);
      }
      log('Got groups: $groups');
      return groups;
    } else {
      throw Exception(
          'Failed to get groups: ${jsonDecode(response.body)["detail"]}');
    }
  }

  /// Creates a new group with the given [nickname] and [name] and adds the
  /// user with [userId] to it.
  Future<void> createGroup(String userId, String nickname, String name) async {
    final response =
        await _httpClient.post((AppConfig().groupServicesUrl).toUri(),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'user_id': userId,
              'nickname': nickname,
              'name': name,
            }));
    if (response.statusCode == 201) {
      log('Created group: $nickname');
    } else {
      throw Exception(
          'Failed to create group: ${jsonDecode(response.body)["detail"]}');
    }
  }

  /// Updates the [group].
  Future<void> updateGroup(Group group) async {
    final response = await _httpClient.put(
        (AppConfig().groupServicesUrl + '/${group.nickname}').toUri(),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(group.toJson()));
    if (response.statusCode == 200) {
      log('Modified group: ${group.nickname}');
    } else {
      throw Exception(
          'Failed to modify group: ${jsonDecode(response.body)["detail"]}');
    }
  }

  /// Adds the user with the given [userId] to the group with the given
  /// [nickname].
  Future<void> addMemberToGroup(String userId, String nickname) async {
    final response = await _httpClient.put(
        (AppConfig().groupServicesUrl + '/$nickname/members').toUri(),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'user_id': userId}));
    if (response.statusCode == 200) {
      log('Added member to group: $nickname');
    } else {
      throw Exception(
          'Failed to add member to group: ${jsonDecode(response.body)["detail"]}');
    }
  }

  /// Removes the user with the given [userId] from the group with the given
  /// [groupId].
  Future<void> removeMemberFromGroup(String userId, String groupId) async {
    final response = await _httpClient.delete(
        (AppConfig().groupServicesUrl + '/$groupId/members/$userId').toUri(),
        headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      log('Removed member from group: $groupId');
    } else {
      throw Exception(
          'Failed to remove member from group: ${jsonDecode(response.body)["detail"]}');
    }
  }

  /// Gets the members of the group with the given [groupId].
  Future<List<User>> getMembersOfGroup(String groupId) async {
    final response = (await _httpClient.get(
        (AppConfig().groupServicesUrl + '/$groupId/members').toUri(),
        headers: {'Content-Type': 'application/json'}));
    if (response.statusCode == 200) {
      var members = jsonDecode(response.body)
          .map<User>((member) => User.fromJson(member))
          .toList();
      log('Got members of group: $members');
      return members;
    } else {
      throw Exception(
          'Failed to get members of group: ${jsonDecode(response.body)["detail"]}');
    }
  }
}
