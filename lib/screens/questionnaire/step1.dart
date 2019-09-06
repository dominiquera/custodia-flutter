import 'package:flutter/material.dart';

import '../../theme-provider.dart';
import '../../widgets/blue-rounded-button.dart';
import '../../screens/questionnaire/step2.dart';

class QuestionnaireStep1Screen extends StatefulWidget {

  @override
  _QuestionnaireStep1ScreenState createState() => _QuestionnaireStep1ScreenState();
}

class _QuestionnaireStep1ScreenState extends State<QuestionnaireStep1Screen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: ThemeProvider.blueGradient,
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
          Text("Seniors and their families now have the tool they need to help them live long in their home.",
            style: TextStyle(
              fontSize: 27,
              fontFamily: "RobotoLight",
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
      MaterialPageRoute(builder: (context) => QuestionnaireStep2Screen()),
    );
  }
}
