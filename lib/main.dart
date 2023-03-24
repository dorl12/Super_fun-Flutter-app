import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

void main() => runApp(const MyApp());

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
    return SizedBox(
      child: Row(
        children: const <Widget>[
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter an item name',
              ),
            ),
          ),
          IconButton(onPressed: AsyncSnapshot.nothing, icon: Icon(Icons.add_shopping_cart_rounded)),
      ]
      ),
      );
  }
}