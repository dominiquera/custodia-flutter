import 'package:custodia/screens/dashboard/dashboard.dart';
import 'package:custodia/screens/login/phone-number.dart';
import 'package:custodia/widgets/blue-rounded-button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../theme-provider.dart';

class LoginSelectScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
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
              child: BlueRoundedButton(text: "Login with Google", onPressed: () => loginWithGoogle(context))
            ),
          ],
        ),
      ),
    );
  }

  loginWithGoogle(BuildContext context) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final GoogleSignIn _googleSignIn = GoogleSignIn();

    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
      if (user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => DashboardScreen()),
        );
      }
  }


  openPhoneNumberLogin(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPhoneNumberScreen()),
    );
  }
}
