import 'package:flutter/material.dart';

class ListItem extends StatefulWidget {

  ListItem({this.title, this.description, this.color});

  final String title;
  final String description;
  final Color color;

  @override
  _ListItemState createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.title.toUpperCase(),
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: "RobotoMedium"
                  )
                ),
                Text(
                  widget.description,
                  style: TextStyle(
                    fontSize: 20,
                  )
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
