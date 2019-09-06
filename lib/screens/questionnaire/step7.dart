import 'package:flutter/material.dart';

import '../../theme-provider.dart';
import '../../widgets/blue-rounded-button.dart';

class QuestionnaireStep7Screen extends StatefulWidget {
  @override
  _QuestionnaireStep7ScreenState createState() => _QuestionnaireStep7ScreenState();
}

class _QuestionnaireStep7ScreenState extends State<QuestionnaireStep7Screen> {
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
          RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: 35,
                color: Colors.white
              ),
              children: <TextSpan>[
                TextSpan(
                  text: "Ok ",
                  style: TextStyle(
                    fontFamily: "RobotoLight"
                  )
                ),
                TextSpan(
                  text: "John, \n",
                  style: TextStyle(
                    fontFamily: "RobotoMedium"
                  )
                ),
                TextSpan(
                  text: "let's review your dads home managment plan",
                  style: TextStyle(
                    fontFamily: "RobotoLight"
                  )
                ),
              ],
            ),
          ),
          SizedBox(height: 70),
          BlueRoundedButton(text: "Start", onPressed: loadNextStep, padding: 80),
        ],
      ),
    );
  }

  loadNextStep() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => QuestionnaireStep7Screen()),
    );
  }
}