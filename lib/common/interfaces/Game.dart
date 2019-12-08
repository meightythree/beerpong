import 'package:beerpong/common/interfaces/Team.dart';
import 'package:uuid/uuid.dart';

class IGame {
  String id;
  ITeam t1;
  ITeam t2;
  String winnerId;

  IGame(ITeam t1, ITeam t2) {
    this.id = Uuid().v1();
    this.t1 = t1;
    this.t2 = t2;
  }
}