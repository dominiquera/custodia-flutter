import 'package:custodia/models/mobility_issue.dart';
import 'package:custodia/screens/widgets/centered_progress_indicator.dart';
import 'package:custodia/services/api.dart';
import 'package:flutter/material.dart';

import '../../theme-provider.dart';
import 'package:custodia/widgets/blue-rounded-button.dart';
import 'package:custodia/widgets/filter-button.dart';
import '../../screens/questionnaire/step_summary.dart';

class QuestionnaireStepMobilityIssuesScreen extends StatefulWidget {

  QuestionnaireStepMobilityIssuesScreen({this.requestData});

  final Map<String, dynamic> requestData;

  @override
  _QuestionnaireStepMobilityIssuesScreenState createState() => _QuestionnaireStepMobilityIssuesScreenState();
}

class _QuestionnaireStepMobilityIssuesScreenState extends State<QuestionnaireStepMobilityIssuesScreen> {

  Map<String, dynamic> requestData;
  List<MobilityIssue> mobilityIssues = [];
  List<int> selectedMobilityIssues = [];
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    requestData = widget.requestData;
    print(">>>>>>>>>>>>>>>>>>");
    print(requestData);
    fetchMobilityIssues();
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
          mobilityIssues.isEmpty ? CenteredProgressIndicator() : Wrap(
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
    return mobilityIssues.map((item) { return FilterButton(text: item.name, id: item.id, onPressed: onValueChanged,); }).toList();
  }

  void onValueChanged(int id) {
    selectedMobilityIssues.add(id);
  }

  loadPreviousStep(){
    Navigator.pop(context);
  }

  loadNextStep() {
    if (selectedMobilityIssues.isNotEmpty) {
      requestData["mobility_issues"] = selectedMobilityIssues;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => QuestionnaireStepSummaryScreen(requestData: requestData)),
      );
    } else {
      final snackBar = SnackBar(content: Text('Please select one'));
      _scaffoldKey.currentState.showSnackBar(snackBar);
    }
  }

  void fetchMobilityIssues() {
    APIService.fetchMobilityIssues().then((value) {
      mobilityIssues = value;
      setState(() {});
    });
  }
}