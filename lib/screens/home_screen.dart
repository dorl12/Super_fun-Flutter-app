import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_functions/cloud_functions.dart';

import 'package:flutter/material.dart';
import 'package:super_fun/reusable_widgets/reusable_widget.dart';
import 'package:super_fun/utils/strings.dart';
import '../reusable_widgets/NavBar.dart';
import 'authentication_screens/signin_screen.dart';
import 'navigation_screens/naviManager.dart';
import 'navigation_screens/navigation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          MyStrings.homeScreenTitle,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      endDrawer: NavBar(),
      //body: SpeechScreen(),
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
  String _inputValue = '';
  List<String> _items = [];
  GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  void _addItem(input,_itemController) {
    final newIndex = _items.length;
    _items.add(input);
    _listKey.currentState!.insertItem(newIndex);
    _itemController.text = '';
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
    String userId = "none";
    User? user = FirebaseAuth.instance.currentUser;
    if (user!=null){
      userId = user.uid;
    } else {print("error singing userid:"+ userId);}
    DatabaseReference clients_ref = FirebaseDatabase.instance.ref("data/Clients/${userId}");

    //userNotSignedIn(context); //todo - replace with a check in signin

    return Padding(
    padding: const EdgeInsets.fromLTRB(0.0, 90.0, 0.0, 0.0),
    child:
    Column(
    children: [
    _buildInputRow(),
    const SizedBox(height: 10),
     myDivider(),
      Padding(
        padding: const EdgeInsets.all(5.0),
        child: Text(MyStrings.itemsListHeader, style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic, color: Colors.white)),
      ),
      _buildAnimatedList(),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: firebaseUIButton(context, "Start Shopping", () {_buildNavigationButton(userId, clients_ref);}),
      ),
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
    TextEditingController _itemController = TextEditingController();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
          children: <Widget>[
            Expanded(
      child: reusableTextField("Enter an item name", Icons.abc, false,_itemController),
            ),
            SizedBox(width: 10),
            IconButton(onPressed: (){
              _addItem(_itemController.text, _itemController);
            }, icon: Icon(Icons.add_shopping_cart_rounded, color: Colors.white,)),
          ]
      ),
    );
  }

  Widget _buildAnimatedList(){
    return Expanded(
        child: AnimatedList(
          padding: const EdgeInsets.fromLTRB(0,10,0,10),
          key: _listKey,
          initialItemCount: 0,
          itemBuilder: (_, index, animation) {
            return SizeTransition(
              key: UniqueKey(),
              sizeFactor: animation,
              child: Card(
                margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                elevation: 2,
                color: Color(0xB7FFFFFF),
                child: ListTile(
                  contentPadding: const EdgeInsets.fromLTRB(20,0,10,0),
                  title:
                  Text(_items[index], style: const TextStyle(fontSize: 20)),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.redAccent,),
                    onPressed: () => _removeItem(index),
                  ),
                ),
              ),
            );
          },
        ),
    );
  }
  Future<void> _buildNavigationButton(userId, clients_ref) async {
      try {
        await callGetGroceryKeysAndWriteInDB(_items, userId, clients_ref);
        await callGetDepartmentsByOrder(userId);
        String nextDepartment = ListStates.leftDepartments[0];

        // //get sub-list of first department todo - use nextDepartment insted of "dairy"
        await callGetDepartmentItems(nextDepartment, userId);

        //move to nav page
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Navigation()),
        );
      }
      catch (e){
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('$e'),
            )
        );
      }
    }
}
  Future<void> callGetGroceryKeysAndWriteInDB(products, userId, clients_ref) async {
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
      print("result of GetGroceryKeys: ${result
          .data}, products: ${products}, userid: ${userId}");

      clients_ref.set({
        'all_departments': '{${result.data.join(', ')}}',
        'products': '{${products.join(', ')}}',
      });
      //save in local:
      List<dynamic> dataList = result.data;
      List<String> string_list = dataList.map((element) => element.toString())
          .toList();
      ListStates.allProducts = string_list; //after success - update list in local 'cache'
      ListStates.userId = userId;
    }
    on FirebaseFunctionsException catch (e) {
      // Handle any errors that occur during the function call
      print('Error: ${e.code} ${e.message}');
      //throw Exception("a");
    }
    catch (e) {
      print(e);
      //throw Exception("b");
    }
  }

  Future<void> callGetDepartmentItems(departmentName, userId) async {

    // Initialize Firebase Functions
    FirebaseFunctions functions = FirebaseFunctions.instance;

    // Call the getDepartmentItems function with the department,userID argument
    HttpsCallable callable = functions.httpsCallable('getDepartmentItems');
    try {
      final result = await callable.call(<String, dynamic>{
        'departmentName': departmentName,
        'userId': userId,
      });
      // Handle the result of the function call
      print("result of GetDepartmentItems: ${result
          .data}, departmentName: ${departmentName}, userid: ${userId}");
      //save in local:
      List<dynamic> dataList = result.data;
      List<String> string_list = dataList.map((element) => element.toString())
          .toList();
      ListStates.currDepartmentProducts = string_list;
    }
    on FirebaseFunctionsException catch (e) {
      // Handle any errors that occur during the function call
      print('Error: ${e.code} ${e.message}');
      //throw Exception("a");
    }
    catch (e) {
      print(e);
      //throw Exception("b");
    }
  }

  Future<void> callGetDepartmentsByOrder(userId) async {
    // Initialize Firebase Functions
    FirebaseFunctions functions = FirebaseFunctions.instance;

    // Call the getGroceryKeys function with the products argument
    HttpsCallable callable = functions.httpsCallable('getDepartmentsByOrder');
    try {
      final result = await callable.call(<String, dynamic>{
        'userId': userId,
      });
      // Handle the result of the function call
      print(
          "result of GetDepartmentsByOrder: ${result.data}, userid: ${userId}");
      //save in local:
      List<dynamic> dataList = result.data;
      List<String> string_list = dataList.map((element) => element.toString())
          .toList();
      ListStates.allDepartments = string_list; //save all departments, by order
      ListStates.leftDepartments =
          string_list; //on beginning write all departments

    }
    on FirebaseFunctionsException catch (e) {
      // Handle any errors that occur during the function call
      print('Error: ${e.code} ${e.message}');
      //throw Exception("a");
    }
    catch (e) {
      print(e);
      //throw Exception("b");
    }

  void userNotSignedIn(BuildContext context) {
    //go to sign in if user not signed in
    FirebaseAuth auth = FirebaseAuth.instance;
    if (auth.currentUser == null) {
      // Navigate to sign in screen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>
            SignInScreen()), //todo - change back to navigation
      );
    }
  }
}