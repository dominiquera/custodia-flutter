import 'package:custodia/models/maintenance_item.dart';
import 'package:custodia/services/api.dart';
import 'package:custodia/screens/widgets/blue-rounded-button.dart';
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
      backgroundColor: Colors.white.withOpacity(0),
      body: Container(
        padding: EdgeInsets.all(ThemeProvider.screenPadding),
        decoration: BoxDecoration(
          gradient: ThemeProvider.blueTransparentGradientDiagonal
        ),
        child: SafeArea(
          child: Stack(
            children: <Widget>[
              closeIconButton(),
              body()
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
        onPressed: () => closeOverlay(),
      ),
      top: 0,
      right: 0
    );
  }

  Widget body(){
    return SizedBox.expand(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          BlueRoundedButton(text: "Automate", onPressed: automateItem, padding: 25),
          SizedBox(height: 50),
          FlatButton(
            child: Text("Cancel", style: TextStyle(color: Colors.white, fontSize: 22)),
            onPressed: closeOverlay,
          )
        ]
      ),
    );
  }

  void automateItem() async {
    bool response = await APIService.automateMaintenanceItem(widget.userId, widget.item.id);
    if (response) {
      onSuccess();
      print(">>>automate");
    } else {
      print(">>>no automate");

    }
  }

  onSuccess(){
    closeOverlay();
//    widget.onAutomate(widget.item.id);
  }

  onFail(){
    print("failed to automate item");
  }
}
