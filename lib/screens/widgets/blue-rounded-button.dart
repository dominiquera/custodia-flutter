import 'package:flutter/material.dart';

import '../../theme-provider.dart';


class BlueRoundedButton extends StatelessWidget {

  BlueRoundedButton({this.text, this.onPressed, this.padding = 20, this.disabled = false});

  final String text;
  final Function onPressed;
  final double padding;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: ThemeProvider.blue1,
      padding: EdgeInsets.symmetric(horizontal: padding, vertical: 10),
      onPressed: disabled ? null : onPressed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      disabledColor: ThemeProvider.grey1,
      child: Text(text,
        style: TextStyle(
          fontSize: 18,
          color: Colors.white,
        )
      ),
    );
  }
}
