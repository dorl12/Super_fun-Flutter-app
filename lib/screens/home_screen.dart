import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_functions/cloud_functions.dart';

import 'package:flutter/material.dart';
import 'package:super_fun/reusable_widgets/reusable_widget.dart';
import 'package:super_fun/utils/strings.dart';
import 'signin_screen.dart';
import 'navigation.dart';
import 'package:super_fun/screens/signin_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text(MyStrings.welcomeMessage),
      ),
      body: Container(decoration: reusable_widget().myBoxDecoration(), child: const MyCustomForm()),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  State<MyCustomForm> createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> {
  final userId = 'Eli'; //todo - change to login id
  DatabaseReference clients_ref = FirebaseDatabase.instance.ref("data/Clients/Eli"); //todo - make use of userid
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

    //userNotSignedIn(context); //todo - put in better place

    return Padding(
    padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
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
              margin: const EdgeInsets.all(2),
              elevation: 2,
              color: Colors.blue,
              child: ListTile(
                contentPadding: const EdgeInsets.fromLTRB(10,0,10,0),
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
      List<String> res = [];
      callGetGroceryKeys(_items, userId, res);
      clients_ref.set({
        'list': jsonEncode(_items),
        'sfsfd': jsonEncode(res),
      });

      //move to nav page
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SignInScreen()), //todo - change back to navigation
      );
    },
      child: Text('Start Shopping'),);
  }
}

Future<void> callGetGroceryKeys(products, userId, res) async {
  // Initialize Firebase Functions
  FirebaseFunctions functions = FirebaseFunctions.instance;

  // Call the getGroceryKeys function with the products argument
  HttpsCallable callable = functions.httpsCallable('getGroceryKeys');
  try {
    final result = await callable.call(<String, dynamic>{
      'products': products,
      'userId': userId,
    });
    // Handle the result of the function call
    print("result: ${result.data}, products: ${products}, userid: ${userId}");
    res = result.data;
  } on FirebaseFunctionsException catch (e) {
    // Handle any errors that occur during the function call
    print('Error: ${e.code} ${e.message}');
  } catch (e) {
    print('Error: $e');
  }
}

void userNotSignedIn(BuildContext context){
  //go to sign in if user not signed in
  FirebaseAuth auth = FirebaseAuth.instance;
  if (auth.currentUser == null) {
    // Navigate to sign in screen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignInScreen()), //todo - change back to navigation
    );
  }
}