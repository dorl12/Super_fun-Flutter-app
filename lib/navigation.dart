import 'package:flutter/material.dart';

// main.dart
import 'package:flutter/material.dart';

class navigation extends StatelessWidget {
  const navigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kindacode.com',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Items in the list
  final _items = [];

  // The key of the list
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();

  // Add a new item to the list
  // This is trigger when the floating button is pressed
  void _addItem() {
    _items.insert(0, "Item ${_items.length + 1}");
    _listKey.currentState!.insertItem(0, duration: const Duration(seconds: 1));
  }

  // Remove an item
  // This is trigger when the trash icon associated with an item is tapped
  void _removeItem(int index) {
    _listKey.currentState!.removeItem(index, (_, animation) {
      return SizeTransition(
        sizeFactor: animation,
        child: const Card(
          margin: EdgeInsets.all(10),
          elevation: 10,
          color: Colors.purple,
          child: ListTile(
            contentPadding: EdgeInsets.all(15),
            title: Text("Goodbye", style: TextStyle(fontSize: 24)),
          ),
        ),
      );
      ;
    }, duration: const Duration(seconds: 1));

    _items.removeAt(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kindacode.com'),
      ),
      body: AnimatedList(
        key: _listKey,
        initialItemCount: 0,
        padding: const EdgeInsets.all(10),
        itemBuilder: (_, index, animation) {
          return SizeTransition(
            key: UniqueKey(),
            sizeFactor: animation,
            child: Card(
              margin: const EdgeInsets.all(10),
              elevation: 10,
              color: Colors.orange,
              child: ListTile(
                contentPadding: const EdgeInsets.all(15),
                title:
                Text(_items[index], style: const TextStyle(fontSize: 24)),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => _removeItem(index),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: _addItem, child: const Icon(Icons.add)),
    );
  }
}
