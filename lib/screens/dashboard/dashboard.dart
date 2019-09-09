import 'package:custodia/screens/dashboard/widgets/clean-this-week.dart';
import 'package:custodia/screens/dashboard/widgets/outside-this-week.dart';
import 'package:custodia/screens/dashboard/widgets/prevent-this-week.dart';
import 'package:custodia/screens/dashboard/widgets/score-bar.dart';
import 'package:custodia/screens/dashboard/widgets/top-3-checkpoints.dart';
import 'package:custodia/widgets/drawer.dart';
import 'package:flutter/material.dart';

import 'package:gradient_app_bar/gradient_app_bar.dart';

import '../../constants.dart';
import '../../theme-provider.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Drawer(
        child: DrawerContent()// Populate the Drawer in the next step.
      ),
      appBar: GradientAppBar(
        title: Text('July 3', style: TextStyle(fontFamily: "RobotoBlack", fontSize: 28)),
        centerTitle: false,
        gradient: ThemeProvider.blueGradientHorizontal,
        automaticallyImplyLeading: false,

//          : IconButton(
//            icon: Icon(Icons.apps)),
//              onPressed: () => _scaffoldKey.currentState.openDrawer()),
      ),
      body: body(),
    );
  }

  Widget body() {
    return ListView(
      children: <Widget>[
        header(),
        stepsCircles(),
        score(),
        Top3Checkpoints(),
        OutsideThisWeek(),
        PreventThisWeek(),
        CleanThisWeek()
      ]
    );
  }

  Widget header() {
    return Stack(
      alignment: Alignment.bottomLeft,
      children: <Widget>[
        Image.asset("assets/images/house.jpg", height: 500, fit: BoxFit.fitHeight,),
        Padding(
          padding: EdgeInsets.all(Constants.screenPadding),
          child: Column(
            children: <Widget>[
              Text(
                "Dads Home Management Plan",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 34,
                  fontFamily: "RobotoBlack"
                )
              ),
              SizedBox(height: 15),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      "A 4 bedroom bungalow with 3000 sq/ft of lawn, a few hedges, gardens and a pool",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      )
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                    decoration: BoxDecoration(
                      color: ThemeProvider.lime,
                      borderRadius: BorderRadius.circular(20.0)
                    ),
                    child: Text("222/721",
                      style: TextStyle(
                        fontSize: 16,
                        color: ThemeProvider.blue6,
                      )
                    )
                  )
                ],
              )
            ]
          ),
        )
      ],
    );
  }

  Widget stepsCircles() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Constants.screenPadding),
      child: Column(
        children: <Widget>[
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

      ),

    );
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
              fontFamily: "RobotoMedium",
              color: ThemeProvider.grey1,
              height: 0.9
            ),)
        ],
      ),
    );
  }


  Widget score() {
    return Padding(
      padding: EdgeInsets.only(top: 0, bottom: Constants.screenPadding),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Constants.screenPadding),
            child: Text(
              "Good morning John, just a few things on for this week. Here is your dad's current Home Score.",
              style: TextStyle(
                fontSize: 26,
                fontFamily: "RobotoMedium"
              ),
            ),
          ),
          SizedBox(height: 30),
          Container(
            height: 5,
            decoration: BoxDecoration(
              gradient: ThemeProvider.greyGradientVertical
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Constants.screenPadding),
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    padding: EdgeInsets.all(0),
                    onPressed: (){
                      print("zz");
                    },
                    icon: Icon(Icons.info, color: ThemeProvider.blue1)
                  ),
                ),
                ScoreBar()
              ]
            ),
          ),
        ],
      ),
    );
  }

}
