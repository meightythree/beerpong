import 'package:beerpong/common/Constants.dart';
import 'package:flutter/material.dart';

class BeerpongAppBar extends StatefulWidget with PreferredSizeWidget {
  String title = '';

  BeerpongAppBar({String title}) {
    this.title = title;
  }

  @override
  _BeerpongAppBarState createState() => _BeerpongAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _BeerpongAppBarState extends State<BeerpongAppBar> {
  _BeerpongAppBarState();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: PRIMARY_COLOR,
      title: Center(
        child: Text(widget.title),
      ),
      actions: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(0, 0, SPACING, 0),
          child: Icon(
              Icons.settings
          ),
        )
      ],
    );
  }
}