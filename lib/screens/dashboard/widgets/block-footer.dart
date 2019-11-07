import 'package:flutter/material.dart';

import '../../../theme-provider.dart';

class FooterItem extends StatelessWidget {

  FooterItem({this.mainText, this.accentText, this.accentColor, this.onTap});

  final String mainText;
  final String accentText;
  final Color accentColor;
  final Function onTap;

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
              child: InkWell(
                onTap: onTap,
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(fontSize: 16),
                    children: <TextSpan>[
                      TextSpan(
                        text: mainText,
                        style: TextStyle(
                          color: ThemeProvider.darkGrey,
                          fontSize: 14
                        )
                      ),
                      TextSpan(
                        text: '$accentText >',
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
