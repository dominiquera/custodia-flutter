import 'package:custodia/models/maintenance_item.dart';
import 'package:custodia/services/api.dart';
import 'package:custodia/screens/widgets/blue-rounded-button.dart';
import 'package:drop_cap_text/drop_cap_text.dart';
import 'package:flutter/material.dart';

import '../../../theme-provider.dart';

class OverlayAutomate extends StatefulWidget {

  OverlayAutomate({this.item, this.userId, this.onAutomate});

  final MaintenanceItem item;
  final int userId;
  final Function onAutomate;

  @override
  _OverlayAutomateState createState() => _OverlayAutomateState();
}

class _OverlayAutomateState extends State<OverlayAutomate> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.all(ThemeProvider.screenPadding),
        decoration: BoxDecoration(
          gradient: ThemeProvider.blueTransparentGradientDiagonal
        ),
        child: body(context)
      ),
    );
  }

  void closeOverlay() {
    Navigator.pop(context);
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
                          child: Icon(Icons.room_service, size: 30, color: Colors.white,),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: ThemeProvider.blue4),
                        )
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
              buildRequestTitle(),
              buildRequestBody(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  BlueRoundedButton(text: "Cancel", onPressed: closeOverlay, padding: 25),
                  BlueRoundedButton(text: "Submit", onPressed: automateItem, padding: 25),
                ]
              )
            ]
        ),
      ),
    );
  }

  Widget buildRequestTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Request Subject", style: TextStyle(fontSize: 18, color: Colors.white),),
        Text("--", style: TextStyle(fontSize: 30, color: Colors.white),),
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
    bool response = await APIService.automateMaintenanceItem(widget.userId, widget.item.id);
    if (response) {
      onSuccess();
    } else {
      print("automate failed");
    }
  }

  onSuccess(){
    closeOverlay();
    widget.onAutomate(widget.item.id);
  }

  onFail(){
    print("failed to automate item");
  }
}
