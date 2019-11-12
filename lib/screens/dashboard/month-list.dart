import 'package:custodia/models/maintenance_item.dart';
import 'package:custodia/screens/widgets/drawer.dart';
import 'package:custodia/screens/widgets/progress-indicator.dart';
import 'package:custodia/services/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:intl/intl.dart';

import '../../theme-provider.dart';

class ItemsMonthListPage extends StatefulWidget {

  final int sectionId;
  final int userId;
  final Color accentColor;

  ItemsMonthListPage({this.sectionId, this.userId, this.accentColor});

  @override
  _ItemsMonthListPageState createState() => _ItemsMonthListPageState();
}

class _ItemsMonthListPageState extends State<ItemsMonthListPage> {

  DateTime now = DateTime.now();
  var formatter = DateFormat('dd MMMM');
  List<MaintenanceItem> items = [];

  @override
  void initState() {
    getItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Drawer(
        child: DrawerContent()
      ),
      appBar: GradientAppBar(
        title: Text(
          formatter.format(now),
          style: TextStyle(fontFamily: "RobotoBlack", fontSize: 28)
        ),
        centerTitle: false,
        gradient: ThemeProvider.blueGradientHorizontal,
        automaticallyImplyLeading: false,
        leading: IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: navigateBack),
      ),
      body: body(),
    );
  }

  Widget body() {
    return items.isNotEmpty ? ListView(children: items.map<Widget>((item) { return buildItem(item); }).toList() ) : ProgressIndicatorWithPadding();
  }

  Widget buildItem(MaintenanceItem item){
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: widget.accentColor,
              borderRadius: BorderRadius.circular(3)
            ),
            width: 90,
            height: 90,
            child: Text(
                "${item.points} points",
                style: TextStyle(
                  color: Colors.white,
                  shadows: <Shadow>[
                    Shadow(
                      offset: Offset(1.0, 1.0),
                      blurRadius: 1.0,
                      color: ThemeProvider.grey1,
                    ),
                  ],
                )
            ),
          ),
          SizedBox(width: 25),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                    item.title.toUpperCase(),
                    style: TextStyle(
                        fontSize: 24,
                        fontFamily: "RobotoMedium"
                    )
                ),
                Text(
                    item.summary,
                    style: TextStyle(
                      fontSize: 20,
                    )
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void getItems() async {
    items = await APIService.fetchMaintenanceItems(widget.userId, widget.sectionId);
    setState(() {});
  }

  void navigateBack() {
    Navigator.pop(context);
  }
}
