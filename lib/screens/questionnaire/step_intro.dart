import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../theme-provider.dart';
import 'package:custodia/screens/widgets/blue-rounded-button.dart';
import '../../screens/questionnaire/step_name.dart';

class QuestionnaireStepIntroScreen extends StatefulWidget {

  QuestionnaireStepIntroScreen({this.user, this.token});
  final FirebaseUser user;
  final String token;

  @override
  _QuestionnaireStepIntroScreenState createState() => _QuestionnaireStepIntroScreenState();
}

class _QuestionnaireStepIntroScreenState extends State<QuestionnaireStepIntroScreen> {

  Map<String, dynamic> requestData = {
    "email": null,
    "phone": null,
    "name": null,
    "uid": null,
    "who_needs": null,
    "home_type": null,
    "home_features": null,
    "driveways": null,
    "outdoor_spaces": null,
    "mobility_issues": null,
    "address": null,
    "zip_code": null,
    "token": null,
    "firebase_user": null,
  };

  @override
  void initState() {
    getToken();
    requestData["email"] = widget.user.email;
    requestData["uid"] = widget.user.uid;
    requestData["phone"] = widget.user.phoneNumber;
    requestData["firebase_user"] = widget.user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          Text("Now seniors can live longer, safer, and more enjoyable lives at home.",
            style: TextStyle(
              fontSize: 27,
              fontFamily: "NunitoLight",
              color: Colors.white
            )
          ),
          SizedBox(height: 40),
          BlueRoundedButton(text: "Next", onPressed: loadNextStep, padding: 80),
        ],
      ),
    );
  }

  loadNextStep() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => QuestionnaireStepNameScreen(requestData: requestData)),
    );
  }

  void getToken() async {
    IdTokenResult token = await widget.user.getIdToken();
    requestData["token"] = token.token;
  }
}
