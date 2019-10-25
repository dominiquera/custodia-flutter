import 'package:custodia/services/globals.dart';
import 'package:flutter/material.dart';

import '../../theme-provider.dart';
import 'package:custodia/widgets/blue-rounded-button.dart';
import 'package:custodia/widgets/filter-button.dart';
import '../../screens/questionnaire/step_home_types.dart';

class QuestionnaireStepWhoNeedsScreen extends StatefulWidget {

  QuestionnaireStepWhoNeedsScreen({this.requestData});

  final Map<String, dynamic> requestData;

  @override
  _QuestionnaireStepWhoNeedsScreenState createState() => _QuestionnaireStepWhoNeedsScreenState();
}

class _QuestionnaireStepWhoNeedsScreenState extends State<QuestionnaireStepWhoNeedsScreen> {

  Map<String, dynamic> requestData;
  String selectedPerson;
  int selectedId;

  @override
  void initState() {
    requestData = widget.requestData;
    print(">>>>>>>>>>>>>>>>>>");
    print(requestData);
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
      child: ListView(
        shrinkWrap: true,
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

  List<Widget> buildFilter() {
    return homeOwners.map((item) { return FilterButton(text: item.name, id: item.id, onPressed: onValueSelected); }).toList();
  }

  void onValueSelected(int id){
    selectedId = id;
  }

  loadPreviousStep(){
    Navigator.pop(context);
  }

  loadNextStep() {
    requestData["who_needs"] = selectedId;

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => QuestionnaireStepHomeTypesScreen(requestData: requestData)),
    );
  }
}
