import 'package:custodia/models/home_owner.dart';
import 'package:custodia/screens/dashboard/dashboard.dart';
import 'package:custodia/services/api.dart';
import 'package:custodia/services/globals.dart';
import 'package:flutter/material.dart';

import '../../theme-provider.dart';
import 'package:custodia/widgets/blue-rounded-button.dart';

class QuestionnaireStepSummaryScreen extends StatefulWidget {

  QuestionnaireStepSummaryScreen({this.requestData});

  final Map<String, dynamic> requestData;

  @override
  _QuestionnaireStepSummaryScreenState createState() => _QuestionnaireStepSummaryScreenState();
}

class _QuestionnaireStepSummaryScreenState extends State<QuestionnaireStepSummaryScreen> {

  HomeOwner owner;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>summary");
    print(widget.requestData);
    owner = homeOwners.firstWhere((item) { return item.id == widget.requestData["who_needs"][0]; });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        decoration: BoxDecoration(
          gradient: ThemeProvider.blueGradientDiagonal,
        ),
        padding: EdgeInsets.symmetric(horizontal: 45),
        child: body(),
      ),
    );
  }

  Widget body() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: 35,
                color: Colors.white
              ),
              children: <TextSpan>[
                TextSpan(
                  text: "Ok ",
                  style: TextStyle(
                    fontFamily: "RobotoLight"
                  )
                ),
                TextSpan(
                  text: "${widget.requestData["name"]}, \n",
                  style: TextStyle(
                    fontFamily: "RobotoMedium"
                  )
                ),
                TextSpan(
                  text: "let's review your ${owner.name} home managment plan",
                  style: TextStyle(
                    fontFamily: "RobotoLight"
                  )
                ),
              ],
            ),
          ),
          SizedBox(height: 70),
          BlueRoundedButton(text: "Start", onPressed: loadDashboard, padding: 80),
        ],
      ),
    );
  }

  loadDashboard() {
    APIService.createUser(
        widget.requestData["token"],
        widget.requestData["name"],
        widget.requestData["email"],
        widget.requestData["home_type"],
        widget.requestData["outdoor_spaces"],
        widget.requestData["home_features"],
        widget.requestData["driveways"],
        widget.requestData["mobility_issues"], onRegistrationSuccess, onRegistrationFailure);
  }

  void onRegistrationSuccess(){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DashboardScreen()),
    );
  }

  void onRegistrationFailure(){
    final snackBar = SnackBar(content: Text('Something went wrong'));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }
}