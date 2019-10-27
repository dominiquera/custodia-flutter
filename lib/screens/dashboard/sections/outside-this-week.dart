//import 'package:custodia/models/maintenance_item.dart';
//import 'package:custodia/screens/dashboard/widgets/slidable-card.dart';
//import 'package:custodia/screens/dashboard/widgets/slidable-list-item.dart';
//import 'package:custodia/screens/widgets/progress-indicator.dart';
//import 'package:custodia/services/api.dart';
//import 'package:flutter/material.dart';
//
//import '../../../theme-provider.dart';
//
//import 'block-footer.dart';
//import 'block-header.dart';
//
//class OutsideThisWeek extends StatefulWidget {
//  @override
//  _OutsideThisWeekState createState() => _OutsideThisWeekState();
//}
//
//class _OutsideThisWeekState extends State<OutsideThisWeek> {
//
//  Color accentColor = ThemeProvider.green3;
//  List<MaintenanceItem> items = [];
//
//  @override
//  void initState() {
//    // TODO: implement initState
//    fetchItems();
//    super.initState();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      padding: const EdgeInsets.only(top: 10),
//      color: ThemeProvider.lightBlue,
//      child: Column(
//        children: <Widget>[
//          HeaderItem(
//            title: "Outside This Month",
//            description: "Suggested for outsided the home. Slide the card to customize",
//            colorAccent: accentColor
//          ),
//          SlidableCard(),
//          SizedBox(height: 20),
//          buildChildren(),
//          FooterItem(mainText: "MORE THIS MONTH FOR ", accentText: "OUTSIDE", accentColor: accentColor)
//        ],
//      ),
//    );
//  }
//
//  buildChildren(){
//    if (items.isEmpty) {
//      return ProgressIndicatorWithPadding();
//    } else {
//      return Column(children: items.map<Widget>((item) => buildItem(item)).toList() );
//    }
//  }
//
//  buildItem(MaintenanceItem item){
//    return SlidableListItem(
//      title: item.title,
//      description: item.summary,
//      points: item.points,
//      color: ThemeProvider.green3);
//  }
//
//  void fetchItems() async {
//    items = await APIService.fetchTop3ItemsForSection(1);
//    setState(() {});
//  }
//}
