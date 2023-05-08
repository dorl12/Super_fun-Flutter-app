import 'package:flutter/material.dart';
import 'DepartmentList.dart';
import 'naviFinish.dart';
import 'naviInstructions.dart';

class Navigation extends StatefulWidget {
  @override
  _navigation createState() => _navigation();
}

class _navigation extends State<Navigation> {
  callback(i){   //callbacks tut: https://www.youtube.com/watch?v=zq-JGQxNwtU
    setState(() {
      index = i;
    });
  }
  int index = 0;
  @override
  Widget build(BuildContext context) {
    List<Widget> bodyWidgets = [DepartmentList(callbackFunction:callback), naviInstructions(callbackFunction:callback), naviFinish(callbackFunction:callback)]; //the subpages of this page
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: const Text(
    "Supermarket Navigation",
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
      ),
      body: bodyWidgets[index], //todo - something to switch between the bodies
    );
  }

}

