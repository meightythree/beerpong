import 'package:beerpong/pages/AddTournament.dart';
import 'package:beerpong/pages/Games.dart';
import 'package:beerpong/pages/Standings.dart';
import 'package:flutter/material.dart';

import 'package:beerpong/pages/Rules.dart';
import 'package:beerpong/pages/Teams.dart';
import 'package:beerpong/pages/Tournaments.dart';

void main() => runApp(MaterialApp(
  initialRoute: '/',
  routes: {
    '/': (context) => Tournaments(),
    '/teams': (context) => Teams(),
    '/addtournament': (context) => AddTournament(),
    '/rules': (context) => Rules(),
    '/games': (context) => Games(),
    '/standings': (context) => Standings(),
  },

));

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
