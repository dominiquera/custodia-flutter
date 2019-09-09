import 'package:flutter/material.dart';

import '../../../theme-provider.dart';

class BlockHeader extends StatelessWidget {

  BlockHeader({this.title, this.description, this.colorAccent});

  final String title;
  final String description;
  final Color colorAccent;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
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
