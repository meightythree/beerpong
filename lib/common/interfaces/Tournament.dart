
import 'package:beerpong/common/interfaces/Game.dart';
import 'package:beerpong/common/interfaces/Rule.dart';
import 'package:beerpong/common/interfaces/Team.dart' ;
import 'package:uuid/uuid.dart';

class ITournament {
  String id;
  String name;
  IRule rule;
  List<ITeam> teams;
  List<IGame> games;

  ITournament(String name, List<ITeam> teams, IRule rule) {
    this.id = Uuid().v1();
    this.name = name;
    this.teams = teams;
    this.games = generateGames();
  }

  List<IGame> generateGames() {
    List<IGame> gameList = [];
    for( var i = this.teams.length - 1; 0 <=  i ; i-- ) {
      for( var j = 0; j <= this.teams.length - 1  ; j++ ) {
        if (i != j) {
          gameList.add(new IGame(this.teams[i], this.teams[j]));
        }
      }
    }
    print(gameList.length);
    return gameList;
  }

}