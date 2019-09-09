import 'package:flutter/material.dart';

import '../../../theme-provider.dart';

class BlockFooter extends StatelessWidget {

  BlockFooter({this.text, this.accentColor});

  final String text;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Divider(color: ThemeProvider.darkGrey),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Align(
            alignment: Alignment.centerRight,
            child: RichText(
              text: TextSpan(
                style: TextStyle(fontSize: 16),
                children: <TextSpan>[
                  TextSpan(text: 'MORE THIS MONTH FOR ', style: TextStyle(color: ThemeProvider.darkGrey)),
                  TextSpan(text: '$text >', style: TextStyle(color: accentColor)),
                ],
              ),
            ),
          ),
        ),
        Divider(color: ThemeProvider.darkGrey,)
      ],
    );
  }
}
