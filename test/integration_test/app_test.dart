import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:to_do_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('app test', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('signInButton')), findsOneWidget);

    await tester.enterText(find.byType(TextFormField).first, 'chico@teste.com');
    await tester.enterText(find.byType(TextFormField).last, 'Mackxy5w@');

    await tester.tap(find.byKey(const Key('signInButton')));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('homePage')), findsOneWidget);
  });
}
