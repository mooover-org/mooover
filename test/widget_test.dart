import 'package:flutter_test/flutter_test.dart';
import 'package:mooover/main.dart';

void main() {
  testWidgets('Base unit test', (WidgetTester tester) async {
    await tester.pumpWidget(const App());
  });
}
