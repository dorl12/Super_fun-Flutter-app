import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/material.dart';
import 'package:super_fun/utils/strings.dart';
import 'navigation.dart';

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
    const appTitle = MyStrings.welcomeMessage;
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

  DatabaseReference clients_ref = FirebaseDatabase.instance.ref("data/Clients");
  final userId = 'Dor'; //todo - change to login id
  String _inputValue = '';
  List<String> _items = [];
  GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  final TextEditingController _textFieldController = TextEditingController();

  void _addItem(input) {
    final newIndex = _items.length;
    _items.add(input);
    _listKey.currentState!.insertItem(newIndex);
  }

  void _removeItem(int index) {
    final removedItem = _items.removeAt(index);
    _listKey.currentState!.removeItem(
      index,
          (context, animation) =>
          const ListTile(),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 100.0, 20.0, 0.0),
      child: Column(
        children: [
          _buildInputRow(),
          const SizedBox(height: 10),
          Text(MyStrings.itemsListHeader, style: TextStyle(fontSize: 20,  fontWeight: FontWeight.bold,)),
          _buildAnimatedList(),
          _buildNavigationButton()
        ],
      ),
    );
  }

  // Used to build list items that haven't been removed.
  Widget _buildItem(BuildContext context, int index,
      Animation<double> animation) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
          );
        },
      ),
    );
  }

  Widget _buildInputRow(){
    return Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _textFieldController,
              onChanged: (value) {
                setState(() {
                  _inputValue = value;
                });
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter an item name',
              ),
            ),
          ),
          SizedBox(width: 10),
          IconButton(onPressed: (){
            //_items.add(_inputValue); //todo delete
            _addItem(_inputValue);
          }, icon: Icon(Icons.add_shopping_cart_rounded)),
        ]
    );
  }

  Widget _buildAnimatedList(){
    return Expanded(
      child: AnimatedList(
        key: _listKey,
        initialItemCount: 0,
        itemBuilder: (_, index, animation) {
          return SizeTransition(
            key: UniqueKey(),
            sizeFactor: animation,
            child: Card(
              margin: const EdgeInsets.all(5),
              elevation: 2,
              color: Colors.blue,
              child: ListTile(
                contentPadding: const EdgeInsets.all(10),
                title:
                Text(_items[index], style: const TextStyle(fontSize: 16)),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => _removeItem(index),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
  Widget _buildNavigationButton(){
    return TextButton(onPressed: () {
      //save list
      clients_ref.set({
        userId: jsonEncode(_items),
        // todo: 'classes_set': dors_function(list)
      });
      //move to nav page
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => navigation()),
      );
    },
      child: Text('Start Shopping'),);
  }
}


