import 'package:custodia/models/maintenance_item.dart';
import 'package:custodia/services/api.dart';
import 'package:custodia/widgets/blue-rounded-button.dart';
import 'package:flutter/material.dart';

import '../../../theme-provider.dart';

class OverlayIgnore extends StatefulWidget {

  OverlayIgnore({this.item});

  final MaintenanceItem item;

  @override
  _OverlayIgnoreState createState() => _OverlayIgnoreState();
}

class _OverlayIgnoreState extends State<OverlayIgnore> {

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
          BlueRoundedButton(text: "Ignore for now", onPressed: (){}, padding: 25),
          SizedBox(height: 50),
          BlueRoundedButton(text: "Ignore forever", onPressed: ignoreItem, padding: 25),
          SizedBox(height: 50),
          FlatButton(
            child: Text("Cancel", style: TextStyle(color: Colors.white, fontSize: 22)),
            onPressed: closeOverlay,
          )
        ]
      ),
    );
  }

  void ignoreItem(){
    print(widget.item.id);
    APIService.ignoreMaintenanceItem(widget.item.id, onSuccess, onFail);
  }

  onSuccess(){
    closeOverlay();
  }

  onFail(){

  }
}
