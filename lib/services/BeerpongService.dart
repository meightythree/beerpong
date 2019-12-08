
import 'package:beerpong/common/interfaces/Game.dart';
import 'package:beerpong/common/interfaces/Rule.dart';
import 'package:beerpong/common/interfaces/Team.dart';
import 'package:beerpong/common/interfaces/TeamPoints.dart';
import 'package:beerpong/common/interfaces/Tournament.dart';
import 'package:uuid/uuid.dart';

class BeerpongService {
  static final BeerpongService _singleton = BeerpongService._internal();
  BeerpongService get instance => _singleton;

      factory BeerpongService() {
    return _singleton;
  }

  BeerpongService._internal();

  /* TEAM
  * ***************************************************************************
  * */
  static final String teamUuid0 = Uuid().v1();
  static final String teamName0 = 'BME Beerpong Team';

  static final String teamUuid1 = Uuid().v1();
  static final String teamName1 = 'The thirsty Meerkats Beerpong Team Budapest';

  static final String teamUuid2 = Uuid().v1();
  static final String teamName2 = 'Alpaca Beerpong Team';

  static final ITeam team0 = new ITeam(teamUuid0, teamName0);
  static final ITeam team1 = new ITeam(teamUuid1, teamName1);
  static final ITeam team2 = new ITeam(teamUuid2, teamName2);
  List<ITeam> _teams = [
    team0,
    team1,
    team2,
  ];

  List<ITeam> getTeams() {
    return _teams;
  }

  addTeam(String teamName) {
    var alreadyExists = false;
    for(var team in _teams) {
      if (team.name == teamName) {
        alreadyExists = true;
      }
    }

    if(!alreadyExists) {
      ITeam newTeam = new ITeam(Uuid().v1(), teamName);
      _teams.add(newTeam);
    }
  }

  removeTeam(String teamId) {
    _teams.removeWhere((team) => team.id == teamId);
  }

  /* RULE
  * ***************************************************************************
  * */
  static final String ruleUuid0 = Uuid().v1();
  static final String ruleName0 = 'Basic Beerpong Rule';
  static final String ruleContent0 = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,';
  List<IRule> _rules = [
    new IRule(ruleUuid0, ruleName0, ruleContent0),
    new IRule(Uuid().v1(), 'Funny BME Rule', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,'),
    new IRule(Uuid().v1(), 'Craziest beerpong rule ever, dont play it!!!!!!!!!!!!!!!!', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,'),
  ];

  List<IRule> getRules() {
    return _rules;
  }

  addRule(String ruleName, String ruleContent) {
    var alreadyExists = false;
    for(var team in _rules) {
      if (team.name == ruleName) {
        alreadyExists = true;
      }
    }

    if(!alreadyExists) {
      IRule newRule = new IRule(Uuid().v1(), ruleName, ruleContent);
      _rules.add(newRule);
    }
  }

  removeRule(String ruleId) {
    _rules.removeWhere((team) => team.id == ruleId);
  }

/* TOURNAMENTS
  * ***************************************************************************
  * */
  String currentTournamentId = '';

  setCurrentTournamentId(String id) {
    currentTournamentId = id;
  }

  String getCurrentTournamentId(){
    return currentTournamentId;
  }


  static final List<ITeam> teams0 = [team0, team1, team2];
  static final List<ITeam> teams1 = [team1, team2];
  static final List<ITeam> teams2 = [team2, team1];


  List<ITournament> _tournaments = [
    new ITournament('BME Tournament 1 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!', teams0, new IRule(ruleUuid0, ruleName0, ruleContent0)),
    new ITournament('BME Tournament 2', teams1, new IRule(ruleUuid0, ruleName0, ruleContent0)),
    new ITournament('BME Tournament 3', teams2, new IRule(ruleUuid0, ruleName0, ruleContent0)),
  ];

  addTournament(String name, List<ITeam> teams, IRule rule) {
    _tournaments.add(new ITournament(name, teams, rule));
  }

  removeTournament(String id){
    _tournaments.removeWhere((t) => t.id == id);
  }

  List<ITournament> getTournaments() {
    return this._tournaments;
  }

  ITournament getTournamentById(String tournamentId) {
    return this._tournaments.firstWhere((t) => tournamentId == t.id);
  }

  setGameWinner(String tournamentId, String gameId, String winnerId) {
    ITournament tournament = _tournaments.firstWhere((t) => t.id == tournamentId, orElse: () => null);
    if (null != tournament) {
      List<IGame> updatedGames = tournament.games;
      updatedGames.forEach((g) {
        if(g.id == gameId) {
          g.winnerId = winnerId;
        }
      });
      tournament.games = updatedGames;
    }
  }

   int getPoints(String tournamentId, String teamId) {
    ITournament tournament = _tournaments.firstWhere((t) => t.id == tournamentId, orElse: () => null);

    int points = 0;
    if (null != tournament) {
      tournament.games.forEach((g) {
        if(g.winnerId == teamId){
          points++;
        }
      });
    }
    return points;
  }

  List<ITeamPoints> getTeamsByPoints(String tournamentId) {
    List<ITeamPoints> tp = [];

    _tournaments.firstWhere((tournament) => tournament.id == tournamentId ).teams.forEach((t) {
      tp.add(new ITeamPoints(team: t, points: getPoints(tournamentId, t.id)));
    });

    bubbleSort(tp);

    return tp;
  }

  void bubbleSort(List<ITeamPoints> list) {
    int n = list.length;
    for (int i = 0; i < n; i++) {
      for (int j = 1; j < (n - i); j++) {
        if (list[j - 1].points < list[j].points) {
          //swap elements
          ITeamPoints temp = list[j - 1];
          list[j - 1] = list[j];
          list[j] = temp;
        }
      }
    }
  }
}