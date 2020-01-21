import 'package:custodia/models/mobility_issue.dart';
import 'package:custodia/screens/widgets/centered_progress_indicator.dart';
import 'package:custodia/services/api.dart';
import 'package:flutter/material.dart';

import '../../theme-provider.dart';
import 'package:custodia/screens/widgets/blue-rounded-button.dart';
import 'package:custodia/screens/widgets/filter-button.dart';
import '../../screens/questionnaire/step_summary.dart';
import '../../screens/questionnaire/step_email.dart';
import '../../screens/questionnaire/step_address.dart';
class QuestionnaireStepMobilityIssuesScreen extends StatefulWidget {

  QuestionnaireStepMobilityIssuesScreen({this.requestData});

  final Map<String, dynamic> requestData;

  @override
  _QuestionnaireStepMobilityIssuesScreenState createState() => _QuestionnaireStepMobilityIssuesScreenState();
}

class _QuestionnaireStepMobilityIssuesScreenState extends State<QuestionnaireStepMobilityIssuesScreen> {

  Map<String, dynamic> requestData;
  List<MobilityIssue> mobilityIssues = [];
  List<int> selectedIds = [];
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    requestData = widget.requestData;
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
          Text("Does your "+APIService.translateManagementPlan(requestData["who_needs"])+" have any mobility issues?",
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
    return mobilityIssues.map((item) {
      return FilterButton(
        text: item.name,
        id: item.id,
        onSelected: onValueSelected,
        onDeselected: onValueDeselected,
        selected: selectedIds.contains(item.id) ? true : false,
      );
    }).toList();
  }

  void onValueSelected(int id) {
    selectedIds.clear();
    selectedIds.add(id);
    setState(() {});
  }

  void onValueDeselected(int id){
    selectedIds.remove(id);
    setState(() {});
  }

  loadPreviousStep(){
    Navigator.pop(context);
  }

  loadNextStep() {
    if (selectedIds.isNotEmpty && selectedIds.length == 1) {
      requestData["mobility_issues"] = selectedIds;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => QuestionnaireStepAddressScreen(requestData: requestData)),
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

  void fetchMobilityIssues() {
    APIService.fetchMobilityIssues().then((value) {
      mobilityIssues = value;
      setState(() {});
    });
  }
}