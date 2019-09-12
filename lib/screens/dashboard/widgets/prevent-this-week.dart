
import 'package:custodia/screens/dashboard/widgets/slidable-card.dart';
import 'package:custodia/widgets/overlay-dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../theme-provider.dart';
import 'block-footer.dart';
import 'block-header.dart';
import 'slidable-list-item.dart';

class PreventThisWeek extends StatefulWidget {
  @override
  _PreventThisWeekState createState() => _PreventThisWeekState();
}

class _PreventThisWeekState extends State<PreventThisWeek> {

  Color accentColor = ThemeProvider.blue7;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      color: Colors.white,
      child: Column(
        children: <Widget>[
          BlockHeader(
            title: "Prevent This Week",
            description: "Suggested for inside the home. Slide the card to customize",
            colorAccent: accentColor
          ),
          SlidableCard(),
          SizedBox(height: 20),
          SlidableListItem(
            title: "Hedge trimming",
            description: "Trim the hedges to keep them looking nice",
            points: 10,
            color: ThemeProvider.lightViolet),
          SlidableListItem(
            title: "Hedge trimming",
            description: "Trim the hedges to keep them looking nice",
            points: 10,
            color: ThemeProvider.lightViolet),
          BlockFooter(text: "PREVENT", accentColor: accentColor)
        ],
      ),
    );
  }
}
