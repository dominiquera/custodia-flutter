import 'package:custodia/screens/dashboard/widgets/slidable-card.dart';
import 'package:custodia/widgets/overlay-dialog.dart';
import 'package:flutter/material.dart';

import '../../../theme-provider.dart';

import 'block-footer.dart';
import 'block-header.dart';
import 'slidable-list-item.dart';

class OutsideThisWeek extends StatefulWidget {
  @override
  _OutsideThisWeekState createState() => _OutsideThisWeekState();
}

class _OutsideThisWeekState extends State<OutsideThisWeek> {

  Color accentColor = ThemeProvider.green3;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      color: ThemeProvider.lightBlue,
      child: Column(
        children: <Widget>[
          BlockHeader(
            title: "Outside This Week",
            description: "Suggested for outsided the home. Slide the card to customize",
            colorAccent: accentColor
          ),
          SlidableCard(),
          SizedBox(height: 20),
          SlidableListItem(
            title: "Hedge trimming",
            description: "Trim the hedges to keep them looking nice",
            points: 10,
            color: ThemeProvider.green3),
          SlidableListItem(
            title: "Hedge trimming",
            description: "Trim the hedges to keep them looking nice",
            points: 10,
            color: ThemeProvider.green3),
          BlockFooter(text: "OUTSIDE", accentColor: accentColor)
        ],
      ),
    );
  }
}
