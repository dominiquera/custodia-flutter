import 'package:custodia/models/home_type.dart';
import 'package:custodia/screens/questionnaire/step_home_features.dart';
import 'package:custodia/screens/widgets/centered_progress_indicator.dart';
import 'package:custodia/services/api.dart';
import 'package:flutter/material.dart';

import '../../theme-provider.dart';
import 'package:custodia/screens/widgets/blue-rounded-button.dart';
import 'package:custodia/screens/widgets/filter-button.dart';

class QuestionnaireStepHomeTypesScreen extends StatefulWidget {

  QuestionnaireStepHomeTypesScreen({this.requestData});

  final Map<String, dynamic> requestData;

  @override
  _QuestionnaireStepHomeTypesScreenState createState() => _QuestionnaireStepHomeTypesScreenState();
}

class _QuestionnaireStepHomeTypesScreenState extends State<QuestionnaireStepHomeTypesScreen> {

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  Map<String, dynamic> requestData;
  List<HomeType> homeTypes = [];
  List<int> selectedHomeType = [];

  @override
  void initState() {
    requestData = widget.requestData;
    fetchHomeTypes();
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
          homeTypes.isEmpty ? CenteredProgressIndicator() : Wrap(
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
    return homeTypes.map((item) { return FilterButton(text: item.name, id: item.id, onSelected: onValueSelected, onDeselected: onValueDeselected,); }).toList();
  }

  void onValueSelected(int id){
    selectedHomeType.add(id);
  }

  void onValueDeselected(int id){
    selectedHomeType.remove(id);
  }

  loadPreviousStep(){
    Navigator.pop(context);
  }

  loadNextStep() {
    if (selectedHomeType != null && selectedHomeType.length == 1){
      requestData["home_type"] = selectedHomeType.first.toString();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => QuestionnaireStepHomeFeaturesScreen(requestData: requestData)),
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

  void fetchHomeTypes() {
    APIService.fetchHomeTypes().then((value) {
      homeTypes = value;
      setState(() {});
    });
  }
}
