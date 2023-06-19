import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import '../screens/authentication_screens/signin_screen.dart';
import '../screens/home_screen.dart';


void main() {
  testWidgets('Sign In Screen Test', (WidgetTester tester) async {
    // Build the sign-in screen widget
    await tester.pumpWidget(MaterialApp(home: SignInScreen()));

    // Use tester to interact with the sign-in screen and perform assertions
    // For example, you can find text fields by their keys and enter values
    final emailField = find.byType(TextField).first;
    await tester.enterText(emailField, 'elisil10@walla.com');

    final passwordField = find.byType(TextField).last;
    await tester.enterText(passwordField, '209132489');

    // Perform sign-in action
    final signInButton = find.byKey(Key("signin"));
    await tester.pumpAndSettle();

    await tester.tap(signInButton);
    await tester.pumpAndSettle();

    // Add more assertions to verify the expected behavior

    // For example, check if the HomeScreen is navigated to after successful sign-in
    //expect(find.byType(HomeScreen), findsOneWidget);
  });
}

