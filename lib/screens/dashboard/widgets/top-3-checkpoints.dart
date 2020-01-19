import 'package:custodia/models/maintenance_item.dart';
import 'package:custodia/services/api.dart';
import 'package:flutter/material.dart';

import '../../../theme-provider.dart';

class Top3Checkpoints extends StatefulWidget {

  final List<MaintenanceItem>  items;

  Top3Checkpoints({this.items});

  @override
  _Top3CheckpointsState createState() => _Top3CheckpointsState();
}

class _Top3CheckpointsState extends State<Top3Checkpoints> {


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(ThemeProvider.screenPadding),
      decoration: BoxDecoration(
        boxShadow: [
          const BoxShadow(
            color: ThemeProvider.grey2,
            offset: const Offset(0.0, 0.0),
          ),
          const BoxShadow(
            color: ThemeProvider.lightBlue,
            offset: const Offset(0.0, 0.0),
            spreadRadius: -1.0,
            blurRadius: 2.0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "TOP THREE TODAY",
            style: TextStyle(
              fontFamily: "NunitoBlack",
              color: ThemeProvider.orange,
              fontSize: 24,
              shadows: <Shadow>[
                Shadow(
                  offset: Offset(1.0, 1.0),
                  blurRadius: 1.0,
                  color: ThemeProvider.lightGrey1,
                ),
              ]
            )
          ),
          SizedBox(height: 5),
          Text(
            "These are the suggested top three checkpoints",
            style: TextStyle(
              fontFamily: "NunitoMedium",
              color: ThemeProvider.grey2
            )
          ),
          SizedBox(height: 30),
          top3Items()
        ],
      ),
    );
  }

  top3Items(){
    List<Widget> children = [];
    widget.items.asMap().forEach((index, item) { children.add(top3Item(index + 1, item));  });
    return Column(
        children: children
    );
  }

  Widget top3Item(int index, MaintenanceItem maintenanceItem) {
    return Container(
      margin: EdgeInsets.only(bottom: 30),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: ThemeProvider.orange,
                    width: 1.5
                  ),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    index.toString(),
                    style: TextStyle(
                      fontFamily: "NunitoMedium",
                      color: ThemeProvider.orange,
                      fontSize: 22
                    )
                  )
                ),
              ),
              SizedBox(height: 5),
              Text(
                "${maintenanceItem.points} POINTS",
                style: TextStyle(
                  color: ThemeProvider.orange,
                  fontFamily: "NunitoMedium",
                  fontSize: 12
                )
              )
            ]
          ),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(maintenanceItem.title.toUpperCase(),
                  style: TextStyle(
                    fontSize: 22,
                    color: ThemeProvider.darkGrey,
                    fontFamily: "NunitoMedium"
                  )
                ),
                SizedBox(height: 5),
                Text(maintenanceItem.description,
                  style: TextStyle(
                    fontSize: 20,
                    color: ThemeProvider.darkGrey,
                  )
                ),
              ],
            ),
          ),
        ]
      ),
    );
  }
}
