import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';
import 'package:mooover/utils/helpers/app_config.dart';
import 'package:mooover/utils/domain/user.dart';
import 'package:mooover/utils/helpers/auth_interceptor.dart';

class UserServices {
  static final _instance = UserServices._();

  UserServices._();

  factory UserServices() => _instance;

  final http.Client httpClient = InterceptedClient.build(interceptors: [
    AuthInterceptor(),
  ]);

  Future<User> getUser(String userId) async {
    final user = User.fromJson(jsonDecode((await httpClient.get(
            (AppConfig().userServicesUrl + '/$userId').toUri(),
            headers: {'Content-Type': 'application/json'}))
        .body));
    log('Got user: ${user.toJson()}');
    return user;
  }

  Future<int> getUserSteps(String userId) async {
    final steps = (await httpClient.get(
            (AppConfig().userServicesUrl + '/$userId/steps').toUri(),
            headers: {'Content-Type': 'application/json'}))
        .body;
    log('Got user steps: $steps');
    return int.parse(steps);
  }

  Future<int> getUserHeartPoints(String userId) async {
    final heartPoints = (await httpClient.get(
            (AppConfig().userServicesUrl + '/$userId/heartPoints').toUri(),
            headers: {'Content-Type': 'application/json'}))
        .body;
    log('Got user heart points: $heartPoints');
    return int.parse(heartPoints);
  }
}
