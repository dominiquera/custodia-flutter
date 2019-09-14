import 'package:flutter/material.dart';

import '../constants.dart';
import '../theme-provider.dart';
import 'blue-rounded-button.dart';
import 'filter-button.dart';

class OverlayDialog extends StatefulWidget {
  @override
  _OverlayDialogState createState() => _OverlayDialogState();
}

class _OverlayDialogState extends State<OverlayDialog> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0),
      body: Container(
        padding: EdgeInsets.all(Constants.screenPadding),
        decoration: BoxDecoration(
          gradient: ThemeProvider.blueTransparentGradientDiagonal
        ),
        child: SafeArea(
          child: Stack(
            children: <Widget>[
              closeIconButton(),
              body(context)
            ],
          ),
        ),
      ),
    );
  }

  void closeOverlay() {
    Navigator.pop(context);
  }

  Widget closeIconButton() {
    return Positioned(
      child: IconButton(
        icon: Icon(Icons.clear, color: Colors.white,),
        onPressed: closeOverlay,
      ),
      top: 0,
      right: 0
    );
  }

  Widget body(BuildContext context) {
    return SizedBox.expand(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    "Well done John! You have increased the home score by 10 points!",
                    style: TextStyle(
                      fontSize: 38,
                      color: Colors.white,
                      fontFamily: "RobotoLight",
                      shadows: <Shadow>[
                        Shadow(
                          offset: Offset(2.0, 2.0),
                          blurRadius: 5.0,
                          color: ThemeProvider.darkGrey,
                        ),
                      ]
                    ),
                  ),
//                  SizedBox(height: 20),
//                  Text(
//                    "We choose the best day to provide your service. We hope it works for you.",
//                    style: TextStyle(
//                        fontSize: 18,
//                        color: Colors.white,
//                        fontFamily: "RobotoLight"
//                    ),
//                  ),
                  SizedBox(height: 20),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  BlueRoundedButton(text: "Undo", onPressed: (){},padding: 25),
                  BlueRoundedButton(text: "Close", onPressed: closeOverlay, padding: 25),
                ]
              )
            ]
        ),
      ),
    );
  }
//
//  Widget body(BuildContext context) {
//    return SizedBox.expand(
//      child: Padding(
//        padding: const EdgeInsets.all(15.0),
//        child: Column(
//            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//            crossAxisAlignment: CrossAxisAlignment.stretch,
//            children: <Widget>[
//              Column(
//                children: <Widget>[
//                  Text(
//                    "Please enter your credit card information below",
//                    style: TextStyle(
//                        fontSize: 38,
//                        color: Colors.white,
//                        fontFamily: "RobotoLight",
//                        shadows: <Shadow>[
//                          Shadow(
//                            offset: Offset(2.0, 2.0),
//                            blurRadius: 5.0,
//                            color: ThemeProvider.darkGrey,
//                          ),
//                        ]
//                    ),
//                  ),
//                  SizedBox(height: 20),
//                  Text(
//                    "Our security system will bill your card after your service is complete",
//                    style: TextStyle(
//                      fontSize: 18,
//                      color: Colors.white,
//                      fontFamily: "RobotoLight"
//                    ),
//                  ),
//                  SizedBox(height: 20),
//                  form()
//                ],
//              ),
//
//              Row(
//                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                  children: <Widget>[
//                    BlueRoundedButton(text: "Cancel", onPressed: (){},padding: 25),
//                    BlueRoundedButton(text: "Purchase", onPressed: (){},padding: 25),
//                  ]
//              )
//            ]
//        ),
//      ),
//    );
//  }

//  form() {
//    return                   Form(
//      key: _formKey,
//      child: Column(
//        crossAxisAlignment: CrossAxisAlignment.start,
//        children: <Widget>[
//          textField("CC"),
//          SizedBox(height: 20),
//          Row(
//            mainAxisSize: MainAxisSize.max,
//            children: <Widget>[
//              Expanded(
//                child: textField("Exp/Date"),
//              ),
//              SizedBox(width: 10),
//              Expanded(
//                child: textField("CVV"),
//              ),
//              SizedBox(width: 10),
//              Expanded(
//                child: textField("Zip/Postal"),
//              ),
//            ],
//          ),
//          Row(
//            children: <Widget>[
//              Checkbox(
//                value: true,
//                activeColor: Colors.white,
//                checkColor: ThemeProvider.blue7,
//                onChanged: (value){},),
//              GestureDetector(
//                child: Text(
//                  "Save this card for future purposes",
//                  style: TextStyle(color: Colors.white, fontSize: 16)
//                )
//              )
//            ],
//          )
//        ],
//      )
//    );
//  }
//
//  textField(String hint) {
//    return TextFormField(
//      decoration: InputDecoration(
//          contentPadding: EdgeInsets.all(10),
////                            border: OutlineInputBorder(
////                              borderRadius: const BorderRadius.all(
////                                const Radius.circular(5.0),
////                              ),
////                            ),
//        enabledBorder: OutlineInputBorder(
//          borderSide: BorderSide(
//            color: Colors.white
//          ),
//          borderRadius: const BorderRadius.all(
//            const Radius.circular(5.0),
//          ),
//        ),
//        focusedBorder: OutlineInputBorder(
//          borderSide: BorderSide(
//            color: Colors.white
//          ),
//          borderRadius: const BorderRadius.all(
//            const Radius.circular(5.0),
//          ),
//        ),
//        hintText: hint,
//        fillColor: Colors.white,
//        focusColor: Colors.white,
//        enabled: true,
//        filled: true
//      ),
//      validator: (value) {
//        if (value.isEmpty) {
//          return 'Please enter some text';
//        }
//        return null;
//      },
//    );
//  }
}