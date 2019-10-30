import 'package:custodia/models/maintenance_item.dart';
import 'package:custodia/screens/dashboard/widgets/slidable-card.dart';
import 'package:custodia/screens/dashboard/widgets/slidable-list-item.dart';
import 'package:flutter/material.dart';

import '../../../theme-provider.dart';

import 'block-footer.dart';
import 'block-header.dart';

class DashboardSection extends StatefulWidget {

  final String title;
  final String subtitle;
  final Color accentColor;
  final List<MaintenanceItem> items;
  final int userId;

  DashboardSection({this.title, this.subtitle, this.accentColor, this.items, this.userId});

  @override
  _DashboardSectionState createState() => _DashboardSectionState();
}

class _DashboardSectionState extends State<DashboardSection> {

  List<Widget> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      color: ThemeProvider.lightBlue,
      child: Column(
        children: <Widget>[
          HeaderItem(
            title: widget.title,
            description: widget.subtitle,
            colorAccent: widget.accentColor
          ),
//          SlidableCard(),
          SizedBox(height: 20),
          buildChildren(),
          FooterItem(mainText: "MORE THIS MONTH FOR ", accentText: widget.title, accentColor: widget.accentColor)
        ],
      ),
    );
  }

  buildChildren(){
    items = widget.items.map<Widget>((item) => buildItem(item)).toList();
    return Column(children: items);
  }

  buildItem(MaintenanceItem item){
    return SlidableListItem(
      key: Key("index_${item.id}"),
      userId: widget.userId,
      item: item,
      onIgnore: onIgnore,
      color: widget.accentColor);
  }

  onIgnore(int itemId) {
//    setState(() {
//      items.removeWhere((item) => item.key == Key("index_$itemId"));
//    });
  }
}
