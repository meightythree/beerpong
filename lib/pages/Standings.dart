
import 'package:beerpong/common/BeerpongAppBar.dart';
import 'package:beerpong/common/BeerpongDrawer.dart';
import 'package:beerpong/common/Constants.dart';
import 'package:beerpong/common/interfaces/TeamPoints.dart';
import 'package:beerpong/services/BeerpongService.dart';
import 'package:flutter/material.dart';

class Standings extends StatefulWidget {
  @override
  _StandingsState createState() => _StandingsState();
}

class _StandingsState extends State<Standings> {
  static BeerpongService bps = BeerpongService();
  List<ITeamPoints> teamPoints = bps.instance.getTeamsByPoints(bps.instance.getCurrentTournamentId());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BeerpongAppBar(title: 'Standings',),
        drawer: BeerpongDrawer(),
        body: ListView.builder(
          itemCount: teamPoints.length,
            itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.all(SPACING / 2),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(SPACING),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(teamPoints[index].team.name, overflow: TextOverflow.ellipsis,),
                      SizedBox(height: SPACING / 2,),
                      Text('Points: ${teamPoints[index].points}'),
                    ],
                  ),
                ),
              ),
            );
        }),
    );
  }
}
