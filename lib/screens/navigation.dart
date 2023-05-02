import 'package:flutter/material.dart';

import '../reusable_widgets/reusable_widget.dart';

class navigation extends StatefulWidget {
  @override
  _navigation createState() => _navigation();
}

class _navigation extends State<navigation> {
  final List<String> items = [    "Apples",    "Bananas", "Qiwi", "Melon",    "Oranges",    "Grapes",    "Pineapple",    "Watermelon",  ];
  int currentItemIndex = 0;
  List<String> checkedItems = [];

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
    final uncheckedItems = items.sublist(currentItemIndex);
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
      body: Container(
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
                    "Fruits",
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
                  itemCount: uncheckedItems.length + checkedItems.length ,
                  itemBuilder: (BuildContext context, int index) {
                    if (index < uncheckedItems.length) {
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
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
                        margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                        elevation: 2,
                        color: Color(0xC383FF49),
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
                onPressed: () => goToNextItem(),
                child: const Text("Next Department"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
