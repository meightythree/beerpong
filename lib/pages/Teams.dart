import 'package:beerpong/common/BeerpongAppBar.dart';
import 'package:beerpong/common/BeerpongDrawer.dart';
import 'package:beerpong/common/Constants.dart';
import 'package:beerpong/common/TeamCard.dart';
import 'package:beerpong/common/interfaces/Team.dart';
import 'package:beerpong/services/BeerpongService.dart';
import 'package:flutter/material.dart';

class Teams extends StatefulWidget {
  @override
  _TeamsState createState() => _TeamsState();
}

class _TeamsState extends State<Teams> {
  static BeerpongService bps = BeerpongService();
  List<ITeam> teams = bps.instance.getTeams();

  final textEditingController = TextEditingController();

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BeerpongAppBar(
          title: 'Teams'
      ),
      drawer: BeerpongDrawer(),
      body: ListView.builder(

        itemCount: teams.length + 1,
        itemBuilder: (context, index) {
          if(0 == index) {
              return
                Padding(
                  padding: const EdgeInsets.all(SPACING),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                  Material(
                  child: TextField(
                    controller: textEditingController,
                    cursorColor: PRIMARY_COLOR,
                    decoration: InputDecoration(
                        hintText: 'Add your Team',
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: PRIMARY_COLOR)
                        ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: PRIMARY_COLOR)
                        )
                    ),
                  ),
                )
              ],
             )
            );
          } else {
            return TeamCard(
                team :teams[index - 1],
                onItemDeleted: () => removeTeam(teams[index - 1].id));
          }
        },
        shrinkWrap: false,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          var teamName = textEditingController.text;
          if(teamName.isEmpty) {
            return showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Text('You must add a team name!'),
                  );
                }
            );
          } else {
            bps.addTeam(teamName);
            setState(() {
              teams: bps.getTeams();
            });
            textEditingController.text = '';
            return showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Text('$teamName was added!'),
                  );
                }
            );
          }
        },
        child: Icon(Icons.add,),
        backgroundColor: PRIMARY_COLOR,
      ),
    );
  }

  removeTeam(String teamId) {
    bps.instance.removeTeam(teamId);
    setState(() {
      teams = bps.getTeams();
    });

  }
}
