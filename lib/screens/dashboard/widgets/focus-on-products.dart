import 'package:flutter/material.dart';

import '../../../theme-provider.dart';
import 'block-footer.dart';
import 'block-header.dart';
import 'slidable-list-item.dart';

class FocusOnProducts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    Color accentColor = ThemeProvider.blue7;

    return Container(
      padding: const EdgeInsets.only(top: 10),
      color: ThemeProvider.lightBlue,
      child: Column(
        children: <Widget>[
          BlockHeader(
            title: "Focus on products",
            description: "Suggested products that make the home more enjoyable",
            colorAccent: accentColor
          ),
//          SlidableCard(),
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
          BlockFooter(text: "PRODUCTS", accentColor: accentColor)
        ],
      ),
    );
  }
}
