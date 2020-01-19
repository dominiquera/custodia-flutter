import 'package:custodia/models/maintenance_item.dart';
import 'package:custodia/services/api.dart';
import 'package:custodia/screens/dashboard/widgets/overlay-done.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../theme-provider.dart';
import '../../learn-more-about.dart';
import 'overlay-automate.dart';

class SlidableCard extends StatefulWidget {

  SlidableCard({this.item, this.color, this.userId, this.onActionDone, this.key});

  final MaintenanceItem item;
  final Color color;
  final int userId;
  final Function onActionDone;
  final Key key;

  @override
  _SlidableCardState createState() => _SlidableCardState();
}

class _SlidableCardState extends State<SlidableCard> {
  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableScrollActionPane(),
      secondaryActions: headerCardSlideActions(),
      child: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: ThemeProvider.lightGrey2,
          boxShadow: [
            const BoxShadow(
              color: ThemeProvider.grey1,
              offset: const Offset(0, 5.0),
              blurRadius: 3
            )
          ]
        ),
        child: Column(
            children: <Widget>[
              Stack(children: <Widget>[
                buildImage(),
                Positioned(
                  bottom: 10,
                  left: 10,
                  child: Text("${widget.item.points} POINTS",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      shadows: <Shadow>[
                        Shadow(
                          offset: Offset(1.0, 1.0),
                          blurRadius: 1.0,
                          color: ThemeProvider.darkGrey,
                        ),
                      ]
                    )
                  ),
                ),
              ]
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
//                    Text(
//                      "OUTSIDE",
//                      style: TextStyle(
//                        color: ThemeProvider.green1,
//                        fontSize: 20,
//                        fontFamily: "NunitoMedium"
//                      )
//                    ),
                    Text(
                      widget.item.title,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: "NunitoMedium",
                        color: ThemeProvider.grey2
                      )
                    ),
                    SizedBox(height: 10),
                    Text(
                      widget.item.description,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 13,
                        color: ThemeProvider.darkGrey
                      )
                    )
                  ],
                ),
              ),
            ]
        ),
      ),

    );
  }

  buildImage(){
    print(widget.item);
    if (widget.item.imageUrl != null && widget.item.imageUrl != "") {
      return Image.network(
        "http://35.183.234.234" + widget.item.imageUrl,
      );
    } else {
      return Image.asset("assets/images/grass.png", fit: BoxFit.fitWidth);
    }
  }

  showOverlayDialog() {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) => DoneOverlayDialog(item: widget.item,)
      )
    );
  }

  markAsDone(){
    APIService.markDoneMaintenanceItem(widget.userId, widget.item.id, onMarkDoneSuccess, onMarkDoneFailure);
  }

  void onMarkDoneSuccess(String body){
    widget.onActionDone(widget.item.id);
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) => DoneOverlayDialog(item: widget.item)
      )
    );
  }

  void onMarkDoneFailure() {
    print(">>>onMarkDoneFailure");
  }

  List<Widget> headerCardSlideActions() {
    return <Widget>[
      IconSlideAction(
        caption: 'Done',
        color: ThemeProvider.blue8,
        iconWidget: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: ThemeProvider.green3,
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.check, color: Colors.white, size: 30,)
        ),
        onTap: markAsDone,
      ),
      IconSlideAction(
        caption: 'Automate',
        color: ThemeProvider.blue8,
        iconWidget: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: ThemeProvider.blue7,
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.cached, color: Colors.white, size: 30,)
        ),
        onTap: showAutomateOverlayDialog,
      ),
      IconSlideAction(
        caption: 'Learn',
        color: ThemeProvider.blue8,
        iconWidget: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: ThemeProvider.lightBrown,
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.school, color: Colors.white, size: 30,)
        ),
        onTap: openLearnMoreScreen,
      )
    ];
  }

  openLearnMoreScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LearnMoreAboutPage(item: widget.item)),
    );
  }

  void showAutomateOverlayDialog() {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) => OverlayAutomate(userId: widget.userId, item: widget.item, onAutomate: widget.onActionDone)
      )
    );
  }
}
