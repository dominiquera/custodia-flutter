import 'package:flutter/material.dart';

import '../../theme-provider.dart';
import 'package:custodia/widgets/blue-rounded-button.dart';
import 'package:custodia/screens/questionnaire/widgets/filter-button.dart';
import '../../screens/questionnaire/step6.dart';


class QuestionnaireStep5Screen extends StatefulWidget {
  @override
  _QuestionnaireStep5ScreenState createState() => _QuestionnaireStep5ScreenState();
}

class _QuestionnaireStep5ScreenState extends State<QuestionnaireStep5Screen> {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Does it have any outdoor space?",
            style: TextStyle(
              fontSize: 35,
              fontFamily: "RobotoLight",
              color: Colors.white
            )
          ),
          Text("Select all that apply",
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
    List<String> list = ["Small Yard", "Medium Yard", "Large Yard", "Small Deck", "Hedges", "Many tress", "Pool"];
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
      MaterialPageRoute(builder: (context) => QuestionnaireStep6Screen()),
    );
  }
}
