import 'package:beerpong/common/BeerpongAppBar.dart';
import 'package:beerpong/common/BeerpongDrawer.dart';
import 'package:beerpong/common/GameCard.dart';
import 'package:beerpong/common/interfaces/Game.dart';
import 'package:beerpong/common/interfaces/Tournament.dart';
import 'package:beerpong/services/BeerpongService.dart';
import 'package:flutter/material.dart';

class Games extends StatefulWidget {
  @override
  _GamesState createState() => _GamesState();
}

class _GamesState extends State<Games> {
  static BeerpongService bps = BeerpongService();

  List<IGame> games = [];
  String tournamentId;
  String tournamentName;

  @override
  void initState() {
    ITournament t = bps.instance.getTournamentById(bps.instance.getCurrentTournamentId());
    setState(() {
      games = t.games;
      tournamentId = t.id;
      tournamentName = t.name;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BeerpongAppBar(title: tournamentName,),
      drawer: BeerpongDrawer(),
      body: ListView.builder(
          itemCount: games.length,
          itemBuilder: (context, index) {
          return GameCard(
            game: games[index],
            index: index,
            setWinner1: () => setWinner(games[index].id, games[index].t1.id),
            setWinner2: () => setWinner(games[index].id, games[index].t2.id),
          );
      })
    );
  }

  setWinner(String gameId, String winnerId) {
    bps.instance.setGameWinner(tournamentId, gameId, winnerId);
    setState(() {
      games = bps.instance.getTournamentById(tournamentId).games;
    });
  }
}