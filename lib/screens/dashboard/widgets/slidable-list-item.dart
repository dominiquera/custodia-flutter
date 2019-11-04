import 'package:custodia/models/maintenance_item.dart';
import 'package:custodia/services/api.dart';
import 'package:custodia/widgets/done-overlay-dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../theme-provider.dart';
import '../../learn-more-about.dart';
import '../sections/overlay-ignore.dart';

class SlidableListItem extends StatefulWidget {

  SlidableListItem({this.item, this.color, this.userId, this.onIgnore, this.onDone, this.key});

  final MaintenanceItem item;
  final Color color;
  final int userId;
  final Function onIgnore;
  final Function onDone;
  final Key key;

  @override
  _SlidableListItemState createState() => _SlidableListItemState();
}

class _SlidableListItemState extends State<SlidableListItem> {
  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: widget.key,
      actionPane: SlidableScrollActionPane(),
      actions: mainActions(context),
      secondaryActions: secondaryActions(context),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: widget.color,
                borderRadius: BorderRadius.circular(3)
              ),
              width: 90,
              height: 90,
              child: Text(
                "${widget.item.points} points",
                style: TextStyle(
                  color: Colors.white,
                  shadows: <Shadow>[
                    Shadow(
                      offset: Offset(1.0, 1.0),
                      blurRadius: 1.0,
                      color: ThemeProvider.grey1,
                    ),
                  ],
                )
              ),
            ),
            SizedBox(width: 25),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.item.title.toUpperCase(),
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: "RobotoMedium"
                    )
                  ),
                  Text(
                    widget.item.summary,
                    style: TextStyle(
                      fontSize: 20,
                    )
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  markAsDone(){
    APIService.markDoneMaintenanceItem(widget.userId, widget.item.id, onMarkDoneSuccess, onMarkDoneFailure);
  }

  void onMarkDoneSuccess(String body){
    widget.onDone(widget.item.id);
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

  showIgnoreOverlayDialog() {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) => OverlayIgnore(userId: widget.userId, item: widget.item, onIgnore: widget.onIgnore)
      )
    );
  }

  List<Widget> mainActions(BuildContext context) {
    return <Widget>[
      IconSlideAction(
        caption: 'Ignore',
        color: ThemeProvider.blue8,
        iconWidget: Container(
          width: 40,
          height: 40,
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

  List<Widget> secondaryActions(BuildContext context) {
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
        onTap: () {},
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
}
