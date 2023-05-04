import 'package:flutter/material.dart';

class DrawerButton extends StatefulWidget {
  @override
  _DrawerButtonState createState() => _DrawerButtonState();
}

class _DrawerButtonState extends State<DrawerButton> {
  bool _isDrawerOpen = false;

  void _toggleDrawer() {
    setState(() {
      _isDrawerOpen = !_isDrawerOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleDrawer,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        width: _isDrawerOpen ? 250 : 50,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(_isDrawerOpen ? 25 : 0),
            bottomLeft: Radius.circular(_isDrawerOpen ? 25 : 0),
            topRight: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ),
        child: Row(
          mainAxisAlignment:
          _isDrawerOpen ? MainAxisAlignment.start : MainAxisAlignment.center,
          children: [
            _isDrawerOpen
                ? IconButton(
              onPressed: _toggleDrawer,
              icon: Icon(Icons.arrow_back),
            )
                : Container(),
            SizedBox(width: _isDrawerOpen ? 20 : 0),
            Text(
              'Drawer',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
