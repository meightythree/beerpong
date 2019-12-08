import 'package:beerpong/common/BeerpongAppBar.dart';
import 'package:beerpong/common/BeerpongDrawer.dart';
import 'package:beerpong/common/TournamentCard.dart';
import 'package:beerpong/common/interfaces/Tournament.dart';
import 'package:beerpong/services/BeerpongService.dart';
import 'package:flutter/material.dart';

class Tournaments extends StatefulWidget {
  @override
  _TournamentsState createState() => _TournamentsState();
}

class _TournamentsState extends State<Tournaments> {
  static BeerpongService bps = BeerpongService();

  List<ITournament> tournaments = bps.getTournaments();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: BeerpongAppBar(title: 'Tournaments',),
        drawer: BeerpongDrawer(),
        body: ListView.builder(
            itemCount: tournaments.length,
            itemBuilder: (context, index) {
            return TournamentCard(
              tournament: tournaments[index],
              onItemDeleted: () => removeTournament(tournaments[index].id),
            );
        }),
      ),
    );
  }

  removeTournament(String tournamentId) {
    bps.instance.removeTournament(tournamentId);
    setState(() {
      tournaments = bps.getTournaments();
    });
  }
}
