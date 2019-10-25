import 'package:custodia/screens/dashboard/dashboard.dart';
import 'package:custodia/screens/login/phone-number.dart';
import 'package:custodia/screens/questionnaire/step_intro.dart';
import 'package:custodia/services/api.dart';
import 'package:custodia/services/firebase-auth.dart';
import 'package:custodia/widgets/blue-rounded-button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../theme-provider.dart';

class LoginSelectScreen extends StatelessWidget {

  BuildContext ctx;

  @override
  Widget build(BuildContext context) {
    ctx = context;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(30),
        decoration: BoxDecoration(
          gradient: ThemeProvider.blueTransparentGradientDiagonal
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset("assets/images/logo.png", width: 230),
            SizedBox(height: 100),
            SizedBox(
              width: double.infinity,
              child: BlueRoundedButton(text: "Login with phone number", onPressed: () => openPhoneNumberLogin(context),)
            ),
            SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: BlueRoundedButton(text: "Login with Google", onPressed: () => FirebaseAuthService.signInWithGoogle(onGoogleSignInSuccess))
            ),
          ],
        ),
      ),
    );
  }

  void onGoogleSignInSuccess(AuthResult authResult){

    APIService.signInWithGoogleId(authResult, onAPiSignInSuccess, onSignInFailed);
  }


  void openPhoneNumberLogin(BuildContext context) {
    Navigator.push(
      ctx,
      MaterialPageRoute(builder: (context) => LoginPhoneNumberScreen()),
    );
  }

  void onAPiSignInSuccess(){
    Navigator.pushReplacement(
      ctx,
      MaterialPageRoute(builder: (context) => DashboardScreen()),
    );
  }

  void onSignInFailed(AuthResult authResult){
    Navigator.push(
      ctx,
      MaterialPageRoute(builder: (context) => QuestionnaireStepIntroScreen(authResult: authResult)),
    );
  }
}
