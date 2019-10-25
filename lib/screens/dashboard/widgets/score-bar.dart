import 'package:custodia/models/score.dart';
import 'package:flutter/material.dart';

import '../../../theme-provider.dart';

class ScoreBar extends StatefulWidget {

  ScoreBar({this.score});

  final Score score;

  @override
  _ScoreBarState createState() => _ScoreBarState();
}

class _ScoreBarState extends State<ScoreBar> {
  GlobalKey _keyScoreBar = GlobalKey();
  var position;

  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
    super.initState();
  }

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
      key: _keyScoreBar,
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
          left: position != null ? position : 0,
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

  _afterLayout(_) {
    final RenderBox renderBox = _keyScoreBar.currentContext.findRenderObject();
    final width = renderBox.size.width;
    var point = width / 1150;
    print("SIZE: $width");
    print(point);
    print(widget.score.value);
    setState(() {
      print("set State>>>");
      position = point * 500;
      print(position);

    });
  }
}
