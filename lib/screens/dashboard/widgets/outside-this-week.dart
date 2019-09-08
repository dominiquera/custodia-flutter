import 'package:custodia/widgets/overlay-dialog.dart';
import 'package:flutter/material.dart';

import '../../../theme-provider.dart';

import 'package:flutter_slidable/flutter_slidable.dart';

import 'list-item.dart';

class OutsideThisWeek extends StatefulWidget {
  @override
  _OutsideThisWeekState createState() => _OutsideThisWeekState();
}

class _OutsideThisWeekState extends State<OutsideThisWeek> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      color: ThemeProvider.lightBlue,
      child: Column(
        children: <Widget>[
          title(),
          headerCard(),
          ListItem(
            title: "Hedge trimming",
            description: "Trim the hedges to keep them looking nice",
            points: 10,
            color: ThemeProvider.green3),
          ListItem(
            title: "Hedge trimming",
            description: "Trim the hedges to keep them looking nice",
            points: 10,
            color: ThemeProvider.blue2),
          footer()

        ],
      ),
    );
  }

  Widget headerCard() {
    return Slidable(
      actionPane: SlidableScrollActionPane(),
      actions: <Widget>[
        IconSlideAction(
          caption: 'Done',
          color: ThemeProvider.blue8,
//          icon: Icons.block,
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
//          icon: Icons.block,
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
//          icon: Icons.block,
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
      ],
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
            Image.asset("assets/images/grass.png", fit: BoxFit.fitWidth,),
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
//    Navigator.of(context).push(OverlayDialog());
//    Navigator.push(
//      context,
//      MaterialPageRoute(builder: (context) => OverlayDialog()),
//    );
  }

  Widget title() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Outside This Week",
            style: TextStyle(
              color: ThemeProvider.green3,
              fontFamily: "RobotoBlack",
              fontSize: 28
            )
          ),
          Text(
            "Suggested for outsided the home. Slide the card to customize",
            style: TextStyle(color: ThemeProvider.grey2),
          ),
        ],
      ),
    );
  }

  Widget footer() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Align(
        alignment: Alignment.centerRight,
        child: RichText(
          text: TextSpan(
            style: TextStyle(fontSize: 16),
            children: <TextSpan>[
              TextSpan(text: 'MORE THIS MONTH FOR ', style: TextStyle(color: ThemeProvider.darkGrey)),

              TextSpan(text: 'OUTSIDE >', style: TextStyle(color: ThemeProvider.green2)),
            ],
          ),
        ),
      ),
    );
  }
}
