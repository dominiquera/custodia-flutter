import 'package:custodia/models/maintenance_item.dart';
import 'package:custodia/models/score.dart';
import 'package:custodia/screens/dashboard/widgets/clean-this-week.dart';
import 'package:custodia/screens/dashboard/widgets/dashboard-section.dart';
import 'package:custodia/screens/dashboard/widgets/focus-on-products.dart';
import 'package:custodia/screens/dashboard/widgets/focus-on-stories.dart';
import 'package:custodia/screens/dashboard/widgets/outside-this-week.dart';
import 'package:custodia/screens/dashboard/widgets/prevent-this-week.dart';
import 'package:custodia/screens/dashboard/widgets/score-bar.dart';
import 'package:custodia/screens/dashboard/widgets/steps.dart';
import 'package:custodia/screens/dashboard/widgets/top-3-checkpoints.dart';
import 'package:custodia/screens/widgets/progress-indicator.dart';
import 'package:custodia/services/api.dart';
import 'package:custodia/widgets/drawer.dart';
import 'package:flutter/material.dart';

import 'package:gradient_app_bar/gradient_app_bar.dart';

import '../../theme-provider.dart';
import 'package:intl/intl.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  Score score;
  List<MaintenanceItem> outsideItems = [];
  List<MaintenanceItem> insideItems = [];
  List<MaintenanceItem> storiesItems = [];
  List<MaintenanceItem> cleanItems = [];
  List<MaintenanceItem> careItems = [];
  List<MaintenanceItem> productsItems = [];
  List<MaintenanceItem> relatedServicesItems = [];
  List<MaintenanceItem> preventItems = [];

  List<Map<String, dynamic>> sectionData;

  DateTime now = DateTime.now();
  var formatter = DateFormat('dd MMMM');

  @override
  void initState() {
    sectionData = [
      {"id": 1, "title": "Outside This Month", "subtitle": "Suggested for outsided the home. Slide the card to customize", "accentColor": Colors.red, "items": outsideItems, "fetched": false},
      {"id": 2, "title": "Inside This Month", "subtitle": "Suggested for outsided the home. Slide the card to customize", "accentColor": Colors.red, "items": insideItems, "fetched": false},
      {"id": 3, "title": "Clean This Month", "subtitle": "Suggested for outsided the home. Slide the card to customize", "accentColor": Colors.red, "items":  cleanItems, "fetched": false},
      {"id": 4, "title": "Focus on Stories", "subtitle": "Suggested for outsided the home. Slide the card to customize", "accentColor": Colors.red, "items": storiesItems, "fetched": false},
      {"id": 5, "title": "A Focus on Care", "subtitle": "Suggested for outsided the home. Slide the card to customize", "accentColor": Colors.red, "items": careItems, "fetched": false},
      {"id": 6, "title": "Meaningful Producs", "subtitle": "Suggested for outsided the home. Slide the card to customize", "accentColor": Colors.red, "items": productsItems, "fetched": false},
      {"id": 7, "title": "Related Services", "subtitle": "Suggested for outsided the home. Slide the card to customize", "accentColor": Colors.red, "items": relatedServicesItems, "fetched": false},
      {"id": 8, "title": "Prevent This Month", "subtitle": "Suggested for outsided the home. Slide the card to customize", "accentColor": Colors.red, "items": preventItems, "fetched": false},
    ];

    fetchSections();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Drawer(
        child: DrawerContent()
      ),
      appBar: GradientAppBar(
        title: Text(formatter.format(now), style: TextStyle(fontFamily: "RobotoBlack", fontSize: 28)),
        centerTitle: false,
        gradient: ThemeProvider.blueGradientHorizontal,
        automaticallyImplyLeading: false,
      ),
      body: body(),
    );
  }

  Widget body() {
    return ListView(
      children: <Widget>[
        header(),
        Steps(),
//        score != null
//          ? scoreBlock()
//          : Padding(
//              padding: const EdgeInsets.all(10.0),
//              child: Center(child: CircularProgressIndicator()),
//        ),
        Column(children: buildSections())
//        outsideItems.isEmpty ? Container() : DashboardSection(title: "Outside This Month", subtitle: "Suggested for outsided the home. Slide the card to customize", accentColor: Colors.red, items: outsideItems),
//        storiesItems.isEmpty ? Container() : DashboardSection(title: "Outside This Month", subtitle: "Suggested for outsided the home. Slide the card to customize", accentColor: Colors.red, items: storiesItems),
//        preventItems.isEmpty ? Container() : DashboardSection(title: "Prevent This Month", subtitle: "Suggested for outsided the home. Slide the card to customize", accentColor: Colors.red, items: preventItems),

//        Top3Checkpoints(),
//        OutsideThisWeek(),
//        PreventThisWeek(),
//        CleanThisWeek(),
//        FocusOnStories(),
//        FocusOnProducts()
      ]
    );
  }

  List<Widget> buildSections(){
    return sectionData.map((section) {

      if (section["items"].isNotEmpty) {
        return DashboardSection(
          title: section["title"],
          subtitle: section["subtitle"],
          accentColor: section["accentColor"],
          items: section["items"]
        );
      } else if (section["items"].isEmpty && section["fetched"] == false) {
        return ProgressIndicatorWithPadding();
      } else {
        return Container();
      }
    }).toList();
  }

  Widget header() {
    return Stack(
      alignment: Alignment.bottomLeft,
      children: <Widget>[
        Image.asset("assets/images/house.jpg", height: 500, fit: BoxFit.fitHeight,),
        Padding(
          padding: EdgeInsets.all(ThemeProvider.screenPadding),
          child: Column(
            children: <Widget>[
              Text(
                "Home Management Plan",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 34,
                  fontFamily: "RobotoBlack"
                )
              ),
              SizedBox(height: 15),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      "A 4 bedroom bungalow with 3000 sq/ft of lawn, a few hedges, gardens and a pool",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      )
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                    decoration: BoxDecoration(
                      color: ThemeProvider.lime,
                      borderRadius: BorderRadius.circular(20.0)
                    ),
                    child: Text("222/721",
                      style: TextStyle(
                        fontSize: 16,
                        color: ThemeProvider.blue6,
                      )
                    )
                  )
                ],
              )
            ]
          ),
        )
      ],
    );
  }

  Widget scoreBlock() {
    return Padding(
      padding: EdgeInsets.only(top: ThemeProvider.screenPadding, bottom: ThemeProvider.screenPadding),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: ThemeProvider.screenPadding),
            child: Text(
              "Good morning John, just a few things on for this week. Here is your dad's current Home Score.",
              style: TextStyle(
                fontSize: 26,
                fontFamily: "RobotoMedium"
              ),
            ),
          ),
          SizedBox(height: 30),
          Container(
            height: 5,
            decoration: BoxDecoration(
              gradient: ThemeProvider.greyGradientVertical
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: ThemeProvider.screenPadding),
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    padding: EdgeInsets.all(0),
                    onPressed: (){},
                    icon: Icon(Icons.info, color: ThemeProvider.blue1)
                  ),
                ),
                ScoreBar(score: score)
              ]
            ),
          ),
        ],
      ),
    );
  }

  void fetchScore() async {
    APIService.fetchScore().then((value) {
      score = value;
      setState(() {});
    });
  }

  void fetchSections() async {
    sectionData.forEach((section) async {
      section["items"] = await APIService.fetchTop3ItemsForSection(section["id"]);
      APIService.fetchTop3ItemsForSection(section["id"]).then((result) {
        section["fetched"] = true;
        setState(() {});
      });
    });
  }

}
