import 'package:custodia/models/home_owner.dart';
import 'package:custodia/screens/dashboard/dashboard.dart';
import 'package:custodia/services/api.dart';
import 'package:custodia/services/globals.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../theme-provider.dart';
import 'package:custodia/screens/widgets/blue-rounded-button.dart';

class QuestionnaireStepSummaryScreen extends StatefulWidget {

  QuestionnaireStepSummaryScreen({this.requestData});

  final Map<String, dynamic> requestData;

  @override
  _QuestionnaireStepSummaryScreenState createState() => _QuestionnaireStepSummaryScreenState();
}

class _QuestionnaireStepSummaryScreenState extends State<QuestionnaireStepSummaryScreen> {

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    //owner = managementPlans.firstWhere((item) { return item.id == widget.requestData["who_needs"][0]; });
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
                    fontFamily: "NunitoLight"
                  )
                ),
                TextSpan(
                  text: "${widget.requestData["name"]}, \n",
                  style: TextStyle(
                    fontFamily: "NunitoMedium"
                  )
                ),
                TextSpan(
                  //text: "let's review your ${owner.name} home managment plan",
                  text: "let's review your home managment plan",
                  style: TextStyle(
                    fontFamily: "NunitoLight"
                  )
                ),
              ],
            ),
          ),
          SizedBox(height: 70),
          BlueRoundedButton(text: "Start", onPressed: registerUser, padding: 80),
        ],
      ),
    );
  }

  registerUser() {
    APIService.createUser(
        widget.requestData["uid"],
        widget.requestData["token"],
        widget.requestData["name"],
        widget.requestData["email"],
        widget.requestData["home_type"],
        widget.requestData["outdoor_spaces"],
        widget.requestData["home_features"],
        widget.requestData["driveways"],
        widget.requestData["mobility_issues"],
        widget.requestData["who_needs"],
        widget.requestData["phone"],
        widget.requestData["address"],
        widget.requestData["zip_code"],
        onRegistrationSuccess, onRegistrationFailure);
  }

  void onRegistrationSuccess(){
    APIService.signInWithGoogleId(widget.requestData["firebase_user"], onAPIGoogleSignInSuccess, onAPIGoogleSignInFail);
  }

  void onAPIGoogleSignInSuccess(){
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => DashboardScreen()), (Route<dynamic> route) => false
    );
  }

  void onAPIGoogleSignInFail(){
    print("Failed API sign in");
  }

  void onRegistrationFailure(){
    final snackBar = SnackBar(content: Text('Something went wrong'));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }
}