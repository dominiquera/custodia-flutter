import 'package:custodia/screens/dashboard/dashboard.dart';
import 'package:custodia/screens/login/sms-code.dart';
import 'package:custodia/widgets/blue-rounded-button.dart';
import 'package:custodia/widgets/text-field.dart';
import 'package:flutter/material.dart';

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset("assets/images/logo.png", width: 230),
            SizedBox(height: 70),
            phoneForm(),
          ],
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
      setState(() {
        isButtonDisabled = true;
      });
      _verifyPhoneNumber();
    }
  }

  void _verifyPhoneNumber() async {
    final PhoneVerificationCompleted verificationCompleted = (AuthCredential phoneAuthCredential) {
      print(">>>>>>>Received phone auth credential: $phoneAuthCredential");

      _auth.signInWithCredential(phoneAuthCredential);
      openDashboardScreen();
    };

    final PhoneVerificationFailed verificationFailed = (AuthException authException) {
      print(">>>>>>Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}");
      showSnackBar("Phone number verification failed. ${authException.message}");
    };

    final PhoneCodeSent codeSent = (String verificationId, [int forceResendingToken]) async {
      print('>>>>>>Please check your phone for the verification code.');
      openSmsScreen(verificationId);
    };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout = (String verificationId) {
      print(">>>>>codeAutoRetrievalTimeout");
    };

    await _auth.verifyPhoneNumber(
      phoneNumber: "+${_phoneNumberController.text}",
      timeout: const Duration(seconds: 5),
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
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
