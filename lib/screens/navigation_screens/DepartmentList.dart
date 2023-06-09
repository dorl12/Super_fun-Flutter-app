import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../reusable_widgets/reusable_widget.dart';
import 'naviManager.dart';


class DepartmentList extends StatefulWidget {
  DepartmentList({required this.callbackFunction});
  final Function callbackFunction;
  @override
  _departmentList createState() => _departmentList(callbackFunction: callbackFunction);
}

class _departmentList extends State<DepartmentList> {
  //  final List<String> items = [    "Apples",    "Bananas", "Qiwi", "Melon",    "Oranges",    "Grapes",    "Pineapple",    "Watermelon",  ];
  final List<String> items = ListStates.currDepartmentProducts;
  int currentItemIndex = 0;
  List<String> checkedItems = [];
  _departmentList({required this.callbackFunction});
  final Function callbackFunction;

  void markItemAsChecked(int index) {
    setState(() {
      final item = items.removeAt(index);
      checkedItems.add(item);
    });
  }

  void uncheckItem(int index) {
    setState(() {
      final item = checkedItems.removeAt(index);
      items.add(item);
    });
  }

  void goToNextItem() {
    setState(() {
      currentItemIndex++;
      if (currentItemIndex >= items.length) {
        currentItemIndex = items.length - 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return nav_list();
  }

  Container nav_list() {
    final uncheckedItems = items.sublist(currentItemIndex);
    return Container(
      decoration: reusable_widget().myBoxDecoration(),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 80),
            Row(
              children: [
                Text(
                  "Currently at: ",
                  style: const TextStyle(
                    fontSize: 24,
                    color: Colors.white70,
                  ),
                ),
                Text(
                  ListStates.leftDepartments[0],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white70,
                    fontSize: 24,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            myDivider(),
            Expanded(
              child: ListView.builder(
                itemCount: uncheckedItems.length + checkedItems.length,
                itemBuilder: (BuildContext context, int index) {
                  if (index < uncheckedItems.length) {
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 10),
                      elevation: 2,
                      color: Color(0xB7FFFFFF),
                      child: ListTile(
                        leading: Checkbox(
                          value: false,
                          onChanged: (value) => markItemAsChecked(index),
                        ),
                        title: Text(uncheckedItems[index]),
                      ),
                    );
                  } else {
                    final checkedIndex = index - uncheckedItems.length;
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 10),
                      elevation: 2,
                      color: Color(0xC383FF5d),
                      child: ListTile(
                        leading: Checkbox(
                          value: true,
                          onChanged: (value) => uncheckItem(checkedIndex),
                        ),
                        title: Text(
                          checkedItems[checkedIndex],
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
            ElevatedButton(
              onPressed: () => {
                ListStates.leftDepartments.removeAt(0),
                if(ListStates.leftDepartments.isEmpty){callbackFunction(2)}
                else {callbackFunction(1)},
              },
              child: const Text("Next Department"),
            ),
          ],
        ),
      ),
    );
  }
}