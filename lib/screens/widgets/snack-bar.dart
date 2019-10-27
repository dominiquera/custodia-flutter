import 'package:flutter/material.dart';

class CustomSnackBar extends StatelessWidget {

  CustomSnackBar({this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return SnackBar(
        backgroundColor: Colors.white,
        content: Text(text, style: TextStyle(color: Colors.black54),)
    );
  }
}
