import 'dart:convert';
import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';
import 'package:mooover/utils/helpers/app_config.dart';
import 'package:mooover/utils/helpers/auth_interceptor.dart';
import 'package:mooover/utils/services/user_session_services.dart';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';

/// The services for the steps and pedestrian statuses.
class StepsServices {
  static final _instance = StepsServices._();

  StepsServices._() {
    _initPedometer();
  }

  factory StepsServices({Function? hotReloadCallback}) {
    if (hotReloadCallback != null) {
      _instance._hotReloadCallback = hotReloadCallback;
    }
    return _instance;
  }

  final http.Client _httpClient = InterceptedClient.build(interceptors: [
    AuthInterceptor(),
  ]);
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  int _stepCount = 0;
  String _pedestrianStatus = "Unknown";
  DateTime _timeStamp = DateTime.now();
  Function? _hotReloadCallback;

  /// Initialize the pedometer.
  Future<void> _initPedometer() async {
    final status = await Permission.activityRecognition.request();
    if (status == PermissionStatus.granted) {
      log("Activity recognition permission granted");
      Pedometer.stepCountStream
          .listen(_onStepCountChanged)
          .onError(_onStepCountError);
      Pedometer.pedestrianStatusStream
          .listen(_onPedestrianStatusChanged)
          .onError(_onPedestrianStatusError);
      log("Step counter service started");
    } else if (status == PermissionStatus.denied) {
      log('Permission denied');
    } else if (status == PermissionStatus.permanentlyDenied) {
      log('Permission permanently denied');
    } else if (status == PermissionStatus.restricted) {
      log('Permission restricted');
    } else if (status == PermissionStatus.limited) {
      log('Permission limited');
    }
  }

  /// What happens when the step counter is updated.
  void _onStepCountChanged(StepCount event) {
    _stepCount = event.steps;
    log('Time difference: ${event.timeStamp.difference(_timeStamp).inSeconds}');
    if (event.timeStamp.difference(_timeStamp).inSeconds >
        AppConfig().stepsUpdateInterval) {
      _timeStamp = event.timeStamp;
      _updateSteps();
    }
  }

  /// What happens when the step counter encounters an error.
  void _onStepCountError(error) {
    log('Step count error: $error');
  }

  /// What happens when the pedestrian status is updated.
  void _onPedestrianStatusChanged(PedestrianStatus event) {
    _pedestrianStatus = event.status;
    log('Time difference: ${event.timeStamp.difference(_timeStamp).inSeconds}');
    if (event.timeStamp.difference(_timeStamp).inSeconds >
        AppConfig().stepsUpdateInterval) {
      _timeStamp = event.timeStamp;
      _updateSteps();
    }
  }

  /// What happens when the pedestrian status encounters an error.
  void _onPedestrianStatusError(error) {
    log('Pedestrian status error: $error');
  }

  /// Update the steps on the server and reload the ui state.
  Future<void> _updateSteps() async {
    try {
      final lastStepsCountString =
          await _secureStorage.read(key: AppConfig().lastStepsCountKey);
      if (lastStepsCountString != null) {
        log("Last steps count: $lastStepsCountString");
        final lastStepsCount = int.parse(lastStepsCountString);
        if (lastStepsCount > _stepCount) {
          log("Steps count has been reset, updating with new value");
          await _secureStorage.write(
              key: AppConfig().lastStepsCountKey, value: _stepCount.toString());
        } else {
          final newStepsCount = _stepCount - lastStepsCount;
          log("New steps count to post: $newStepsCount");
          await _httpClient.post(
              Uri.http(AppConfig().apiDomain,
                  '${AppConfig().stepsServicesPath}/${UserSessionServices().getUserId()}'),
              headers: {'Content-Type': 'application/json'},
              body: jsonEncode({
                'steps': newStepsCount,
              }));
          log('Posted new steps: $newStepsCount');
          await _secureStorage.write(
              key: AppConfig().lastStepsCountKey, value: _stepCount.toString());
          log('Updated last steps count: $_stepCount');
        }
      } else {
        log("No last steps count");
        await _secureStorage.write(
            key: AppConfig().lastStepsCountKey, value: _stepCount.toString());
      }
    } catch (error) {
      log('Error updating steps: $error');
    }
    log("Steps updated: $_stepCount, $_pedestrianStatus");
    _hotReloadCallback?.call();
  }

  /// Get the pedestrian status.
  String getPedestrianStatus() {
    return _pedestrianStatus;
  }
}
