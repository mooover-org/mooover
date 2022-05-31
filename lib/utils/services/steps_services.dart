import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';
import 'package:mooover/utils/helpers/auth_interceptor.dart';
import 'package:mooover/utils/services/user_session_services.dart';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';

/// The services for the steps and pedestrian statuses.
class StepsServices {
  static final _instance = StepsServices._();

  StepsServices._() {
    initPedometer();
  }

  factory StepsServices({Function? hotReloadCallback}) {
    if (hotReloadCallback != null) {
      _instance._hotReloadCallback = hotReloadCallback;
    }
    return _instance;
  }

  final http.Client httpClient = InterceptedClient.build(interceptors: [
    AuthInterceptor(),
  ]);

  final Stream<StepCount> _stepCountStream = Pedometer.stepCountStream;
  final Stream<PedestrianStatus> _pedestrianStatusStream =
      Pedometer.pedestrianStatusStream;
  int _stepCount = 0;
  String _pedestrianStatus = "Unknown";
  DateTime _timeStamp = DateTime.now();
  Function? _hotReloadCallback;

  /// Initialize the pedometer.
  Future<void> initPedometer() async {
    final status = await Permission.activityRecognition.request();
    if (status == PermissionStatus.granted) {
      log("Activity recognition permission granted");
      _stepCountStream.listen(_onStepCount).onError(_onStepCountError);
      _pedestrianStatusStream
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
  void _onStepCount(StepCount event) {
    _stepCount = event.steps;
    if (_timeStamp.difference(event.timeStamp).inSeconds > 3) {
      updateSteps(UserSessionServices().getUserId());
    }
    _timeStamp = event.timeStamp;
  }

  /// What happens when the step counter encounters an error.
  void _onStepCountError(error) {
    log('Step count error: $error');
  }

  /// What happens when the pedestrian status is updated.
  void _onPedestrianStatusChanged(PedestrianStatus event) {
    _pedestrianStatus = event.status;
    _timeStamp = event.timeStamp;
    updateSteps(UserSessionServices().getUserId());
  }

  /// What happens when the pedestrian status encounters an error.
  void _onPedestrianStatusError(error) {
    log('Pedestrian status error: $error');
  }

  /// Get the pedestrian status.
  String getPedestrianStatus() {
    return _pedestrianStatus;
  }

  /// Update the steps on the server and reload the ui state.
  Future<void> updateSteps(String userId) async {
    // TODO: Update the steps on the server.
    log("Steps updated: $_stepCount, $_pedestrianStatus");
    _hotReloadCallback?.call();
  }
}
