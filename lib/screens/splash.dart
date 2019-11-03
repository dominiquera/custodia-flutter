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

//  login user with Firebase, then check if there is user in database
  void getUser() async {

    FirebaseAuth.instance.currentUser().then((user) {

      if (user != null) {
        if (user.phoneNumber != null && user.phoneNumber.isNotEmpty) {
          APIService.signInWithPhoneNumber(user, onAPIPhoneNumberSignInSuccess, onAPIPhoneNumberSignInFailed);
        } else if (user.email != null && user.email.isNotEmpty) {
          APIService.signInWithGoogleId(user, onAPIGoogleSignInSuccess, onAPIGoogleSignInFail);
        }
      } else {

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginSelectScreen()),
        );
      }

    });

  }

  void onAPIPhoneNumberSignInSuccess(){
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => DashboardScreen()),
    );
  }

  void onAPIPhoneNumberSignInFailed(FirebaseUser user){
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => QuestionnaireStepIntroScreen(user: user)),
    );
  }

  void onAPIGoogleSignInSuccess(){
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => DashboardScreen()),
    );
  }

  void onAPIGoogleSignInFail(FirebaseUser user){
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => QuestionnaireStepIntroScreen(user: user)),
    );
  }
}