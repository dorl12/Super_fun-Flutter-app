import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../reusable_widgets/reusable_widget.dart';
import '../../utils/colors.dart';
import '../home_screen.dart';
class naviFinish extends StatefulWidget {
  naviFinish({required this.callbackFunction});
  final Function callbackFunction;
  @override
  _naviFinish createState() => _naviFinish(callbackFunction: callbackFunction);
}

class _naviFinish extends State<naviFinish> {
  _naviFinish({required this.callbackFunction});
  final Function callbackFunction;
  @override
  Widget build(BuildContext context) {
    return nav_instruction();
  }
  Container nav_instruction() {
    return Container(
      width: double.infinity,
      decoration: reusable_widget().myBoxDecoration(),
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 16.0),
          Text(
            'Mission Complete!', //todo - change to a query
            style: TextStyle(color: MyColors.instructionNavColor, fontSize: 44.0),
          ),
          SizedBox(height: 30.0),
          Image.asset(
            'assets/images/logo1.png',
            color: Colors.white,
            width: 200.0,
            height: 200.0,
          ),
          SizedBox(height: 30.0),
          Text(
            'Your cart is full now :)',
            style: TextStyle(color: MyColors.instructionNavColor, fontSize: 18.0),
          ),
          SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomeScreen())),
            },
            child: const Text("Finish"),
          ),
        ],
      ),
    );

  }
}