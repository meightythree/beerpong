import 'package:beerpong/common/Constants.dart';
import 'package:beerpong/common/interfaces/Game.dart';
import 'package:flutter/material.dart';

class GameCard extends StatelessWidget {
  final IGame game;
  final VoidCallback setWinner1;
  final VoidCallback setWinner2;
  final int index;

  GameCard({ @required this.game, @required this.index,  @required this.setWinner1, @required this.setWinner2});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(SPACING / 2),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(SPACING),
          child: Column(
            children: <Widget>[
              Container(
                child: Text('Game ${index+1}', style: TextStyle(color: PRIMARY_COLOR),),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(game.t1.name, style: TextStyle(color: game.t1.id == game.winnerId ? Colors.green : Colors.black), overflow: TextOverflow.ellipsis),
                  IconButton(icon: Icon(Icons.add), color: PRIMARY_COLOR, onPressed: () => setWinner1(),)
                ],
              ),
              SizedBox(height: SPACING / 2,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(game.t2.name, style: TextStyle(color: game.t2.id == game.winnerId ? Colors.green : Colors.black), overflow: TextOverflow.ellipsis,),
                  IconButton(icon: Icon(Icons.add), color: PRIMARY_COLOR, onPressed: () => setWinner2(),)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
