import 'package:custodia/models/maintenance_item.dart';
import 'package:custodia/models/score.dart';
import 'package:custodia/screens/dashboard/widgets/dashboard-section.dart';
import 'package:custodia/screens/dashboard/widgets/score-bar.dart';
import 'package:custodia/screens/dashboard/widgets/steps.dart';
import 'package:custodia/screens/dashboard/widgets/top-3-checkpoints.dart';
import 'package:custodia/screens/widgets/progress-indicator.dart';
import 'package:custodia/services/api.dart';
import 'package:custodia/services/firebase-auth.dart';
import 'package:custodia/utils/globals.dart';
import 'package:custodia/utils/shared-prefs.dart';
import 'package:custodia/screens/widgets/drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:gradient_app_bar/gradient_app_bar.dart';

import '../../theme-provider.dart';
import 'package:intl/intl.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  int currentAPIUserId;

  Score score;
  List<MaintenanceItem> outsideItems = [];
  List<MaintenanceItem> insideItems = [];
  List<MaintenanceItem> storiesItems = [];
  List<MaintenanceItem> cleanItems = [];
  List<MaintenanceItem> careItems = [];
  List<MaintenanceItem> productsItems = [];
  List<MaintenanceItem> relatedServicesItems = [];
  List<MaintenanceItem> preventItems = [];

  List<MaintenanceItem> top3MaintenanceItems = [];


  List<Map<String, dynamic>> sectionData;

  DateTime now = DateTime.now();
  var formatter = DateFormat('dd MMMM');
  String homeDescription = "";
  bool stepsClosed;

  @override
  void initState() {
    getSharedPrefs();
    getCurrentUserId();

    sectionData = [
      {"id": 1, "title": "Outside This Month", "subtitle": "Suggested for outside the home. Slide the card to customize", "accentColor": ThemeProvider.green3, "items": outsideItems, "fetched": false},
      {"id": 2, "title": "Inside This Month", "subtitle": "Suggested for inside the home. Slide the card to customize", "accentColor": ThemeProvider.green3, "items": insideItems, "fetched": false},
      {"id": 3, "title": "Clean This Month", "subtitle": "Suggested for outside the home. Slide the card to customize", "accentColor": ThemeProvider.lightBrown, "items":  cleanItems, "fetched": false},
      {"id": 4, "title": "Focus on Stories", "subtitle": "A few stories suggested for you. Slide the card to customize", "accentColor": ThemeProvider.blue4, "items": storiesItems, "fetched": false},
      {"id": 5, "title": "A Focus on Care", "subtitle": "", "accentColor": Colors.red, "items": careItems, "fetched": false},
      {"id": 6, "title": "Meaningful Producs", "subtitle": "Suggested products that make the home more enjoyable. Slide the card to customize", "accentColor": ThemeProvider.blue7, "items": productsItems, "fetched": false},
      {"id": 7, "title": "Related Services", "subtitle": "", "accentColor": Colors.red, "items": relatedServicesItems, "fetched": false},
      {"id": 8, "title": "Prevent This Month", "subtitle": "Suggested for inside the home. Slide the card to customize", "accentColor": ThemeProvider.blue7, "items": preventItems, "fetched": false},
    ];
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
      addAutomaticKeepAlives: false,
      children: <Widget>[
        header(),
        (stepsClosed == false) ? Steps() : Container(),
        score != null ? scoreBlock() : Container(),
        (top3MaintenanceItems != null && top3MaintenanceItems.isNotEmpty) ? Top3Checkpoints(items: top3MaintenanceItems) : Container(),
        currentAPIUserId != null ? Column(children: buildSections()) : Container()
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
          items: section["items"],
          userId: currentAPIUserId,
          onUpdate: onSectionUpdate,
          id: section["id"]
        );
      } else if (section["items"].isEmpty && section["fetched"] == false) {
        return ProgressIndicatorWithPadding();
      } else {
        return Container();
      }
    }).toList();
  }

  onSectionUpdate(){
    fetchScore();
    fetchSections();
    getTop3MaintenanceItems();
  }

  Widget header() {
    return Stack(
      alignment: Alignment.bottomLeft,
      children: <Widget>[
        //Image.asset("assets/images/house.jpg", height: 500, fit: BoxFit.fitHeight,),
        Padding(
          padding: EdgeInsets.all(ThemeProvider.screenPadding),
          child: Column(
            children: <Widget>[
              Text(
                  homeDescription,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 34,
                  fontFamily: "RobotoBlack"
                )
              ),
              SizedBox(height: 15),
              Row(
                children: <Widget>[
                  Expanded(
                    child: homeDescription != null ? Text(
                      homeDescription,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      )
                    ) : Container(),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                    decoration: BoxDecoration(
                      color: ThemeProvider.lime,
                      borderRadius: BorderRadius.circular(20.0)
                    ),
                    child: score != null ? buildScore() : Container(width: 20, height: 20, child: CircularProgressIndicator(),)
                  )
                ],
              )
            ]
          ),
        )
      ],
    );
  }

  Widget buildScore(){
    return Text("${score.value}/850",
      style: TextStyle(
        fontSize: 16,
        color: ThemeProvider.blue6,
      )
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
              "Hello $userName, just a few things on for this week. Here is your current Home Score.",
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
    APIService.fetchScore(currentAPIUserId).then((value) {
      score = value;
      setState(() {});
    });
  }

  void fetchUserDetails() async {
    APIService.fetchUserDetails(currentAPIUserId).then((value) {
      homeDescription = value.title;
      userName = value.name;

      setState(() {});
    });

  }

  void fetchSections() async {
    sectionData.forEach((section) async {
      APIService.fetchTop3ItemsForSection(currentAPIUserId, section["id"]).then((result) {

        section["items"] = result;
        section["fetched"] = true;
        setState(() {});
      });
    });
  }

  void getCurrentUserId() async {
    SharedPrefsService.getCurrentUserId().then((userId) {
      currentAPIUserId = userId;
      getTop3MaintenanceItems();
      print("USER id: $userId");
      fetchSections();
      fetchScore();
      fetchUserDetails();
    });
  }

  void getTop3MaintenanceItems() async {
    top3MaintenanceItems = await APIService.fetchTop3Items(currentAPIUserId);
    if (this.mounted){
      setState(() {});
    }

  }

  void getSharedPrefs() async {
    stepsClosed = await SharedPrefsService.getStepsState();
    setState(() {});
  }

}
