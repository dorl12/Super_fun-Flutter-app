import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_functions/cloud_functions.dart';

import 'package:flutter/material.dart';
import 'package:super_fun/reusable_widgets/reusable_widget.dart';
import 'package:super_fun/screens/home_screen.dart';
import 'package:super_fun/utils/strings.dart';
import 'screens/navigation.dart';
import 'screens/signin_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  DatabaseReference ref = FirebaseDatabase.instance.ref("data");
  DatabaseEvent event = await ref.once();
  print(event.snapshot.value); // { "name": "John" }

  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: MyStrings.welcomeMessage,
      home: SignInScreen()
    );
  }
}