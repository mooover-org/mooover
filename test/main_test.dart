import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mooover/main.dart';

void main() {
  group("App", () {
    testWidgets('the material app is created', (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(MaterialApp), findsOneWidget);
    });
  });
}
