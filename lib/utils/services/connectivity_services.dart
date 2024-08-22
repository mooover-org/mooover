import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';
import 'package:mooover/utils/helpers/app_config.dart';
import 'package:mooover/utils/helpers/auth_interceptor.dart';
import 'package:mooover/utils/helpers/logger.dart';
import 'package:mooover/utils/helpers/operations.dart';

/// The connectivity services.
///
/// It handles the pinging and other connectivity related tasks.
class ConnectivityServices {
  static final _instance = ConnectivityServices._();

  ConnectivityServices._();

  factory ConnectivityServices() => _instance;

  final http.Client _httpClient = InterceptedClient.build(interceptors: [
    AuthInterceptor(),
  ]);

  Future<void> pingBackend() async {
    logger.d("Pinging backend");
    try {
      final response = await (() =>
          _httpClient.get(
              Uri.http(AppConfig().apiDomain,
                  '${AppConfig().basePath}/ping'),
              headers: {'Content-Type': 'application/json'}
          )).withRetries(3);
      if (response.statusCode == 200) {
        logger.i('Successfully pinged the backend: ${response.body}');
      } else {
        logger.e('Failed to ping the backend');
        throw Exception('Failed to ping the backend');
      }
    } on HttpException catch (e) {
      logger.e('Failed to ping the backend', e);
      throw Exception('Failed to ping the backend: $e');
    }
  }
}
