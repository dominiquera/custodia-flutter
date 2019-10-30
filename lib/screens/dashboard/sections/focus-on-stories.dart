//import 'package:custodia/models/maintenance_item.dart';
//import 'package:custodia/screens/widgets/progress-indicator.dart';
//import 'package:custodia/services/api.dart';
//import 'package:flutter/material.dart';
//import '../../../theme-provider.dart';
//
//import '../widgets/block-footer.dart';
//import '../widgets/block-header.dart';
//import '../widgets/slidable-list-item.dart';
//
//class FocusOnStories extends StatefulWidget {
//  @override
//  _FocusOnStoriesState createState() => _FocusOnStoriesState();
//}
//
//class _FocusOnStoriesState extends State<FocusOnStories> {
//
//  Color accentColor = ThemeProvider.blue4;
//  List<MaintenanceItem> items = [];
//
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      padding: const EdgeInsets.only(top: 10),
//      color: Colors.white,
//      child: Column(
//        children: <Widget>[
//          HeaderItem(
//            title: "Focus on stories",
//            description: "Suggested for outsided the home. Slide the card to customize",
//            colorAccent: accentColor
//          ),
////          headerCard(),
//          SizedBox(height: 20),
//          buildChildren(),
//          FooterItem(mainText: "MORE THIS MONTH FOR ", accentText: "STORIES", accentColor: accentColor)
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
//      item: item,
//      color: ThemeProvider.green3);
//  }
//
//  void fetchItems() async {
//    items = await APIService.fetchTop3ItemsForSection(4);
//    setState(() {});
//  }
//}
