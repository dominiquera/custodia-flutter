import 'package:custodia/models/maintenance_item.dart';
import 'package:custodia/screens/dashboard/widgets/slidable-card.dart';
import 'package:custodia/screens/dashboard/widgets/slidable-list-item.dart';
import 'package:flutter/material.dart';

import '../../../theme-provider.dart';

import 'block-footer.dart';
import 'block-header.dart';

class DashboardSection extends StatelessWidget {

  final String title;
  final String subtitle;
  final Color accentColor;
  final List<MaintenanceItem> items;

  DashboardSection({this.title, this.subtitle, this.accentColor, this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      color: ThemeProvider.lightBlue,
      child: Column(
        children: <Widget>[
          HeaderItem(
            title: title,
            description: subtitle,
            colorAccent: accentColor
          ),
//          SlidableCard(),
          SizedBox(height: 20),
          buildChildren(),
          FooterItem(mainText: "MORE THIS MONTH FOR ", accentText: title, accentColor: accentColor)
        ],
      ),
    );
  }

  buildChildren(){
    return Column(children: items.map<Widget>((item) => buildItem(item)).toList() );
  }

  buildItem(MaintenanceItem item){
    return SlidableListItem(
      title: item.title,
      description: item.summary,
      points: item.points,
      color: ThemeProvider.green3);
  }
}
