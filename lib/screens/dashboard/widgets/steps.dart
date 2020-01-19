import 'package:custodia/utils/shared-prefs.dart';
import 'package:flutter/material.dart';

import '../../../theme-provider.dart';

class Steps extends StatefulWidget {
  @override
  _StepsState createState() => _StepsState();
}

class _StepsState extends State<Steps> {

  bool stepsClosed = false;

  @override
  Widget build(BuildContext context) {
    if (stepsClosed != null && stepsClosed == false) {
      return Column(
        children: <Widget>[
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              icon: Icon(Icons.close, color: ThemeProvider.darkGrey,),
              onPressed: setSharedPrefs,
            ),
          ),
          Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 45.0),
                child: Divider(height: 2, color: ThemeProvider.grey1),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  stepCircle("1", ThemeProvider.blue1),
                  stepCircle("2", ThemeProvider.green1),
                  stepCircle("3", ThemeProvider.blue5)
                ]
              ),
            ],
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                stepDescription("Review the check points"),
                stepDescription("Do it automate it or ignore it"),
                stepDescription("Watch your score")
              ]
          ),
          SizedBox(height: 20),
          Divider(height: 2, color: ThemeProvider.darkGrey)
        ],
      );
    } else {
      return Container();
    }
  }

  Widget stepCircle(String number, Color color) {
    return Container(
      width: 110,
      child: Column(
        children: <Widget>[
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                number,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28
                )
              )
            ),
          ),
        ],
      ),
    );
  }

  Widget stepDescription(String description) {
    return Container(
      width: 110,
      child: Column(
        children: <Widget>[
          SizedBox(height: 10),
          Text(description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22,
              fontFamily: "NunitoMedium",
              color: ThemeProvider.grey1,
              height: 0.9
            )
          )
        ],
      ),
    );
  }

  void setSharedPrefs() async {
    SharedPrefsService.setStepsState();
    setState(() { stepsClosed = true; });
  }
}
