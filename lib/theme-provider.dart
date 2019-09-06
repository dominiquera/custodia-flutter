import 'package:flutter/material.dart';

class ThemeProvider {
  static const blue1 = Color(0xFF21ccde);
  static const blue2 = Color(0xFF3191de);
  static const blue3 = Color(0xFF3a6ddf);
  static const blue4 = Color(0xFF5503e1);
  static const lightGrey = Color(0xFFededed);
  static const darkGrey = Color(0xFF838383);

  static const blueGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [0, 0.3, 0.5, 1],
    colors: [
      ThemeProvider.blue1,
      ThemeProvider.blue2,
      ThemeProvider.blue3,
      ThemeProvider.blue4
    ],
  );

  static final theme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    fontFamily: 'RobotoLight',
  );
}