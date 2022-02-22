import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mooover/config/routes/routing.dart';
import 'package:mooover/main.dart';

void main() {
  group("App", () {
    testWidgets('the material app is created', (WidgetTester tester) async {
      await tester.pumpWidget(App());
      expect(find.byType(MaterialApp), findsOneWidget);
    });
    testWidgets('the routes are applied', (WidgetTester tester) async {
      final routeObserver = AppRouteObserver();
      await tester.pumpWidget(App(routeObserver: routeObserver,));
    });
  });
}
