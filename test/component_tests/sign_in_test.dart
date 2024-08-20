import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:to_do_app/modules/auth/presentation/pages/sign_in_page.dart';
import 'package:to_do_app/modules/auth/presentation/widgets/apple_sign_in_button.dart';
import 'package:to_do_app/modules/auth/presentation/widgets/google_sign_in_button.dart';
import 'package:to_do_app/utils/app_colors.dart';

void main() {
  testWidgets('Test if Sign In Page has all essential UI elements', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SignInPage(),
      ),
    );

    // Check for the presence of the Icon
    expect(find.byIcon(Icons.task_outlined), findsOneWidget);

    // Check for the welcome text
    expect(find.text('Bem vindo(a)!'), findsOneWidget);

    // Check for the Email and Password fields
    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Senha'), findsOneWidget);

    // Check for the "Esqueceu a senha?" text
    expect(find.text('Esqueceu a senha?'), findsOneWidget);

    // Check for the "Entrar" button
    expect(find.text('Entrar'), findsOneWidget);

    // Check for the "Criar Conta" link
    expect(find.text('Criar Conta'), findsOneWidget);

    // Check for Google and Apple sign-in buttons
    expect(find.byType(GoogleSignInButton), findsOneWidget);
    expect(find.byType(AplleSignInButton), findsOneWidget);
  });

  testWidgets('Tapping "Entrar" with empty fields shows validation errors', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SignInPage(),
      ),
    );

    // Tap the "Entrar" button
    await tester.tap(find.text('Entrar'));
    await tester.pump();

    // Check for validation errors
    expect(find.text('Campo Obrigatório!'), findsWidgets);
  });

  testWidgets('Check if Sign In button has correct styling', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SignInPage(),
      ),
    );

    // Check the styling of the "Entrar" button
    final ElevatedButton signInButton = tester.widget(find.byType(ElevatedButton));
    final TextStyle textStyle = (signInButton.child as Text).style!;

    expect(signInButton.style!.backgroundColor!.resolve({}), Colors.black);
    expect(textStyle.fontSize, 22);
    expect(textStyle.color, AppColors.mainGreen);
  });
}
