import 'package:flutter/material.dart';

import '../reusable_widgets/reusable_widget.dart';
class Nav_list {
  Container nav_list(BuildContext context, uncheckedItems, checkedItems,
      markItemAsChecked, uncheckItem, goToNextItem) {
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
    );
  }

}