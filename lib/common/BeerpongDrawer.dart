import 'package:beerpong/common/Constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BeerpongDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Column(
                children: <Widget>[
                  Image(image: AssetImage('assets/schorpong.png'), height: 120,)
                ],
              ),
              decoration: BoxDecoration(
                color: PRIMARY_COLOR,
              ),
            ),
            ListTile(
              title: Text('Tournaments', style: TextStyle(color: PRIMARY_COLOR),),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/');
              },
            ),
            ListTile(
              title: Text('Add Tournaments', style: TextStyle(color: PRIMARY_COLOR),),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/addtournament');
              },
            ),
            ListTile(
              title: Text('Teams', style: TextStyle(color: PRIMARY_COLOR),),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/teams');
              },
            ),
            ListTile(
              title: Text('Rules', style: TextStyle(color: PRIMARY_COLOR),),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/rules');
              },
            ),
          ],
        ),
    );
  }
}
