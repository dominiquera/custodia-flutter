import 'package:custodia/screens/dashboard/dashboard.dart';
import 'package:custodia/screens/login/sms-code.dart';
import 'package:custodia/screens/questionnaire/step_intro.dart';
import 'package:custodia/services/firebase-auth.dart';
import 'package:custodia/screens/widgets/blue-rounded-button.dart';
import 'package:custodia/screens/widgets/text-field.dart';
import 'package:flutter/material.dart';
import 'package:custodia/services/api.dart';

import '../../theme-provider.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:validators/validators.dart';

class LoginPhoneNumberScreen extends StatefulWidget {
  @override
  _LoginPhoneNumberScreenState createState() => _LoginPhoneNumberScreenState();
}

class _LoginPhoneNumberScreenState extends State<LoginPhoneNumberScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _phoneNumberController = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool isButtonDisabled = false;

  @override
  void dispose() {
    _phoneNumberController.dispose();
    super.dispose();
  }

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
              phoneForm(),
            ],
          ),
        ),
      ),
    );
  }

  Widget phoneForm(){
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text("Phone number",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: "RobotoMedium"
                )
              ),
            )
          ),
          TextFieldDecorated(
            helperText: "Phone number",
            controller: _phoneNumberController,
            validator: phoneValidator,
            prefix: "+"
          ),
          SizedBox(height: 30),
          BlueRoundedButton(
            text: "Login",
            onPressed: validatePhoneNumber,
            padding: 50,
            disabled: isButtonDisabled
          ),
          SizedBox(height: 40),
          FlatButton(
            child: Text(
              "Back",
              style: TextStyle(
                fontSize: 22,
                color: Colors.white
              )
            ),
            onPressed: () => loadPreviousScreen(context)
          )
        ]
      ),
    );
  }

  loadPreviousScreen(BuildContext context){
    Navigator.pop(context);
  }

  validatePhoneNumber() {
    if (_formKey.currentState.validate()) {
//      setState(() {
//        isButtonDisabled = true;
//      });
      FirebaseAuthService.verifyPhoneNumber(
        _phoneNumberController.text,
        onCodeSend,
        onVerificationCompleted,
        onVerificationFailed
      );
    }
  }

  onCodeSend(String verificationId) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginSmsCodeScreen(verificationId: verificationId)),
    );
  }

  onVerificationCompleted(FirebaseUser user) {
//    print(phoneAuthCredential);
    APIService.signInWithPhoneNumber(user, onAPiSignInSuccess, onApiSignInFailed);

  }

//  onVerificationCompleted(AuthCredential phoneAuthCredential) {
////    print(phoneAuthCredential);
////    APIService.signInWithPhoneNumber(phoneAuthCredential, onAPiSignInSuccess, onApiSignInFailed);
//
//  }

  void onAPiSignInSuccess(){
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => DashboardScreen()), (Route<dynamic> route) => false
    );
  }

  void onApiSignInFailed(FirebaseUser user){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => QuestionnaireStepIntroScreen(user: user)),
    );
  }

  onVerificationFailed(String message){
    showSnackBar("Phone number verification failed. $message");
  }

  void openDashboardScreen(){
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => DashboardScreen()),
    );
    isButtonDisabled = false;
  }

  void openSmsScreen(String verificationId){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginSmsCodeScreen(verificationId: verificationId)),
    );
    isButtonDisabled = false;
  }

  phoneValidator(String value) {
    if (value.isEmpty) {
      return 'Please enter phone number';
    }
//    if (value.length != 8) {
//      return 'Phone number should be 8 characters length';
//    }
    if  (!isNumeric(value)) {
      return 'Phone number should contain only numbers';
    }
    return null;
  }

  void showSnackBar(String message) {
    SnackBar snackBar = SnackBar(
      content: Text(message),
      backgroundColor: ThemeProvider.blue5
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }
}
