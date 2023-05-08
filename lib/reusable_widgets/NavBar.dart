import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:super_fun/reusable_widgets/reusable_widget.dart';

import '../screens/authentication_screens/signin_screen.dart';
//tut: https://oflutter.com/create-a-sidebar-menu-in-flutter/#3_Create_a_sidebar_menu_widget
class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250, // set the desired width here
      child: Drawer(
        child: ListView(
          // Remove padding
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text('Eliqs'),
              accountEmail: Text('elisil10@gmail.com'),
              currentAccountPicture: CircleAvatar(
                child: ClipOval(
                  child: Image.network(
                    'https://media.istockphoto.com/id/980239992/vector/happy-handsome-man-showing-thumbs-up-concept-illustration-in-cartoon-style.jpg?s=170667a&w=0&k=20&c=fV3CWAMJ6xhNFPKiSbpPcKLKjReGzrzBk9R0HXvXQcU=',
                    fit: BoxFit.cover,
                    width: 90,
                    height: 90,
                  ),
                ),
              ),
              decoration: reusable_widget().myBoxDecoration(),
            ),
            ListTile(
              leading: Icon(Icons.history),
              title: Text('History'),
              onTap: () => null,
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.abc),
              title: Text('Import from text'),
              onTap: () => null,
            ),
            ListTile(
              leading: Icon(Icons.keyboard_voice),
              title: Text('Create by voice'),
              onTap: () => null,
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Preferences'),
              onTap: () => null,
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.share),
              title: Text('Share'),
              onTap: () => null,
            ),
            ListTile(
              title: Text('Exit'),
              leading: Icon(Icons.exit_to_app),
              onTap: () => {
              FirebaseAuth.instance.signOut().then((value) {
              Navigator.push(context,
              MaterialPageRoute(builder: (context) => SignInScreen()));
              })
              },
            ),
          ],
        ),
      ),
    );
  }
}