import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';
import 'package:mooover/utils/domain/observer.dart';
import 'package:mooover/utils/helpers/app_config.dart';
import 'package:mooover/utils/helpers/auth_interceptor.dart';
import 'package:mooover/utils/helpers/logger.dart';
import 'package:mooover/utils/helpers/operations.dart';
import 'package:mooover/utils/services/user_session_services.dart';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';

/// The services for the steps and pedestrian statuses.
class StepsServices extends Observable {
  static final _instance = StepsServices._();

  StepsServices._() {
    _initPedometer();
  }

  factory StepsServices() => _instance;

  final http.Client _httpClient = InterceptedClient.build(interceptors: [
    AuthInterceptor(),
  ]);
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  int _stepCount = 0;
  String _pedestrianStatus = "unknown";
  DateTime _timeStamp = DateTime.now();

  /// Get the pedestrian status.
  String getPedestrianStatus() {
    logger.d("Getting pedestrian status");
    return _pedestrianStatus;
  }

  /// Initialize the pedometer.
  Future<void> _initPedometer() async {
    logger.d("Initializing pedometer");
    final status = await Permission.activityRecognition.request();
    if (status == PermissionStatus.granted) {
      logger.i("Pedometer permissions granted");
      Pedometer.stepCountStream
          .listen(_onStepCountChanged)
          .onError(_onStepCountError);
      logger.d("Listening to step count stream");
      Pedometer.pedestrianStatusStream
          .listen(_onPedestrianStatusChanged)
          .onError(_onPedestrianStatusError);
      logger.d("Listening to pedestrian status stream");
    } else if (status == PermissionStatus.denied) {
      logger.w("Pedometer permissions denied");
    } else if (status == PermissionStatus.permanentlyDenied) {
      logger.w("Pedometer permissions permanently denied");
    } else if (status == PermissionStatus.restricted) {
      logger.w("Pedometer permissions restricted");
    } else if (status == PermissionStatus.limited) {
      logger.w("Pedometer permissions limited");
    } else {
      logger.w("Pedometer permissions unknown");
    }
  }

  /// What happens when the step counter is updated.
  void _onStepCountChanged(StepCount event) {
    logger.d("Step count changed: ${event.steps}");
    _stepCount = event.steps;
    if (event.timeStamp.difference(_timeStamp).inSeconds >
        AppConfig().stepsUpdateInterval) {
      logger.d(
          "Updating steps after ${event.timeStamp.difference(_timeStamp).inSeconds} seconds");
      _timeStamp = event.timeStamp;
      _updateSteps();
    }
  }

  /// What happens when the step counter encounters an error.
  void _onStepCountError(error) {
    logger.e("Step count error: $error");
  }

  /// What happens when the pedestrian status is updated.
  void _onPedestrianStatusChanged(PedestrianStatus event) {
    logger.d("Pedestrian status changed: ${event.status}");
    _pedestrianStatus = event.status;
    _updatePedestrianStatus();
  }

  /// What happens when the pedestrian status encounters an error.
  void _onPedestrianStatusError(error) {
    logger.e("Pedestrian status error: $error");
  }

  /// Update the steps on the server and reload the ui state.
  Future<void> _updateSteps() async {
    logger.d("Updating steps");
    try {
      final lastStepsCountString =
          await _secureStorage.read(key: AppConfig().lastStepsCountKey);
      if (lastStepsCountString != null) {
        logger.d("Last steps count: $lastStepsCountString");
        final lastStepsCount = int.parse(lastStepsCountString);
        if (lastStepsCount > _stepCount) {
          logger.d("Steps count has been reset, updating with new value");
          await _secureStorage.write(
              key: AppConfig().lastStepsCountKey, value: _stepCount.toString());
        } else {
          final newStepsCount = _stepCount - lastStepsCount;
          logger.d("New steps count to post: $newStepsCount");
          try {
            await _httpClient.post(
                Uri.http(AppConfig().apiDomain,
                    '${AppConfig().stepsServicesPath}/${UserSessionServices().getUserId()}'),
                headers: {'Content-Type': 'application/json'},
                body: jsonEncode({
                  'steps': newStepsCount,
                }));
            logger.d('Posted new steps: $newStepsCount');
            await _secureStorage.write(
                key: AppConfig().lastStepsCountKey,
                value: _stepCount.toString());
            logger.d('Updated last steps count: $_stepCount');
          } on HttpException catch (e) {
            logger.e("Error posting steps: $newStepsCount", e);
          }
        }
      } else {
        logger.d("No last steps count");
        await _secureStorage.write(
            key: AppConfig().lastStepsCountKey, value: _stepCount.toString());
      }
    } catch (error) {
      logger.e("Error updating steps: $error");
    }
    notifyObservers();
    logger.i("Steps updated: $_stepCount");
  }

  void _updatePedestrianStatus() {
    logger.d("Updating pedestrian status");
    logger.i("Pedestrian status updated: $_pedestrianStatus");
    notifyObservers();
  }

  Future<Map<String, int>> getUserSteps(String userId) async {
    logger.d("Getting user steps");
    try {
      final response = await (() => _httpClient.get(Uri.http(
          AppConfig().apiDomain,
          '${AppConfig().userServicesPath}/$userId/steps'))).withRetries(3);
      if (response.statusCode == 200) {
        final todaySteps = json.decode(response.body)['today_steps'];
        final thisWeekSteps = json.decode(response.body)['this_week_steps'];
        logger.d("User steps: $todaySteps, $thisWeekSteps");
        return {
          'today_steps': todaySteps,
          'this_week_steps': thisWeekSteps,
        };
      } else {
        logger.e("Error getting user steps: ${response.body}");
        throw Exception(
            "Failed to get user steps: ${jsonDecode(response.body)['detail']}");
      }
    } on HttpException catch (e) {
      logger.e("Error getting user steps", e);
      throw Exception("Error getting user steps: $e");
    }
  }

  Future<Map<String, int>> getGroupSteps(String groupId) async {
    logger.d("Getting group steps");
    try {
      final response = await (() => _httpClient.get(Uri.http(
          AppConfig().apiDomain,
          '${AppConfig().groupServicesPath}/$groupId/steps'))).withRetries(3);
      if (response.statusCode == 200) {
        final todaySteps = json.decode(response.body)['today_steps'];
        final thisWeekSteps = json.decode(response.body)['this_week_steps'];
        logger.d("Group steps: $todaySteps, $thisWeekSteps");
        return {
          'today_steps': todaySteps,
          'this_week_steps': thisWeekSteps,
        };
      } else {
        logger.e("Error getting group steps: ${response.body}");
        throw Exception(
            "Failed to get group steps: ${jsonDecode(response.body)['detail']}");
      }
    } on HttpException catch (e) {
      logger.e("Error getting group steps", e);
      throw Exception("Error getting group steps: $e");
    }
  }
}
