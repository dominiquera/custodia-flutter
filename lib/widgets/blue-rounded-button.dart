import 'package:flutter/material.dart';

import '../theme-provider.dart';


class BlueRoundedButton extends StatelessWidget {

  BlueRoundedButton({this.text, this.onPressed, this.padding});

  final String text;
  final Function onPressed;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: ThemeProvider.blue1,
      padding: EdgeInsets.symmetric(horizontal: padding, vertical: 10),
      onPressed: () {onPressed();},
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Text(text,
        style: TextStyle(
          fontSize: 24,
          color: Colors.white,
        )
      ),
    );
  }
}
