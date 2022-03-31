import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mooover/utils/services/user_session_services.dart';

void main() {
  group("User session services", () {
    test("refresh token is being saved", () async {
      WidgetsFlutterBinding.ensureInitialized();
      try {
        await UserSessionServices().setRefreshToken("value");
      } catch (_) {}
      expect(UserSessionServices().refreshToken, "value");
    });
  });
}
