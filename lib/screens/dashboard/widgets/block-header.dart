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
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[

          Text(title,
            textAlign: TextAlign.left,
            style: TextStyle(

              color: colorAccent,
              fontFamily: "NunitoBlack",
              fontSize: 24
            )
          ),
          Text(
            description,
            textAlign: TextAlign.left,
            style: TextStyle(color: ThemeProvider.grey2),
          ),
        ],
      ),
    );
  }
}
