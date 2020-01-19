import 'package:custodia/screens/dashboard/dashboard.dart';
import 'package:custodia/screens/questionnaire/step_intro.dart';
import 'package:custodia/services/api.dart';
import 'package:custodia/services/firebase-auth.dart';
import 'package:custodia/screens/widgets/blue-rounded-button.dart';
import 'package:custodia/screens/widgets/text-field.dart';
import 'package:flutter/material.dart';
import '../../theme-provider.dart';

import 'package:flutter/services.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:validators/validators.dart';

class LoginSmsCodeScreen extends StatefulWidget {

  LoginSmsCodeScreen({this.verificationId});

  final String verificationId;

  @override
  _LoginSmsCodeScreenState createState() => _LoginSmsCodeScreenState();
}

class _LoginSmsCodeScreenState extends State<LoginSmsCodeScreen> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _smsController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool isButtonDisabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        padding: EdgeInsets.all(30),
        decoration: BoxDecoration(
          gradient: ThemeProvider.blueTransparentGradientDiagonal
        ),
        child: Center(
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Container(
                height: 100,
                child: Image.asset("assets/images/logo.png")
              ),
              SizedBox(height: 70),
              smsForm(),
              SizedBox(height: 40),
              FlatButton(
                child: Text(
                  "Back",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white
                  )
                ),
                onPressed: () => loadPreviousScreen(context)
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget smsForm(){
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                "SMS Code",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: "NunitoMedium"
                )
              ),
            )
          ),
          TextFieldDecorated(
            helperText: "SMS Code",
            controller: _smsController,
            validator: codeValidator),
          SizedBox(height: 30),
          BlueRoundedButton(
            text: "Login",
            onPressed: validateSMSCode,
            padding: 50,
            disabled: isButtonDisabled),
        ]
      ),
    );
  }

  loadPreviousScreen(BuildContext context){
    Navigator.pop(context);
  }

  void _signInWithPhoneNumber() async {
    final AuthCredential credential = PhoneAuthProvider.getCredential(
      verificationId: widget.verificationId,
      smsCode: _smsController.text,
    );
    FirebaseAuthService.signInWIthPhoneNumber(credential, onSignInSuccess, onSignInError);
  }

  void onSignInSuccess(FirebaseUser user) {
    print(">>>>onSignInSuccess");
    APIService.signInWithPhoneNumber(user, onAPiSignInSuccess, onApiSignInFailed);

//    if (isNewUser) {
//      openQuestionnaireScreen();
//    } else {
//      openDashboardScreen();
//    }
  }

  void onAPiSignInSuccess(){
    print(">>>>API onSignInSuccess");

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => DashboardScreen()),
    );
  }

  void onApiSignInFailed(FirebaseUser user){
    print(">>>>API onApiSignInFailed");

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => QuestionnaireStepIntroScreen(user: user)),
    );
  }

  void onSignInError() {
    showSnackBar("Verification code is incorrect");
    setState(() {
      isButtonDisabled = false;
    });
  }

  codeValidator(String value) {
    if (value.isEmpty) {
      return 'Please enter SMS code';
    }
    if (value.length != 6) {
      return 'SMS code should be 6 digits';
    }
    if (!isNumeric(value)) {
      return 'SMS code should contain only numbers';
    }
    return null;
  }

  validateSMSCode(){
    if (_formKey.currentState.validate()) {
      setState(() {
        isButtonDisabled = true;
      });
      _signInWithPhoneNumber();
    }
  }

  void showSnackBar(String message) {
    SnackBar snackBar = SnackBar(
      content: Text(message),
      backgroundColor: ThemeProvider.blue5
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }
}
