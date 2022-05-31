import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';
import 'package:mooover/utils/domain/group.dart';
import 'package:mooover/utils/domain/user.dart';
import 'package:mooover/utils/helpers/app_config.dart';
import 'package:mooover/utils/helpers/auth_interceptor.dart';
import 'package:mooover/utils/services/user_session_services.dart';

/// The services for the group entity.
class GroupServices {
  static final _instance = GroupServices._();

  GroupServices._();

  factory GroupServices() => _instance;

  final http.Client httpClient = InterceptedClient.build(interceptors: [
    AuthInterceptor(),
  ]);

  /// Gets the group with the given id.
  Future<Group?> getGroup(String groupId) async {
    final response = (await httpClient.get(
        (AppConfig().groupServicesUrl + '/$groupId').toUri(),
        headers: {'Content-Type': 'application/json'}));
    if (response.statusCode == 200) {
      final group = Group.fromJson(jsonDecode(response.body));
      log('Got group: ${group.toJson()}');
      return group;
    } else {
      log('Failed to get group: ${response.statusCode}');
      return null;
    }
  }

  /// Gets multiple groups, with or without a filter applied
  Future<List<Group>> getGroups({String nicknameFilter = ""}) async {
    if (nicknameFilter.isEmpty) {
      final List<Group> groups = jsonDecode((await httpClient.get(
                  (AppConfig().groupServicesUrl).toUri(),
                  headers: {'Content-Type': 'application/json'}))
              .body)
          .map<Group>((group) => Group.fromJson(group))
          .toList();
      groups.sort((a, b) => a.thisWeekSteps - b.thisWeekSteps);
      log('Got groups: $groups');
      return groups;
    } else {
      final groups = jsonDecode((await httpClient.get(
                  (AppConfig().groupServicesUrl + '?nickname=$nicknameFilter')
                      .toUri(),
                  headers: {'Content-Type': 'application/json'}))
              .body)
          .map<Group>((group) => Group.fromJson(group))
          .toList();
      log('Got groups: $groups');
      return groups;
    }
  }

  Future<void> createGroup(String userId, String nickname, String name) async {
    await httpClient.post((AppConfig().groupServicesUrl).toUri(),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'user_id': userId,
          'nickname': nickname,
          'name': name,
        }));
    log('Created group: $nickname');
  }

  /// Updates the group with the given id.
  Future<void> updateGroup(Group group) async {
    await httpClient.put(
        (AppConfig().groupServicesUrl + '/${group.nickname}').toUri(),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(group.toJson()));
    log('Modified group: ${group.nickname}');
  }

  /// Adds the user with the given [userId] to the group with the given
  /// [nickname].
  Future<void> addMemberToGroup(String userId, String nickname) async {
    await httpClient.put(
        (AppConfig().groupServicesUrl + '/$nickname/members').toUri(),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'user_id': userId}));
    log('Added member to group: $nickname');
  }

  /// Removes the user with the given [userId] from the group with the given
  /// [nickname].
  Future<void> removeMemberFromGroup(String userId, String groupId) async {
    await httpClient.delete(
        (AppConfig().groupServicesUrl + '/$groupId/members/$userId').toUri(),
        headers: {'Content-Type': 'application/json'});
    log('Removed member from group: $groupId');
  }

  Future<List<User>> getMembersOfGroup(String groupId) async {
    var members = jsonDecode((await httpClient.get(
                (AppConfig().groupServicesUrl + '/$groupId/members').toUri(),
                headers: {'Content-Type': 'application/json'}))
            .body)
        .map<User>((member) => User.fromJson(member))
        .toList();
    members = members
        .where((member) => member.id != UserSessionServices().getUserId())
        .toList();
    log('Got members of group: $members');
    return members;
  }
}
