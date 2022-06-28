import 'package:http/http.dart' as http;
import 'package:mooover/utils/helpers/logger.dart';

extension Retry<T> on Future<T> Function() {
  /// Retry the function [count] times if it fails.
  Future<T> withRetries(int count) async {
    while (true) {
      try {
        final future = this();
        return await future;
      } on http.ClientException catch (e) {
        if (count > 0) {
          count--;
          logger.w('Operation failed ($e), retrying...', e);
        } else {
          logger.e('Operation failed ($e), no retries left', e);
          rethrow;
        }
      }
    }
  }
}
