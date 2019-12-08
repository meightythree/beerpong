import 'package:beerpong/common/BeerpongAppBar.dart';
import 'package:beerpong/common/BeerpongDrawer.dart';
import 'package:beerpong/common/Constants.dart';
import 'package:beerpong/common/RuleCard.dart';
import 'package:beerpong/common/interfaces/Rule.dart';
import 'package:beerpong/services/BeerpongService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Rules extends StatefulWidget {
  @override
  _RulesState createState() => _RulesState();
}

class _RulesState extends State<Rules> {
  static BeerpongService bps = BeerpongService();
  var textEditingControllerName = TextEditingController();
  var textEditingControllerContent = TextEditingController();

  List<IRule> rules = bps.instance.getRules();

  @override
  void dispose() {
    textEditingControllerName.dispose();
    textEditingControllerContent.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BeerpongAppBar(title: 'Add a rule',),
      drawer: BeerpongDrawer(),
      body: ListView.builder(
          itemCount: bps.getRules().length + 1,
          itemBuilder: (context, index) {
            if(0 == index) {
              return Padding(
                padding: const EdgeInsets.all(SPACING),
                child: Column(
                  children: <Widget>[
                    Material(
                      child: TextField(
                        controller: textEditingControllerName,
                        cursorColor: PRIMARY_COLOR,
                        decoration: InputDecoration(
                            hintText: 'Add your Rule name',
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
                    Material(
                      child: TextField(
                        controller: textEditingControllerContent,
                        cursorColor: PRIMARY_COLOR,
                        decoration: InputDecoration(
                            hintText: 'Add your Rule content',
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
                ),
              );
            } else {
              return RuleCard(
                rule: rules[index - 1],
                onItemDeleted: () => removeRule(rules[index - 1].id),
                onItemClicked: () => openRuleInfo(rules[index - 1]),
              );
            }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => addRule(),
        child: Icon(Icons.add),
        backgroundColor: PRIMARY_COLOR,
      ),
    );
  }

  addRule() {
    var ruleName = textEditingControllerName.text;
    var ruleContent = textEditingControllerContent.text;

    if(ruleName.isEmpty || ruleContent.isEmpty) {
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Container(
                child: Text('You must add rule name and rule content!'),
              ),
            );
          }
          );
    } else {
      bps.instance.addRule(ruleName, ruleContent);
      setState(() {
        rules = bps.instance.getRules();
        textEditingControllerName.text = '';
        textEditingControllerContent.text = '';
      });
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Container(
                child: Text('$ruleName was added!'),
              ),
            );
          }
      );
    }
  }

  removeRule(String id) {
    bps.instance.removeRule(id);
    setState(() {
      rules: bps.instance.getRules();
    });
  }

  openRuleInfo(IRule rule) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Column(
              children: <Widget>[
                Text(rule.name),
                SizedBox(
                  height: SPACING,
                ),
                Text(rule.content)
              ],
            ),
          );
    });
  }
}
