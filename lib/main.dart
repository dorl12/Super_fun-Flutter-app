import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

import 'navigation.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Welcome To SuperFun!';
    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(appTitle),
        ),
        body: const MyCustomForm(),
      ),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  State<MyCustomForm> createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> {
  int _currentValue = 1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0,100.0,20.0,0.0),
      child: Column(
        children: [
          Row(
            children: const <Widget>[
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter an item name',
                  ),
                ),
              ),
              SizedBox(width: 10),
              IconButton(onPressed: AsyncSnapshot.nothing, icon: Icon(Icons.add_shopping_cart_rounded)),
          ]
          ),
          const SizedBox(height: 10),
          TextButton(onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => navigation()),
            );
          },child: Text('Start Shopping'),)
        ],
      ),
    );
  }
}