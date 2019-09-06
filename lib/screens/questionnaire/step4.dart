import 'package:flutter/material.dart';

import '../../theme-provider.dart';
import '../../widgets/blue-rounded-button.dart';
import '../../widgets/filter-button.dart';
import '../../screens/questionnaire/step5.dart';

class QuestionnaireStep4Screen extends StatefulWidget {
  @override
  _QuestionnaireStep4ScreenState createState() => _QuestionnaireStep4ScreenState();
}

class _QuestionnaireStep4ScreenState extends State<QuestionnaireStep4Screen> {
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
          Text("What type of home is it?",
            style: TextStyle(
              fontSize: 35,
              fontFamily: "RobotoLight",
              color: Colors.white
            )
          ),
          Text("Select one",
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
    List<String> list = ["Small Bungalow", "Small Condo", "Large Bungalow", "Large Condo", "Small 2-Story", "Larger Home"];
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
      MaterialPageRoute(builder: (context) => QuestionnaireStep5Screen()),
    );
  }
}
