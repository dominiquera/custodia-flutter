import 'package:custodia/screens/questionnaire/step_address.dart';
import 'package:custodia/screens/questionnaire/step_summary.dart';
import 'package:flutter/material.dart';

import '../../theme-provider.dart';
import 'package:custodia/screens/widgets/blue-rounded-button.dart';
import '../../screens/questionnaire/step_who_needs.dart';

class QuestionnaireStepEmailScreen extends StatefulWidget {

  QuestionnaireStepEmailScreen({this.requestData});

  final Map<String, dynamic> requestData;

  @override
  _QuestionnaireStepEmailScreenState createState() => _QuestionnaireStepEmailScreenState();
}

class _QuestionnaireStepEmailScreenState extends State<QuestionnaireStepEmailScreen> {

  Map<String, dynamic> requestData;
  TextEditingController textController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    requestData = widget.requestData;
    textController = TextEditingController(text: widget.requestData["email"]);
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
          Text("Enter your email address?",
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
      child: TextFormField(
        validator: (value) {
          if (value.trim().isEmpty) {
            return 'Please enter your email';
          }
          if (!RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
            return 'Please enter valid email';
          }
          return null;
        },
        controller: textController,
        style: TextStyle(
          fontSize: 20, color: Colors.white,
        ),
        autofocus: true,
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: ThemeProvider.blue1)),
          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: ThemeProvider.blue1)),
          errorStyle: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  loadPreviousStep(){
    Navigator.pop(context);
  }

  loadNextStep() {
    if (_formKey.currentState.validate()) {
      requestData["email"] = textController.text;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => QuestionnaireStepWhoNeedsScreen(requestData: requestData)),
      );
    }
  }
}
