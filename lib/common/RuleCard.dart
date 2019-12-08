import 'package:beerpong/common/Constants.dart';
import 'package:beerpong/common/interfaces/Rule.dart';
import 'package:flutter/material.dart';

class RuleCard extends StatelessWidget {
  final IRule rule;
  final VoidCallback onItemDeleted;
  final VoidCallback onItemClicked;

  const RuleCard({ @required this.rule, @required this.onItemDeleted,  @required this.onItemClicked});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(SPACING / 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: Flexible(
                child: Text(rule.name,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Row(
              children: <Widget>[
                IconButton(
                  onPressed: () => onItemClicked(),
                  icon: Icon(Icons.pageview, color: PRIMARY_COLOR,),
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
