import 'package:custodia/models/maintenance_item.dart';
import 'package:custodia/services/api.dart';
import 'package:custodia/screens/widgets/blue-rounded-button.dart';
import 'package:drop_cap_text/drop_cap_text.dart';
import 'package:flutter/material.dart';

import '../../../theme-provider.dart';

class OverlayAutomateNoItem extends StatefulWidget {

  OverlayAutomateNoItem();


  @override
  _OverlayAutomateNoItemState createState() => _OverlayAutomateNoItemState();
}

class _OverlayAutomateNoItemState extends State<OverlayAutomateNoItem> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: ThemeProvider.screenPadding),
          decoration: BoxDecoration(
            gradient: ThemeProvider.blueTransparentGradientDiagonal
          ),
          child: body(context)
        ),
      ),
    );
  }

  void closeOverlay() {
    Navigator.pop(context);
  }

  Widget body(BuildContext context) {
    return ListView(
        padding: const EdgeInsets.all(15.0),
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              DropCapText(
                "Great, let's make that request for you.",
                dropCapPosition: DropCapPosition.start,
                dropCapPadding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                style: TextStyle(
                  fontSize: 38,
                  color: Colors.white,
                  fontFamily: "NunitoLight",
                  height: 1.3,
                  shadows: <Shadow>[
                    Shadow(
                      offset: Offset(2.0, 2.0),
                      blurRadius: 5.0,
                      color: ThemeProvider.darkGrey,
                    ),
                  ]
                ),
                dropCap: DropCap(
                  width: 40,
                  height: 45,
                  child: Container(
                    padding: EdgeInsets.all(8),
                    child: Image.asset("assets/images/request.png", width: 10,),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ThemeProvider.blue4),
                  )
                ),
              ),
            ],
          ),
          SizedBox(height: 40),
          buildRequestTitle(),
          SizedBox(height: 30),
          buildRequestBody(),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              BlueRoundedButton(text: "Cancel", onPressed: closeOverlay, padding: 25),
              BlueRoundedButton(text: "Submit", onPressed: automateItem, padding: 25),
            ]
          )
        ]
    );
  }

  Widget buildRequestTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Request Subject", style: TextStyle(fontSize: 18, color: Colors.white),),
        TextField(
          decoration: InputDecoration(
            filled: true,
            hintText: "What's this about?!",
            hintStyle: TextStyle(color: ThemeProvider.grey1),
            fillColor: Colors.white,
            border: InputBorder.none,
          ),
          minLines: 1,
          maxLines: 1,
        ),
      ],
    );
  }

  Widget buildRequestBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Request Details", style: TextStyle(fontSize: 18, color: Colors.white),),
        SizedBox(height: 10,),
        TextField(
          decoration: InputDecoration(
            filled: true,
            hintText: "Add notes if you got them!",
            hintStyle: TextStyle(color: ThemeProvider.grey1),
            fillColor: Colors.white,
            border: InputBorder.none,
          ),
          minLines: 6,
          maxLines: 10,
        ),
      ],
    );
  }

  Widget closeIconButton() {
    return Positioned(
      child: IconButton(
        icon: Icon(Icons.clear, color: Colors.white,),
        onPressed: () => closeOverlay(),
      ),
      top: 0,
      right: 0
    );
  }

  void automateItem() async {
    closeOverlay();
//    bool response = await APIService.automateMaintenanceItem(widget.item.id);
//    if (response) {
//      onSuccess();
//    } else {
//      print("automate failed");
//    }
  }

  onSuccess(){
    closeOverlay();
//    widget.onAutomate(widget.item.id);
  }

  onFail(){
    print("failed to automate item");
  }
}
