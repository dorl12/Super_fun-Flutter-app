import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:super_fun/screens/navigation_screens/naviManager.dart';

import '../../reusable_widgets/reusable_widget.dart';
import '../../utils/colors.dart';
class naviInstructions extends StatefulWidget {
  naviInstructions({required this.callbackFunction});
  final Function callbackFunction;
  @override
  _naviInstructions createState() => _naviInstructions(callbackFunction: callbackFunction);
}

class _naviInstructions extends State<naviInstructions> {
  _naviInstructions({required this.callbackFunction});
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
          Text(
            'Go to next department:',
            style: TextStyle(color: MyColors.instructionNavColor, fontSize: 24.0),
          ),
          SizedBox(height: 16.0),
          Text(
            ListStates.leftDepartments[0],
            style: TextStyle(color: MyColors.instructionNavColor, fontSize: 44.0),
          ),
          SizedBox(height: 8.0),
          Image.asset(
            'assets/images/logo1.png',
            color: Colors.white,
            width: 200.0,
            height: 200.0,
          ),
          SizedBox(height: 55.0),
          Text(
            'Your cart is filling up!',
            style: TextStyle(color: MyColors.instructionNavColor, fontSize: 18.0),
          ),
          ElevatedButton(
            onPressed: () => {
              callbackFunction(0),
            },
            child: const Text("Show me next items"),
          ),
        ],
      ),
    );

  }
}