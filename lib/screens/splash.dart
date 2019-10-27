import 'package:custodia/screens/questionnaire/step_intro.dart';
import 'package:custodia/services/api.dart';
import 'package:custodia/utils/shared-prefs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../theme-provider.dart';
import 'dashboard/dashboard.dart';
import 'login/select.dart';

class SplashScreen extends StatefulWidget {

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(30),
        decoration: BoxDecoration(
          gradient: ThemeProvider.blueTransparentGradientDiagonal
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset("assets/images/logo.png", width: 100)
          ]
        ),
      ),
    );
  }

  void getUser() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
//    TODO get authResult
    var authResult;
    if (user != null) {
      print(">>>>>>>>user != null");
      APIService.signInWithPhoneNumber(authResult, onAPiSignInSuccess, onApiSignInFailed);
    } else {
      print(">>>>>>>>user == null");

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginSelectScreen()),
      );
    }
  }

  void onAPiSignInSuccess(){
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => DashboardScreen()),
    );
  }

  void onApiSignInFailed(AuthResult result){
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => QuestionnaireStepIntroScreen(authResult: result)),
    );
  }
}