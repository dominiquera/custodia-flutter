import 'package:custodia/widgets/overlay-dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../theme-provider.dart';
import 'block-footer.dart';
import 'block-header.dart';
import 'list-item.dart';

class CleanThisWeek extends StatefulWidget {
  @override
  _CleanThisWeekState createState() => _CleanThisWeekState();
}

class _CleanThisWeekState extends State<CleanThisWeek> {

  Color accentColor = ThemeProvider.lightBrown;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      color: ThemeProvider.lightBlue,
      child: Column(
        children: <Widget>[
          BlockHeader(
            title: "Clean This Week",
            description: "Suggested for outsided the home. Slide the card to customize",
            colorAccent: accentColor
          ),
          headerCard(),
          SizedBox(height: 20),
          ListItem(
            title: "Hedge trimming",
            description: "Trim the hedges to keep them looking nice",
            points: 10,
            color: accentColor),
          ListItem(
            title: "Hedge trimming",
            description: "Trim the hedges to keep them looking nice",
            points: 10,
            color: accentColor),
          BlockFooter(text: "CLEAN", accentColor: accentColor)
        ],
      ),
    );
  }

  Widget headerCard() {
    return Slidable(
      actionPane: SlidableScrollActionPane(),
      actions: headerCardSlideActions(),
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
              Image.asset("assets/images/grass.png", fit: BoxFit.fitWidth),
              Positioned(
                bottom: 10,
                left: 10,
                child: Text("10 POINTS",
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
                children: <Widget>[
                  Text(
                    "OUTSIDE",
                    style: TextStyle(
                        color: ThemeProvider.green1,
                        fontSize: 20,
                        fontFamily: "RobotoMedium"
                    )
                  ),
                  Text(
                    "Cut the grass this week",
                    style: TextStyle(
                        fontSize: 28,
                        fontFamily: "RobotoMedium",
                        color: ThemeProvider.grey2
                    )
                  ),
                  SizedBox(height: 10),
                  Text(
                    "It rained quite a bit last week, you may need to cut the grass and edge the property",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
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

  showOverlayDialog() {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: true,
        pageBuilder: (BuildContext context, _, __) => OverlayDialog()
      )
    );
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
        onTap: showOverlayDialog,
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
        onTap: showOverlayDialog,
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
        onTap: showOverlayDialog,
      )
    ];
  }
}
