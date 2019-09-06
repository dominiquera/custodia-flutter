import 'package:flutter/material.dart';

import '../theme-provider.dart';

class FilterButton extends StatefulWidget {

  FilterButton({this.text});

  final String text;

  @override
  _FilterButtonState createState() => _FilterButtonState();
}

class _FilterButtonState extends State<FilterButton> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: changeColor,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
          color: selected ? ThemeProvider.blue4 : ThemeProvider.lightGrey,
          borderRadius: BorderRadius.circular(5.0)
        ),
        child: Text(
          widget.text,
          style: TextStyle(
            fontSize: 16,
            fontFamily: "RobotoRegular",
            color: selected ? Colors.white : Colors.grey
          )
        )
      ),
    );
  }

  void changeColor() {
    setState(() {
      selected = !selected;
    });
  }
}
