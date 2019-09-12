import 'package:custodia/screens/dashboard/widgets/clean-this-week.dart';
import 'package:custodia/screens/dashboard/widgets/focus-on-products.dart';
import 'package:custodia/screens/dashboard/widgets/focus-on-stories.dart';
import 'package:custodia/screens/dashboard/widgets/outside-this-week.dart';
import 'package:custodia/screens/dashboard/widgets/prevent-this-week.dart';
import 'package:custodia/screens/dashboard/widgets/score-bar.dart';
import 'package:custodia/screens/dashboard/widgets/steps.dart';
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
      ),
      body: body(),
    );
  }

  Widget body() {
    return ListView(
      children: <Widget>[
        header(),
        Steps(),
        score(),
        Top3Checkpoints(),
        OutsideThisWeek(),
        PreventThisWeek(),
        CleanThisWeek(),
        FocusOnStories(),
        FocusOnProducts()
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

  Widget score() {
    return Padding(
      padding: EdgeInsets.only(top: Constants.screenPadding, bottom: Constants.screenPadding),
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
