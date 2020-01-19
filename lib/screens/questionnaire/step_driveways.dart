import 'package:custodia/models/driveway_type.dart';
import 'package:custodia/screens/questionnaire/step_mobility_issues.dart';
import 'package:custodia/screens/widgets/centered_progress_indicator.dart';
import 'package:custodia/screens/widgets/progress-indicator.dart';
import 'package:custodia/services/api.dart';
import 'package:flutter/material.dart';

import '../../theme-provider.dart';
import 'package:custodia/screens/widgets/blue-rounded-button.dart';
import 'package:custodia/screens/widgets/filter-button.dart';

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
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    requestData = widget.requestData;
    fetchDriveways();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
          Text("Does this home have a driveway?",
            style: TextStyle(
              fontSize: 35,
              fontFamily: "NunitoLight",
              color: Colors.white
            )
          ),
          Text("Select any one below",
            style: TextStyle(
              fontSize: 18,
              fontFamily: "NunitoLight",
              color: Colors.white
            )
          ),
          SizedBox(height: 80),
          driveways.isEmpty ? CenteredProgressIndicator() : Wrap(
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
    return driveways.map((item) { return FilterButton(text: item.name, id: item.id, onSelected: onValueChanged, onDeselected: onValueDeselected); }).toList();
  }

  void onValueChanged(int id){
    selectedDrivewaysIds.add(id);
  }

  void onValueDeselected(int id){
    selectedDrivewaysIds.remove(id);
  }

  loadPreviousStep(){
    Navigator.pop(context);
  }

  loadNextStep() {
    if (selectedDrivewaysIds.isNotEmpty && selectedDrivewaysIds.length == 1) {
      requestData["driveways"] = selectedDrivewaysIds;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => QuestionnaireStepMobilityIssuesScreen(requestData: requestData,)),
      );
    } else {
      _scaffoldKey.currentState.showSnackBar(
          SnackBar(
              backgroundColor: Colors.white,
              content: Text('Please select one', style: TextStyle(color: Colors.black54),)
          )
      );
    }
  }

  void fetchDriveways() {
    APIService.fetchDrivewayTypes().then((value) {
      setState(() {
        driveways = value;
      });
    });
  }

}