import 'package:custodia/screens/questionnaire/step_email.dart';
import 'package:flutter/material.dart';

import '../../theme-provider.dart';
import 'package:custodia/screens/widgets/blue-rounded-button.dart';

class QuestionnaireStepNameScreen extends StatefulWidget {

  QuestionnaireStepNameScreen({this.requestData});

  final Map<String, dynamic> requestData;

  @override
  _QuestionnaireStepNameScreenState createState() => _QuestionnaireStepNameScreenState();
}

class _QuestionnaireStepNameScreenState extends State<QuestionnaireStepNameScreen> {

  Map<String, dynamic> requestData;
  TextEditingController textController = TextEditingController();
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
//        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text("What's your name",
            style: TextStyle(
              fontSize: 35,
              fontFamily: "RobotoLight",
              color: Colors.white
            )
          ),
          SizedBox(height: 100),
          buildForm(),
          SizedBox(height: 70),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
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
            return 'Please enter your name';
          }
          return null;
        },
        controller: textController,
        style: TextStyle(
          fontSize: 30,
          color: Colors.white,
          decoration: TextDecoration.none,
        ),
        cursorColor: Colors.white,
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: ThemeProvider.blue1)),
          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: ThemeProvider.blue1)),
          errorStyle: TextStyle(color: Colors.white),
        ),
      )
    );
  }

  loadNextStep() {
    if (_formKey.currentState.validate()) {
      requestData["name"] = textController.text;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => QuestionnaireStepEmailScreen(requestData: requestData)),
      );
    }
  }
}
