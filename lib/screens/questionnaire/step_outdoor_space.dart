import 'package:custodia/models/outdoor_space.dart';
import 'package:custodia/screens/questionnaire/step_driveways.dart';
import 'package:custodia/screens/widgets/centered_progress_indicator.dart';
import 'package:custodia/services/api.dart';
import 'package:flutter/material.dart';

import '../../theme-provider.dart';
import 'package:custodia/widgets/blue-rounded-button.dart';
import 'package:custodia/widgets/filter-button.dart';
import '../../screens/questionnaire/step_mobility_issues.dart';


class QuestionnaireStepOutdoorSpaceScreen extends StatefulWidget {

  QuestionnaireStepOutdoorSpaceScreen({this.requestData});

  final Map<String, dynamic> requestData;

  @override
  _QuestionnaireStepOutdoorSpaceScreenState createState() => _QuestionnaireStepOutdoorSpaceScreenState();
}

class _QuestionnaireStepOutdoorSpaceScreenState extends State<QuestionnaireStepOutdoorSpaceScreen> {

  Map<String, dynamic> requestData;
  List<OutdoorSpace> outdoorSpaces = [];
  List<int> outdoorSpacesSelectedIds = [];

  @override
  void initState() {
    requestData = widget.requestData;
    print(">>>>>>>>>>>>>>>>>>");
    print(requestData);
    fetchOutdoorSpaces();
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
          outdoorSpaces.isEmpty ? CenteredProgressIndicator() : Wrap(
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
    return outdoorSpaces.map((item) { return FilterButton(text: item.name, id: item.id, onPressed: onValueSelected); }).toList();
  }

  void onValueSelected(int id){
    outdoorSpacesSelectedIds.add(id);
  }


  loadPreviousStep(){
    Navigator.pop(context);
  }

  loadNextStep() {
    requestData["outdoor_spaces"] = outdoorSpacesSelectedIds;

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => QuestionnaireStepDrivewaysScreen(requestData: requestData)),
    );
  }

  void fetchOutdoorSpaces() {
    APIService.fetchOutdoorSpaces().then((value) {
      outdoorSpaces = value;
      setState(() {});
    });
  }
}
