import 'package:custodia/screens/dashboard/dashboard.dart';
import 'package:custodia/widgets/blue-rounded-button.dart';
import 'package:custodia/widgets/text-field.dart';
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset("assets/images/logo.png", width: 230),
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
                  fontFamily: "RobotoMedium"
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
    try {
      final FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
      if (user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => DashboardScreen()),
        );
      } else {
        print('Sign in failed');
      }
    } on PlatformException catch (e) {
      if (e.code == "ERROR_INVALID_VERIFICATION_CODE") {
        showSnackBar("Verification code is incorrect");
        setState(() {
          isButtonDisabled = false;
        });
      }
      print(e.code);
    }
  }

  codeValidator(String value) {
    if (value.isEmpty) {
      return 'Please enter SMS code';
    }
    if (value.length != 6) {
      return 'SMS code should be 6 integers';
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
