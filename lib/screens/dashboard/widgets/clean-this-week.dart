import 'package:custodia/screens/dashboard/widgets/slidable-card.dart';
import 'package:flutter/material.dart';
import '../../../theme-provider.dart';

import 'block-footer.dart';
import 'block-header.dart';
import 'slidable-list-item.dart';

class CleanThisWeek extends StatefulWidget {
  @override
  _CleanThisWeekState createState() => _CleanThisWeekState();
}

class _CleanThisWeekState extends State<CleanThisWeek> {

  Color accentColor = ThemeProvider.lightBrown;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      color: ThemeProvider.lightGrey1,
      child: Column(
        children: <Widget>[
          HeaderItem(
            title: "Clean This Week",
            description: "Suggested for outsided the home. Slide the card to customize",
            colorAccent: accentColor
          ),
          SlidableCard(),
          SizedBox(height: 20),
          SlidableListItem(
            title: "Hedge trimming",
            description: "Trim the hedges to keep them looking nice",
            points: 10,
            color: accentColor),
          SlidableListItem(
            title: "Hedge trimming",
            description: "Trim the hedges to keep them looking nice",
            points: 10,
            color: accentColor),
          FooterItem(mainText: "MORE THIS MONTH FOR ", accentText: "CLEAN",  accentColor: accentColor)
        ],
      ),
    );
  }
}
