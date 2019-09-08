import 'package:flutter/material.dart';

import '../../theme-provider.dart';
import 'package:custodia/widgets/blue-rounded-button.dart';
import '../../screens/questionnaire/step3.dart';

class QuestionnaireStep2Screen extends StatefulWidget {
  @override
  _QuestionnaireStep2ScreenState createState() => _QuestionnaireStep2ScreenState();
}

class _QuestionnaireStep2ScreenState extends State<QuestionnaireStep2Screen> {
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
          Text("What's your name",
            style: TextStyle(
              fontSize: 35,
              fontFamily: "RobotoLight",
              color: Colors.white
            )
          ),
          SizedBox(height: 100),
          TextField(
            style: TextStyle(
              fontSize: 30, color:
              Colors.white,
            ),
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: ThemeProvider.blue1)),
              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: ThemeProvider.blue1))
            ),
          ),
          SizedBox(height: 70),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              BlueRoundedButton(text: "Back", onPressed:  loadPreviousStep, padding: 35),
              BlueRoundedButton(text: "Next", onPressed: loadNextStep, padding: 35)
            ],
          )
        ],
      ),
    );
  }

  loadPreviousStep(){
    Navigator.pop(context);
  }

  loadNextStep() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => QuestionnaireStep3Screen()),
    );
  }
}
