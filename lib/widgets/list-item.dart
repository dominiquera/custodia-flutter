import 'package:flutter/material.dart';

import '../constants.dart';

class ListItem extends StatefulWidget {

  ListItem({this.description, this.color});

  final String description;
  final Color color;

  @override
  _ListItemState createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: Constants.screenPadding, left: Constants.screenPadding, right: Constants.screenPadding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: widget.color,
              borderRadius: BorderRadius.circular(3)
            ),
            width: 90,
            height: 90,
          ),
          SizedBox(width: 25),
          Expanded(
            child: Text(
              widget.description,
              style: TextStyle(
                fontSize: 20,
              )
            ),
          )
        ],
      ),
    );
  }
}
