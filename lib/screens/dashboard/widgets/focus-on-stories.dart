import 'package:flutter/material.dart';

import '../../../theme-provider.dart';
import 'block-footer.dart';
import 'block-header.dart';
import 'slidable-list-item.dart';

class FocusOnStories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    Color accentColor = ThemeProvider.blue4;

    return Container(
      padding: const EdgeInsets.only(top: 10),
      color: Colors.white,
      child: Column(
        children: <Widget>[
          BlockHeader(
            title: "Focus on stories",
            description: "Suggested for outsided the home. Slide the card to customize",
            colorAccent: accentColor
          ),
//          headerCard(),
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
          BlockFooter(text: "CLEAN", accentColor: accentColor)
        ],
      ),
    );
  }
}
