import 'package:custodia/models/maintenance_item.dart';
import 'package:custodia/services/api.dart';
import 'package:custodia/screens/dashboard/widgets/overlay-done.dart';
import 'package:custodia/utils/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../theme-provider.dart';
import '../../learn-more-about.dart';
import 'overlay-request.dart';
import 'overlay-ignore.dart';

class Slidable3ItemCard extends StatefulWidget {

  Slidable3ItemCard({this.item, this.userId, this.onActionDone, this.key,this.index});

  final MaintenanceItem item;
  final int userId;
  final Function onActionDone;
  final Key key;
  final int index;

  @override
  _Slidable3ItemCardState createState() => _Slidable3ItemCardState();
}

class _Slidable3ItemCardState extends State<Slidable3ItemCard> {
  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: widget.key,
      actionPane: SlidableScrollActionPane(),
      actions: mainActions(),
      secondaryActions: headerCardSlideActions(),
      child: InkWell(
        onTap: () => openLearnMoreScreen(),
        child: Container(
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                    children: <Widget>[
                      Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: ThemeProvider.orange,
                              width: 1.5
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                            child: Text(
                                widget.index.toString(),
                                style: TextStyle(
                                    fontFamily: "NunitoMedium",
                                    color: ThemeProvider.orange,
                                    fontSize: 22
                                )
                            )
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                          "${widget.item.points} POINTS",
                          style: TextStyle(
                              color: ThemeProvider.orange,
                              fontFamily: "NunitoMedium",
                              fontSize: 12
                          )
                      )
                    ]
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(widget.item.title,
                          style: TextStyle(
                              fontSize: 20,
                              color: ThemeProvider.darkGrey,
                              fontFamily: "NunitoMedium"
                          )
                      ),
                      SizedBox(height: 5),
                      Text(widget.item.description,
                          style: TextStyle(
                            fontSize: 13,
                            color: ThemeProvider.darkGrey,
                          )
                      ),
                    ],
                  ),
                ),
              ]
          ),
        ),
      ),
    );
  }

  buildImage(){
    print(widget.item);
    if (widget.item.imageUrl != null && widget.item.imageUrl != "") {
      return Image.network(
        custodiaURL + widget.item.imageUrl,
      );
    } else {
      return Image.asset("assets/images/grass.png", fit: BoxFit.fitWidth);
    }
  }

  List<Widget> mainActions() {
    return <Widget>[
      IconSlideAction(

        caption: 'Close',
        color: ThemeProvider.lightBlue,
        iconWidget: Container(
            width: 60,
            height: 60,

            decoration: BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.block, color: Colors.white, size: 30,)
        ),
        onTap: showIgnoreOverlayDialog,
      )
    ];
  }

  showIgnoreOverlayDialog() {
    Navigator.of(context).push(
        PageRouteBuilder(
            opaque: false,
            pageBuilder: (BuildContext context, _, __) => OverlayIgnore(item: widget.item, onIgnore: widget.onActionDone)
        )
    );
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
    APIService.markDoneMaintenanceItem(widget.item.id, onMarkDoneSuccess, onMarkDoneFailure);
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
        color: ThemeProvider.lightBlue,
        
        iconWidget: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: ThemeProvider.green3,
            shape: BoxShape.circle,
            
          ),
          child: Icon(Icons.check, color: Colors.white, size: 35,)
        ),
        onTap: markAsDone,
      ),
      IconSlideAction(
        caption: 'Request',
        color: ThemeProvider.lightBlue,
        iconWidget: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: ThemeProvider.blue7,
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.room_service, color: Colors.white, size: 30,)
        ),
        onTap: showAutomateOverlayDialog,
      ),
      IconSlideAction(
        caption: 'Learn',
        color: ThemeProvider.lightBlue,
        iconWidget: Container(
          width: 60,
          height: 60,
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
        pageBuilder: (BuildContext context, _, __) => OverlayAutomate(item: widget.item, onAutomate: widget.onActionDone)
      )
    );
  }
}
