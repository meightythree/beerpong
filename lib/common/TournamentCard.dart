import 'package:beerpong/common/Constants.dart';
import 'package:beerpong/common/interfaces/Tournament.dart';
import 'package:beerpong/pages/Games.dart';
import 'package:beerpong/services/BeerpongService.dart';
import 'package:flutter/material.dart';

class TournamentCard extends StatelessWidget {
  static BeerpongService bps = BeerpongService();

  final ITournament tournament;
  final VoidCallback onItemDeleted;

  const TournamentCard({ @required this.tournament, @required this.onItemDeleted });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(SPACING / 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: Flexible(
                child: Text(tournament.name,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    bps.instance.setCurrentTournamentId(this.tournament.id);
                    Navigator.pushReplacementNamed(context, '/standings');
                  },
                  icon: Icon(Icons.list, color: PRIMARY_COLOR,),
                ),
                IconButton(
                  onPressed: () {
                    bps.instance.setCurrentTournamentId(this.tournament.id);
                    Navigator.pushReplacementNamed(context, '/games');
                  },
                  icon: Icon(Icons.gamepad, color: PRIMARY_COLOR,),
                ),
                IconButton(
                  onPressed: () => onItemDeleted(),
                  icon: Icon(Icons.delete, color: PRIMARY_COLOR,),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
