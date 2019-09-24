import 'package:flutter/material.dart';

import '../../theme-provider.dart';
import 'package:custodia/widgets/blue-rounded-button.dart';
import 'package:custodia/widgets/filter-button.dart';
import '../../screens/questionnaire/step4.dart';

class QuestionnaireStep3Screen extends StatefulWidget {
  @override
  _QuestionnaireStep3ScreenState createState() => _QuestionnaireStep3ScreenState();
}

class _QuestionnaireStep3ScreenState extends State<QuestionnaireStep3Screen> {
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
          Text("Who needs a home managment plan?",
            style: TextStyle(
              fontSize: 35,
              fontFamily: "RobotoLight",
              color: Colors.white
            )
          ),
          SizedBox(height: 10),
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
            children: buildFilter(),
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
      MaterialPageRoute(builder: (context) => QuestionnaireStep4Screen()),
    );
  }

  List<Widget> buildFilter() {
    List<Widget> filters = [];
    List<String> list = ["Mom", "Dad", "Me", "Other"];
    list.forEach((i){
      filters.add(
        FilterButton(text: i)
      );
    });
    return filters;
  }
}
