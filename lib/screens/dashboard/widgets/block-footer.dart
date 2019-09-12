import 'package:flutter/material.dart';

import '../../../theme-provider.dart';

class BlockFooter extends StatelessWidget {

  BlockFooter({this.text, this.accentColor});

  final String text;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(0),
      child: Column(
        children: <Widget>[
          Divider(
            height: 1,
            color: ThemeProvider.darkGrey
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Align(
              alignment: Alignment.centerRight,
              child: RichText(
                text: TextSpan(
                  style: TextStyle(fontSize: 16),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'MORE THIS MONTH FOR ',
                      style: TextStyle(
                        color: ThemeProvider.darkGrey,
                        fontSize: 14
                      )
                    ),
                    TextSpan(
                      text: '$text >',
                      style: TextStyle(
                        color: accentColor,
                        fontSize: 14
                      )
                    ),
                  ],
                ),
              ),
            ),
          ),
          Divider(
            height: 1,
            color: ThemeProvider.darkGrey
          )
        ],
      ),
    );
  }
}
