import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';
import 'package:mooover/utils/domain/group.dart';
import 'package:mooover/utils/domain/observer.dart';
import 'package:mooover/utils/domain/user.dart';
import 'package:mooover/utils/helpers/app_config.dart';
import 'package:mooover/utils/helpers/auth_interceptor.dart';
import 'package:mooover/utils/helpers/logger.dart';
import 'package:mooover/utils/helpers/operations.dart';

/// The services for the group entity.
class GroupServices extends Observable {
  static final _instance = GroupServices._();

  GroupServices._();

  factory GroupServices() => _instance;

  final http.Client _httpClient = InterceptedClient.build(interceptors: [
    AuthInterceptor(),
  ]);

  /// Gets the group with the given [groupId].
  Future<Group> getGroup(String groupId) async {
    logger.d('Getting group with id $groupId');
    try {
      final response = await (() => _httpClient.get(
          Uri.http(AppConfig().apiDomain,
              '${AppConfig().groupServicesPath}/$groupId'),
          headers: {'Content-Type': 'application/json'})).withRetries(3);
      if (response.statusCode == 200) {
        final group = Group.fromJson(jsonDecode(response.body));
        logger.d('Got group with id $groupId');
        return group;
      } else {
        logger.e('Failed to get group with id $groupId');
        throw Exception(
            'Failed to get group: ${jsonDecode(response.body)["detail"]}');
      }
    } on HttpException catch (e) {
      logger.e('Failed to get group with id $groupId', e);
      throw Exception('Failed to get group: $e');
    }
  }

  /// Gets multiple groups, with or without a [nickname] filter applied
  Future<List<Group>> getGroups(
      {String nickname = "", bool orderedBySteps = false}) async {
    Map<String, String> params = {};
    if (nickname.isNotEmpty) {
      params["nickname"] = nickname;
    }
    if (orderedBySteps) {
      params["ordered_by_steps"] = orderedBySteps.toString();
    }
    logger.d('Getting groups with params $params');
    try {
      final response = await (() => _httpClient.get(
          Uri.http(
              AppConfig().apiDomain, AppConfig().groupServicesPath, params),
          headers: {'Content-Type': 'application/json'})).withRetries(3);
      if (response.statusCode == 200) {
        final List<Group> groups = jsonDecode(response.body)
            .map<Group>((group) => Group.fromJson(group))
            .toList();
        logger.d('Got groups with params $params');
        return groups;
      } else {
        logger.e('Failed to get groups with params $params');
        throw Exception(
            'Failed to get groups: ${jsonDecode(response.body)["detail"]}');
      }
    } on HttpException catch (e) {
      logger.e('Failed to get groups with params $params', e);
      throw Exception('Failed to get groups: $e');
    }
  }

  /// Creates a new group with the given [nickname] and [name] and adds the
  /// user with [userId] to it.
  Future<void> createGroup(String userId, String nickname, String name) async {
    logger.d('Creating group with nickname $nickname and name $name');
    try {
      final response = await (() => _httpClient.post(
          Uri.http(AppConfig().apiDomain, AppConfig().groupServicesPath),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'user_id': userId,
            'nickname': nickname,
            'name': name,
          }))).withRetries(3);
      if (response.statusCode == 201) {
        logger.d('Created group with nickname $nickname and name $name');
        notifyObservers();
      } else {
        logger
            .e('Failed to create group with nickname $nickname and name $name');
        throw Exception(
            'Failed to create group: ${jsonDecode(response.body)["detail"]}');
      }
    } on HttpException catch (e) {
      logger.e(
          'Failed to create group with nickname $nickname and name $name', e);
      throw Exception('Failed to create group: $e');
    }
  }

  /// Updates the [group].
  Future<void> updateGroup(Group group) async {
    logger.d('Updating group ${group.id}');
    try {
      final response = await (() => _httpClient.put(
          Uri.http(AppConfig().apiDomain,
              '${AppConfig().groupServicesPath}/${group.nickname}'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(group.toJson()))).withRetries(3);
      if (response.statusCode == 200) {
        logger.d('Updated group ${group.id}');
        notifyObservers();
      } else {
        logger.e('Failed to update group ${group.id}');
        throw Exception(
            'Failed to update group: ${jsonDecode(response.body)["detail"]}');
      }
    } on HttpException catch (e) {
      logger.e('Failed to update group ${group.id}', e);
      throw Exception('Failed to update group: $e');
    }
  }

  /// Adds the user with the given [userId] to the group with the given
  /// [nickname].
  Future<void> addMemberToGroup(String userId, String nickname) async {
    logger.d('Adding user with id $userId to group with nickname $nickname');
    try {
      final response = await (() => _httpClient.put(
          Uri.http(AppConfig().apiDomain,
              '${AppConfig().groupServicesPath}/$nickname/members'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'user_id': userId}))).withRetries(3);
      if (response.statusCode == 200) {
        logger.d('Added user with id $userId to group with nickname $nickname');
        notifyObservers();
      } else {
        logger.e(
            'Failed to add user with id $userId to group with nickname $nickname');
        throw Exception(
            'Failed to add member to group: ${jsonDecode(response.body)["detail"]}');
      }
    } on HttpException catch (e) {
      logger.e(
          'Failed to add user with id $userId to group with nickname $nickname',
          e);
      throw Exception('Failed to add member to group: $e');
    }
  }

  /// Removes the user with the given [userId] from the group with the given
  /// [groupId].
  Future<void> removeMemberFromGroup(String userId, String groupId) async {
    logger.d('Removing user with id $userId from group with id $groupId');
    try {
      final response = await (() => _httpClient.delete(
          Uri.http(AppConfig().apiDomain,
              '${AppConfig().groupServicesPath}/$groupId/members/$userId'),
          headers: {'Content-Type': 'application/json'})).withRetries(3);
      if (response.statusCode == 200) {
        logger.d('Removed user with id $userId from group with id $groupId');
        notifyObservers();
      } else {
        logger.e(
            'Failed to remove user with id $userId from group with id $groupId');
        throw Exception(
            'Failed to remove member from group: ${jsonDecode(response.body)["detail"]}');
      }
    } on HttpException catch (e) {
      logger.e(
          'Failed to remove user with id $userId from group with id $groupId',
          e);
      throw Exception('Failed to remove member from group: $e');
    }
  }

  /// Gets the members of the group with the given [groupId].
  Future<List<User>> getMembersOfGroup(String groupId,
      {bool orderedBySteps = false}) async {
    Map<String, String> params = {};
    if (orderedBySteps) {
      params["ordered_by_steps"] = orderedBySteps.toString();
    }
    logger.d('Getting members of group with id $groupId and params $params');
    try {
      final response = await (() => _httpClient.get(
          Uri.http(AppConfig().apiDomain,
              '${AppConfig().groupServicesPath}/$groupId/members', params),
          headers: {'Content-Type': 'application/json'})).withRetries(3);
      if (response.statusCode == 200) {
        var members = jsonDecode(response.body)
            .map<User>((member) => User.fromJson(member))
            .toList();
        logger.d('Got members of group with id $groupId and params $params');
        return members;
      } else {
        logger.e(
            'Failed to get members of group with id $groupId and params $params');
        throw Exception(
            'Failed to get members of group: ${jsonDecode(response.body)["detail"]}');
      }
    } on HttpException catch (e) {
      logger.e(
          'Failed to get members of group with id $groupId and params $params',
          e);
      throw Exception('Failed to get members of group: $e');
    }
  }
}
