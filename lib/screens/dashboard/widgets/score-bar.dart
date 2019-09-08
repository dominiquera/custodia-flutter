import 'package:flutter/material.dart';

import '../../../theme-provider.dart';

class ScoreBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      scoreBarTopLabels(),
      SizedBox(height: 5),
      scoreBar(),
      SizedBox(height: 5),
      scoreBarBottomLabels()
    ]);
  }

  Widget scoreBar() {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(5),
          height: 16.5,
          decoration: BoxDecoration(
            gradient: ThemeProvider.rainbowGradientHorizontal,
          ),
        ),
        Container(
          height: 15,
          decoration: BoxDecoration(
              gradient: ThemeProvider.rainbowGradientHorizontal,
              borderRadius: BorderRadius.circular(6)
          ),
        ),
        Container(
          height: 15,
          decoration: BoxDecoration(
              gradient: ThemeProvider.transparentWhiteGradientVertical,
              borderRadius: BorderRadius.circular(6)
          ),
        ),
        Positioned(
          left: 250,
          child: Image.asset("assets/images/pointer.png", width: 10),
        ),
      ]
    );
  }

  Widget scoreBarTopLabels() {
    List<String> values = ["300", "580", "640", "700", "750", "850"];
    List<Widget> widgets = [];
    values.forEach((i){
      widgets.add(Text(i, style: TextStyle(fontSize: 12),));
    });
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: widgets
    );
  }

  Widget scoreBarBottomLabels() {
    List<String> values = ["VERY POOR", "POOR", "FAIR", "GOOD", "EXCELLENT"];
    List<Widget> widgets = [];
    values.forEach((i){
      widgets.add(Text(i, style: TextStyle(fontSize: 12, color: ThemeProvider.grey1),));
    });
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: widgets
    );
  }
}
