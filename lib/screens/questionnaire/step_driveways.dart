import 'package:custodia/models/driveway_type.dart';
import 'package:custodia/screens/questionnaire/step_mobility_issues.dart';
import 'package:custodia/screens/widgets/progress-indicator.dart';
import 'package:custodia/services/api.dart';
import 'package:flutter/material.dart';

import '../../theme-provider.dart';
import 'package:custodia/widgets/blue-rounded-button.dart';
import 'package:custodia/widgets/filter-button.dart';

class QuestionnaireStepDrivewaysScreen extends StatefulWidget {

  QuestionnaireStepDrivewaysScreen({this.requestData});

  final Map<String, dynamic> requestData;

  @override
  _QuestionnaireStepDrivewaysScreenState createState() => _QuestionnaireStepDrivewaysScreenState();
}

class _QuestionnaireStepDrivewaysScreenState extends State<QuestionnaireStepDrivewaysScreen> {

  Map<String, dynamic> requestData;
  List<DrivewayType> driveways = [];
  List<int> selectedDrivewaysIds = [];

  @override
  void initState() {
    requestData = widget.requestData;
    print(">>>>>>>>>>>>>>>>>>");
    print(requestData);
    fetchDriveways();
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
          Text("What type of driveways this home have",
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
          driveways.isEmpty ? ProgressIndicatorWithPadding() : Wrap(
            runSpacing: 10,
            spacing: 5,
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
    return driveways.map((item) { return FilterButton(text: item.name, id: item.id, onPressed: onValueChanged,); }).toList();
  }

  void onValueChanged(int id){
    selectedDrivewaysIds.add(id);
  }

  loadPreviousStep(){
    Navigator.pop(context);
  }

  loadNextStep() {
    requestData["driveways"] = selectedDrivewaysIds;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => QuestionnaireStepMobilityIssuesScreen(requestData: requestData,)),
    );
  }

  void fetchDriveways() {
    APIService.fetchDrivewayTypes().then((value) {
      setState(() {
        driveways = value;
      });
    });
  }

}