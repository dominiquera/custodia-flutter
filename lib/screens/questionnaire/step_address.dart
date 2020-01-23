import 'package:flutter/material.dart';

import '../../theme-provider.dart';
import 'package:custodia/screens/widgets/blue-rounded-button.dart';
import '../../screens/questionnaire/step_who_needs.dart';
import '../../screens/questionnaire/step_summary.dart';
class QuestionnaireStepAddressScreen extends StatefulWidget {

  QuestionnaireStepAddressScreen({this.requestData});

  final Map<String, dynamic> requestData;

  @override
  _QuestionnaireStepAddressScreenState createState() => _QuestionnaireStepAddressScreenState();
}

class _QuestionnaireStepAddressScreenState extends State<QuestionnaireStepAddressScreen> {

  Map<String, dynamic> requestData;
  TextEditingController addressTextController = TextEditingController();
  TextEditingController zipTextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    requestData = widget.requestData;
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
          Text("What's your address",
            style: TextStyle(
              fontSize: 35,
              fontFamily: "NunitoLight",
              color: Colors.white
            )
          ),
          SizedBox(height: 100),
          buildForm(),
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

  Widget buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            validator: (value) {
              if (value.trim().isEmpty) {
                return 'What\'s your address';
              }
              return null;
            },
            controller: addressTextController,
            style: TextStyle(
              fontSize: 20, color: Colors.white,
            ),
            decoration: InputDecoration(
              labelText: "Your city, street",
              labelStyle: TextStyle(color: Colors.white),
              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: ThemeProvider.blue1)),
              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: ThemeProvider.blue1)),
              errorStyle: TextStyle(color: Colors.white),
            ),
          ),
          TextFormField(
            validator: (value) {
              if (value.trim().isEmpty) {
                return 'Please enter your zip code';
              }
              // Removed /i at the end
              // Removed / in front - Thanks to Günter for warning
              RegExp regExp = new RegExp(
                r"^(?!.*[DFIOQU])[A-VXY][0-9][A-Z] ?[0-9][A-Z][0-9]$",
                caseSensitive: false,
                multiLine: false,
              );
              if(!regExp.hasMatch(value.trim())) {
                return 'Please enter valid zip code';
              }

              return null;
            },
            controller: zipTextController,
            style: TextStyle(
              fontSize: 20, color: Colors.white,
            ),
            decoration: InputDecoration(
              labelText: "Your zip/postal",
              labelStyle: TextStyle(color: Colors.white),
              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: ThemeProvider.blue1)),
              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: ThemeProvider.blue1)),
              errorStyle: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }

  loadPreviousStep(){
    Navigator.pop(context);
  }

  loadNextStep() {

    if (_formKey.currentState.validate()) {
      requestData["address"] = addressTextController.text;
      requestData["zip_code"] = zipTextController.text;

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => QuestionnaireStepSummaryScreen(requestData: requestData)),
      );
    }
  }
}
