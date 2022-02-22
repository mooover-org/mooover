import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mooover/pages/sign_in_page.dart';

void main() {
  group("SignInScreen", () {
    testWidgets("a material scaffold with an app bar exists", (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: SignInPage(),
      ));
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);
    });
    testWidgets("a light theme button exists", (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: SignInPage(),
      ));
      expect(find.widgetWithText(TextButton, "Light theme"), findsOneWidget);
    });
    testWidgets("a dark theme button exists", (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: SignInPage(),
      ));
      expect(find.widgetWithText(TextButton, "Dark theme"), findsOneWidget);
    });
  });
}
