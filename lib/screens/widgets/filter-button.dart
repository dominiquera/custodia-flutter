import 'package:flutter/material.dart';

import '../../theme-provider.dart';

class FilterButton extends StatefulWidget {

  FilterButton({this.text, this.id, this.onSelected, this.onDeselected});

  final String text;
  final int id;
  final Function onSelected;
  final Function onDeselected;

  @override
  _FilterButtonState createState() => _FilterButtonState();
}

class _FilterButtonState extends State<FilterButton> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: changeState,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
          color: selected ? ThemeProvider.green3 : ThemeProvider.lightGrey1,
          borderRadius: BorderRadius.circular(5.0)
        ),
        child: Text(
          widget.text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            color: selected ? Colors.white : Colors.grey
          )
        )
      ),
    );
  }

  void changeState() {
    setState(() {
      selected = !selected;
    });
    if (selected) {
      widget.onSelected(widget.id);
    } else {
      widget.onDeselected(widget.id);
    }
  }
}
