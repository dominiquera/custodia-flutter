import 'package:flutter/material.dart';

import '../../../theme-provider.dart';

class HeaderItem extends StatelessWidget {

  HeaderItem({this.title, this.description, this.colorAccent});

  final String title;
  final String description;
  final Color colorAccent;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10, left: ThemeProvider.screenPadding, right: ThemeProvider.screenPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title,
            style: TextStyle(
              color: colorAccent,
              fontFamily: "RobotoBlack",
              fontSize: 26
            )
          ),
          Text(
            description,
            style: TextStyle(color: ThemeProvider.grey2),
          ),
        ],
      ),
    );
  }
}
