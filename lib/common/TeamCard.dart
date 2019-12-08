import 'package:beerpong/common/Constants.dart';
import 'package:beerpong/common/interfaces/Team.dart';
import 'package:beerpong/services/BeerpongService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

 class TeamCard extends StatelessWidget {
   final ITeam team;
   final VoidCallback onItemDeleted;

   static BeerpongService bps = BeerpongService();

  const TeamCard({ @required this.team, @required this.onItemDeleted });

  @override
  Widget build(BuildContext context) {
    return  Card(
        child: Padding(
          padding: EdgeInsets.all(SPACING / 2),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(team.name),
              Spacer(),
              IconButton(icon: Icon(Icons.delete, color: PRIMARY_COLOR,), onPressed: () {
                onItemDeleted();
              },)
            ],
          ),
        ),
      );
  }
}
