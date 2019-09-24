import 'package:flutter/material.dart';

import '../../../theme-provider.dart';


class Top3Checkpoints extends StatelessWidget {

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
              fontFamily: "RobotoBlack",
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
              fontFamily: "RobotoMedium",
              color: ThemeProvider.grey2
            )
          ),
          SizedBox(height: 30),
          top3Item("Bathroom deep clean", "This is one of the busiest rooms in the house need to be clean", 1, 10),
          top3Item("Bathroom deep clean", "This is one of the busiest rooms in the house need to be clean", 2, 10),
          top3Item("Bathroom deep clean", "This is one of the busiest rooms in the house need to be clean", 3, 10)
        ],
      ),
    );
  }

  Widget top3Item(String title, String description, int count, int points) {
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
                    count.toString(),
                    style: TextStyle(
                      fontFamily: "RobotoMedium",
                      color: ThemeProvider.orange,
                      fontSize: 22
                    )
                  )
                ),
              ),
              SizedBox(height: 5),
              Text(
                "$points POINTS",
                style: TextStyle(
                  color: ThemeProvider.orange,
                  fontFamily: "RobotoMedium",
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
                Text(title.toUpperCase(),
                  style: TextStyle(
                    fontSize: 22,
                    color: ThemeProvider.darkGrey,
                    fontFamily: "RobotoMedium"
                  )
                ),
                SizedBox(height: 5),
                Text(description,
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
