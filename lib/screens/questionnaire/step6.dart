import 'package:flutter/material.dart';

import '../../theme-provider.dart';
import '../../widgets/blue-rounded-button.dart';
import '../../widgets/filter-button.dart';
import '../../screens/questionnaire/step7.dart';

class QuestionnaireStep6Screen extends StatefulWidget {
  @override
  _QuestionnaireStep6ScreenState createState() => _QuestionnaireStep6ScreenState();
}

class _QuestionnaireStep6ScreenState extends State<QuestionnaireStep6Screen> {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Does your Dad have any mobility issues?",
            style: TextStyle(
              fontSize: 35,
              fontFamily: "RobotoLight",
              color: Colors.white
            )
          ),
          Text("Select any one below",
            style: TextStyle(
              fontSize: 18,
              fontFamily: "RobotoLight",
              color: Colors.white
            )
          ),
          SizedBox(height: 80),
          Wrap(
            runSpacing: 10,
            spacing: 10,
            children: buildFilter()
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

  List<Widget> buildFilter() {
    List<Widget> filters = [];
    List<String> list = ["No", "Mild", "Some Difficulty"];
    list.forEach((i){
      filters.add(FilterButton(text: i));
    });
    return filters;
  }

  loadPreviousStep(){
    Navigator.pop(context);
  }

  loadNextStep() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => QuestionnaireStep7Screen()),
    );
  }
}