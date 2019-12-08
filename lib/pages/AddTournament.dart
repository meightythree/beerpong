import 'package:beerpong/common/BeerpongAppBar.dart';
import 'package:beerpong/common/BeerpongDrawer.dart';
import 'package:beerpong/common/Constants.dart';
import 'package:beerpong/common/TeamCard.dart';
import 'package:beerpong/common/interfaces/Rule.dart';
import 'package:beerpong/common/interfaces/Team.dart';
import 'package:beerpong/services/BeerpongService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddTournament extends StatefulWidget {
  @override
  _AddTournamentState createState() => _AddTournamentState();
}

class _AddTournamentState extends State<AddTournament> {
  static BeerpongService bps = BeerpongService();
  final textEditingController = TextEditingController();

  List<ITeam> selectedTeams = [];
  String selectedRule = bps.instance.getRules()[0].name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BeerpongAppBar(title: 'Add a tournament',),
      drawer: BeerpongDrawer(),
      body: ListView.builder(
          itemCount: selectedTeams.length + 1,
          itemBuilder: (context, index) {
              if(0 == index) {
                return Padding(
                  padding: EdgeInsets.all(SPACING),
                  child: Column(
                    children: <Widget>[
                      Material(
                        child: TextField(
                          controller: textEditingController,
                          cursorColor: PRIMARY_COLOR,
                          decoration: InputDecoration(
                              hintText: 'Add a Tournament name',
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: PRIMARY_COLOR)
                              ),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: PRIMARY_COLOR)
                              )
                          ),
                        ),
                      ),
                      SizedBox(height: SPACING,),
                      Text('Select the rule you want to play with!'),
                      Row(
                          children: <Widget>[
                            Container(
                              child: Flexible(
                              child: DropdownButton(
                                value: selectedRule,
                                icon: Icon(Icons.arrow_drop_down, color: PRIMARY_COLOR,),
                                onChanged: (String newRule) {
                                  print(newRule);
                                  setState(() {
                                    selectedRule = newRule;
                                  });
                                },
                                items: bps.instance.getRules()
                                    .map<DropdownMenuItem<String>>((IRule r) {
                                      return DropdownMenuItem<String>(
                                      value: r.name,
                                      child: Text(r.name, overflow: TextOverflow.ellipsis),
                                      );
                                      }).toList()
                              ),
                            ),
                            ),
                          ],
                        ),
                        SizedBox(height: SPACING,),
                        Text('Select multiple teams!'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            child: DropdownButton(
                              icon: Icon(Icons.arrow_drop_down, color: PRIMARY_COLOR,),
                              onChanged: (String newTeam) {
                                addNewTeam(newTeam);
                              },
                              items: bps.instance.getTeams().map((ITeam t) {
                                return DropdownMenuItem(
                                  value: t.id,
                                  child:  Text(t.name, overflow: TextOverflow.ellipsis),
                                );
                              }).toList(),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                );
              } else {
                return Container(
                  child: TeamCard(
                    team: selectedTeams[index - 1],
                   onItemDeleted: () => removeTeamFromSelected(selectedTeams[index - 1].id)),
                );
              }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => onAddTournament(),
        child: Icon(Icons.add),
        backgroundColor: PRIMARY_COLOR,
      ),
    );
  }

  onAddTournament() {
    String tournamentName = textEditingController.text;

    if (tournamentName.isEmpty || selectedTeams.length < 2 ) {
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Container(
                child: Text('You must add at least two teams and a tournament name!'),
              ),
            );
          }
      );
    } else {
      IRule sr = bps.instance.getRules().firstWhere((r) => r.name == selectedRule, orElse: () => null);
      bps.instance.addTournament(tournamentName, selectedTeams, sr);

      setState(() {
        textEditingController.text = '';
        selectedTeams = [];
      });

      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Container(
                child: Text('Tournament added successfully!'),
              ),
            );
          }
      );
    }
  }

  addNewTeam(String id) {
    ITeam newTeam = bps.instance.getTeams().firstWhere((t) => t.id == id, orElse: () => null);

    if (null != newTeam ) {
      ITeam alreadyAddedOrNull = selectedTeams.firstWhere((t) => t.id == id, orElse: () => null);

      if (null == alreadyAddedOrNull) {
        List<ITeam> teamList = selectedTeams;
        teamList.add(newTeam);
        setState(() {
          selectedTeams = teamList;
        });
      }
    }
  }

  removeTeamFromSelected(String teamId) {
    List<ITeam> updatedItems = [];
    selectedTeams.forEach((t) {
      if(teamId != t.id) {
        updatedItems.add(t);
      }
    });
    setState(() {
      selectedTeams = updatedItems;
    });
  }
}
