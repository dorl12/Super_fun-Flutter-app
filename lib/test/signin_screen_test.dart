import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_fun/screens/home_screen.dart';

import '../screens/authentication_screens/signin_screen.dart';

void main() {

  setUpAll(() async {
  });

  testWidgets('HomeScreen Widget Test', (WidgetTester tester) async {
    // Build the widget
    await tester.pumpWidget(
      MaterialApp(
        home: SignInScreen(),
      ),
    );

    // Verify the widget
    expect(find.text('Enter UserName'), findsOneWidget);
    expect(find.text('Enter Password'), findsOneWidget);
    expect(find.text('Sign In'), findsOneWidget);
    //expect(find.byType(Container), findsOneWidget);
  });
}

