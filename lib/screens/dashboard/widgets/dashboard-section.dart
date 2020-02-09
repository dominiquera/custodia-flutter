import 'package:custodia/models/maintenance_item.dart';
import 'package:custodia/screens/dashboard/widgets/slidable-card.dart';
import 'package:custodia/screens/dashboard/widgets/slidable-list-item.dart';
import 'package:flutter/material.dart';

import '../../../theme-provider.dart';

import '../month-list.dart';
import 'block-footer.dart';
import 'block-header.dart';

class DashboardSection extends StatefulWidget {

  final String title;
  final String subtitle;
  final Color accentColor;
  final Color backgroundColor;
  final Color backgroundCardColor;
  final Color textCardColor;

  final List<MaintenanceItem> items;
  final int userId;
  final Function onUpdate;
  final int id;

  DashboardSection({this.title, this.subtitle, this.accentColor, this.items, this.userId, this.onUpdate, this.id,this.backgroundColor,this.textCardColor,this.backgroundCardColor});

  @override
  _DashboardSectionState createState() => _DashboardSectionState();
}

class _DashboardSectionState extends State<DashboardSection> {

  List<Widget> items;

  @override
  void initState() {
    int i = 1;
    items = widget.items.map<Widget>((item) {
      Widget widgetItem;
      if (i == 1) {
        widgetItem = buildHeaderItem(item);
      } else {
        widgetItem = buildItem(item);
      }

      i++;
      return widgetItem;
    }).toList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      color: widget.backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          HeaderItem(
            title: widget.title,
            description: widget.subtitle,
            colorAccent: widget.accentColor
          ),
//          SlidableCard(),
          SizedBox(height: 20),
          Column(children: items),
          FooterItem(
            mainText: "MORE FOR THIS MONTH FOR ",
            accentText: widget.title,
            accentColor: widget.accentColor,
            onTap: openMonthList
          )
        ],
      ),
    );
  }

  Widget buildHeaderItem(MaintenanceItem item) {
    return SlidableCard(
      key: Key("index_${item.id}"),
      userId: widget.userId,
      item: item,
      onActionDone: hideItem,
      color: widget.accentColor,
      backgroundColor: widget.backgroundColor,
      backgroundCardColor: widget.backgroundCardColor,
      textCardColor:widget.textCardColor
    );
  }

  Widget buildItem(MaintenanceItem item){
    return SlidableListItem(
      key: Key("index_${item.id}"),
      userId: widget.userId,
      item: item,
      onActionDone: hideItem,
      color: widget.accentColor,
    );
  }

  hideItem(int itemId) {
    setState(() {
      items.removeWhere((item) => item.key == Key("index_$itemId"));
    });
    widget.onUpdate();
  }



  openMonthList() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ItemsMonthListPage(userId: widget.userId, sectionId: widget.id, accentColor: widget.accentColor)),
    );

  }
}
