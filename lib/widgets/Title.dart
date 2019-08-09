import 'package:flutter/material.dart';
import '../style.dart';

class LogPageTitle extends StatelessWidget {
  final String title;

  LogPageTitle(this.title);

  @override
  Widget build(BuildContext context) {
    var children = <Widget>[];
    for (var char in this.title.split("")) {
      children.add(
        Expanded(
          child: Text(
            char,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: MediaQuery.of(context).size.width / 14, fontWeight: FontWeight.w300, color: ColorConfig.loginTitle),
          ),
          flex: 2,
        )
      );
    }
    return Container(
      child: Row(children: children),
      padding: EdgeInsets.only(
        left: MediaQuery.of(context).size.width / 10,
        right: MediaQuery.of(context).size.width / 10
      )
    );
  }
}
