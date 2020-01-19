import 'package:custodia/models/home_feature.dart';
import 'package:custodia/screens/widgets/centered_progress_indicator.dart';
import 'package:custodia/services/api.dart';
import 'package:flutter/material.dart';

import '../../theme-provider.dart';
import 'package:custodia/screens/widgets/blue-rounded-button.dart';
import 'package:custodia/screens/widgets/filter-button.dart';
import '../../screens/questionnaire/step_outdoor_space.dart';

class QuestionnaireStepHomeFeaturesScreen extends StatefulWidget {
  
  QuestionnaireStepHomeFeaturesScreen({this.requestData});

  final Map<String, dynamic> requestData;
  
  @override
  _QuestionnaireStepHomeFeaturesScreenState createState() => _QuestionnaireStepHomeFeaturesScreenState();
}

class _QuestionnaireStepHomeFeaturesScreenState extends State<QuestionnaireStepHomeFeaturesScreen> {

  Map<String, dynamic> requestData;

  List<HomeFeature> homeFeatures = [];
  List<int> homeFeaturesSelectedIds = [];
  final _scaffoldKey = GlobalKey<ScaffoldState>();

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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("What features does this home have?",
            style: TextStyle(
                fontSize: 35,
                fontFamily: "NunitoLight",
                color: Colors.white
            )
          ),
          Text("Select one or several",
            style: TextStyle(
                fontSize: 18,
                fontFamily: "NunitoLight",
                color: Colors.white
            )
          ),
          SizedBox(height: 80),
          homeFeatures.isEmpty ? CenteredProgressIndicator() : Wrap(
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
    return homeFeatures.map((item) { return FilterButton(text: item.name, id: item.id, onSelected: onValueSelected, onDeselected: onValueDeselected,); }).toList();
  }

  void onValueSelected(int id){
    homeFeaturesSelectedIds.add(id);
  }

  void onValueDeselected(int id){
    homeFeaturesSelectedIds.remove(id);
  }

  loadPreviousStep(){
    Navigator.pop(context);
  }

  loadNextStep() {
    if( homeFeaturesSelectedIds.isNotEmpty) {
      requestData["home_features"] = homeFeaturesSelectedIds;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => QuestionnaireStepOutdoorSpaceScreen(requestData: requestData)),
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
    APIService.fetchHomeFeatures().then((value) {
      homeFeatures = value;
      setState(() {});
    });
  }
}
