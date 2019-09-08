import 'package:flutter/material.dart';

import '../theme-provider.dart';
import 'blue-rounded-button.dart';

class OverlayDialog extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0),
      body: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: ThemeProvider.blueTransparentGradientDiagonal
        ),
        child: SafeArea(
          child: Stack(
            children: <Widget>[
              closeIconButton(context),
              body(context)
            ],
          ),
        ),
      ),
    );
  }

  void closeOverlay(BuildContext context) {
    Navigator.pop(context);
  }

  Widget closeIconButton(BuildContext context) {
    return Positioned(
      child: IconButton(
        icon: Icon(Icons.clear, color: Colors.white,),
        onPressed: () => closeOverlay(context),
      ),
      top: 0,
      right: 0
    );
  }
//
//  Widget body(BuildContext context) {
//    return SizedBox.expand(
//      child: Column(
//        mainAxisAlignment: MainAxisAlignment.center,
//        children: <Widget>[
//          BlueRoundedButton(text: "Ignore for now", onPressed: (){},padding: 30),
//          SizedBox(height: 50),
//          BlueRoundedButton(text: "Ignore forever", onPressed: (){},padding: 30),
//          SizedBox(height: 50),
//          FlatButton(
//            onPressed: () => closeOverlay(context),
//            child: Text(
//              "cancel",
//              style: TextStyle(
//                color: Colors.white,
//                fontSize: 22
//              )
//            ),
//          )
//        ]
//      ),
//    );
//  }

  Widget body(BuildContext context) {
    return SizedBox.expand(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Well done John! You have increased the home score by 10 points",
            style: TextStyle(fontSize: 28, color: Colors.white),
          ),
Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: <Widget>[
  BlueRoundedButton(text: "Undo", onPressed: (){},padding: 30),
  BlueRoundedButton(text: "Close", onPressed: (){},padding: 30),

],)
//          BlueRoundedButton(text: "Ignore for now", onPressed: (){},padding: 30),
//          SizedBox(height: 50),
//          BlueRoundedButton(text: "Ignore forever", onPressed: (){},padding: 30),
//          SizedBox(height: 50),
//          FlatButton(
//            onPressed: () => closeOverlay(context),
//            child: Text(
//              "cancel",
//              style: TextStyle(
//                color: Colors.white,
//                fontSize: 22
//              )
//            ),
//          )
        ]
      ),
    );
  }
}
//
//class OverlayDialog extends ModalRoute<void> {
//  @override
//  Duration get transitionDuration => Duration(milliseconds: 500);
//
//  @override
//  bool get opaque => false;
//
//  @override
//  bool get barrierDismissible => false;
//
//  @override
//  Color get barrierColor => Colors.black.withOpacity(0.5);
//
//  @override
//  String get barrierLabel => null;
//
//  @override
//  bool get maintainState => true;
//
//  @override
//  Widget buildPage(
//      BuildContext context,
//      Animation<double> animation,
//      Animation<double> secondaryAnimation,
//      ) {
//    // This makes sure that text and other content follows the material style
//    return Material(
//      type: MaterialType.transparency,
//      // make sure that the overlay content is not cut off
//      child: SafeArea(
//        child: _buildOverlayContent(context),
//      ),
//    );
//  }
//
//  Widget _buildOverlayContent(BuildContext context) {
//    return Center(
//      child: Column(
//        mainAxisSize: MainAxisSize.min,
//        children: <Widget>[
////          Text(
////            'This is a nice overlay',
////            style: TextStyle(color: Colors.white, fontSize: 30.0),
////          ),
//          BlueRoundedButton(text: "Hello", onPressed: (){},padding: 70)
//        ],
//      ),
//    );
//  }
//
//  @override
//  Widget buildTransitions(
//      BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
//    // You can add your own animations for the overlay content
//    return FadeTransition(
//      opacity: animation,
//      child: ScaleTransition(
//        scale: animation,
//        child: child,
//      ),
//    );
//  }
//}