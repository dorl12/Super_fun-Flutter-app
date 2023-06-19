import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_fun/screens/authentication_screens/signup_screen.dart';

import '../screens/authentication_screens/signin_screen.dart';

void main() {

  setUpAll(() async {
  });

  testWidgets('HomeScreen Widget Test', (WidgetTester tester) async {
    // Build the widget
    await tester.pumpWidget(
      MaterialApp(
        home: SignUpScreen(),
      ),
    );

    // Verify the widget
    expect(find.text('Sign Up'), findsWidgets);
    expect(find.text('Enter UserName'), findsOneWidget);
    expect(find.text('Enter Email Id'), findsOneWidget);
    expect(find.text('Enter Password'), findsOneWidget);
  });
}

