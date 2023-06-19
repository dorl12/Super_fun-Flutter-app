import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_fun/screens/authentication_screens/signup_screen.dart';
import 'package:super_fun/screens/navigation_screens/naviFinish.dart';

import '../screens/authentication_screens/reset_password.dart';
import '../screens/authentication_screens/signin_screen.dart';

void main() {

  setUpAll(() async {
  });

  testWidgets('HomeScreen Widget Test', (WidgetTester tester) async {
    void foo(){};
    // Build the widget
    await tester.pumpWidget(
      MaterialApp(
        home: naviFinish(callbackFunction: foo),
      ),
    );

    // Verify the widget
    expect(find.text('Mission Complete!'), findsOneWidget);
    expect(find.text('Your cart is full now :)'), findsOneWidget);
    expect(find.text('Finish'), findsOneWidget);
  });
}

