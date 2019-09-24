import 'package:flutter/material.dart';

class ThemeProvider {
  static const red = Color(0xFFba342f);
  static const orange = Color(0xFFfa803a);
  static const yellow1 = Color(0xFFfabd1d);
  static const lightBrown = Color(0xFFb0964f);
  static const yellow2 = Color(0xFFd3c531);
  static const lime = Color(0xFFceff00);
  static const green1 = Color(0xFF8fbc5c);
  static const green2 = Color(0xFF63bd6d);
  static const green3 = Color(0xFF8dc63f);
  static const green4 = Color(0xFFafd4a8);
  static const blue1 = Color(0xFF21ccde);
  static const blue8 = Color(0xFF8dc7fc);
  static const blue2 = Color(0xFF3191de);
  static const blue5 = Color(0xFF365f90);
  static const blue6 = Color(0xFF007aff);
  static const blue3 = Color(0xFF3a6ddf);
  static const blue7 = Color(0xFF485bdf);
  static const blue4 = Color(0xFF5503e1);
  static const lightViolet = Color(0xFFbca2f5);
  static const lightGrey1 = Color(0xFFededed);
  static const lightGrey2 = Color(0xFFf0f0f0);
  static const lightBlue = Color(0xFFf1f6ff);
  static const grey1 = Color(0xFFa6a6a6);
  static const grey2 = Color(0xFF838383);
  static const darkGrey = Color(0xFF3d3d3d);

  static double screenPadding = 20.0;

  static final blueTransparentGradientDiagonal = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [0, 0.3, 0.5, 1],
    colors: [
      ThemeProvider.blue1.withOpacity(0.9),
      ThemeProvider.blue2.withOpacity(0.9),
      ThemeProvider.blue3.withOpacity(0.9),
      ThemeProvider.blue4.withOpacity(0.9)
    ],
  );

  static final blueGradientDiagonal = LinearGradient(
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

  static final blueGradientHorizontal = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    stops: [0, 0.3, 0.5, 1],
    colors: [
      ThemeProvider.blue1,
      ThemeProvider.blue2,
      ThemeProvider.blue3,
      ThemeProvider.blue4
    ],
  );

  static final rainbowGradientHorizontal = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      ThemeProvider.red,
      ThemeProvider.orange,
      ThemeProvider.yellow1,
      ThemeProvider.yellow2,
      ThemeProvider.green1,
      ThemeProvider.green2
    ],
  );

  static final transparentWhiteGradientVertical = LinearGradient(
    begin: FractionalOffset.topCenter,
    end: FractionalOffset.bottomCenter,
    colors: [
      Colors.white.withOpacity(0.5),
      Colors.white.withOpacity(0.0),
    ],
    stops: [0.0, 0.5],
  );

  static final greyGradientVertical = LinearGradient(
    begin: FractionalOffset.topCenter,
    end: FractionalOffset.bottomCenter,
    colors: [
      lightGrey1.withOpacity(0.1),
      grey2.withOpacity(0.7),
    ],
    stops: [0.0, 1.0],
  );

  static final greyGradientVertical2 = LinearGradient(
    begin: FractionalOffset.topCenter,
    end: FractionalOffset.bottomCenter,
    colors: [
      grey2.withOpacity(0.7),
      lightGrey1.withOpacity(0.1)
    ],
    stops: [0.0, 1.0],
  );

  static final theme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    fontFamily: 'RobotoRegular',
  );
}