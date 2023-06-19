import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_fun/screens/authentication_screens/signup_screen.dart';

import '../screens/authentication_screens/reset_password.dart';
import '../screens/authentication_screens/signin_screen.dart';

void main() {

  setUpAll(() async {
  });

  testWidgets('HomeScreen Widget Test', (WidgetTester tester) async {
    // Build the widget
    await tester.pumpWidget(
      MaterialApp(
        home: ResetPassword(),
      ),
    );

    // Verify the widget
    expect(find.text('Reset Password'), findsWidgets);
    expect(find.text('Enter Email Id'), findsOneWidget);
  });
}

