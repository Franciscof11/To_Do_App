import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:to_do_app/modules/auth/presentation/pages/sign_up_page.dart';
import 'package:to_do_app/modules/auth/presentation/widgets/apple_sign_in_button.dart';
import 'package:to_do_app/modules/auth/presentation/widgets/google_sign_in_button.dart';
import 'package:to_do_app/utils/app_colors.dart';

void main() {
  testWidgets('SignUpPage has all essential UI elements', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SignUpPage(),
      ),
    );

    // Check for the presence of the Icon
    expect(find.byIcon(Icons.task_outlined), findsOneWidget);

    // Check for the welcome text
    expect(find.text('Vamos criar uma conta para você!'), findsOneWidget);

    // Check for the Email, Password, and Confirm Password fields
    expect(find.byType(TextFormField), findsNWidgets(3));
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Senha'), findsOneWidget);
    expect(find.text('Confirmar senha'), findsOneWidget);

    // Check for the "Criar conta" button
    expect(find.text('Criar conta'), findsOneWidget);

    // Check for the "Já possui uma conta? Faça Login!" link
    expect(find.text('Já possui uma conta? Faça Login!'), findsOneWidget);

    // Check for Google and Apple sign-in buttons
    expect(find.byType(GoogleSignInButton), findsOneWidget);
    expect(find.byType(AplleSignInButton), findsOneWidget);
  });

  testWidgets('SignUp button has correct styling', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SignUpPage(),
      ),
    );

    // Check the styling of the "Criar conta" button
    final ElevatedButton signUpButton = tester.widget(find.byType(ElevatedButton));
    final TextStyle textStyle = (signUpButton.child as Text).style!;

    expect(signUpButton.style!.backgroundColor!.resolve({}), Colors.black);
    expect(textStyle.fontSize, 22);
    expect(textStyle.color, AppColors.mainGreen);
  });
}
