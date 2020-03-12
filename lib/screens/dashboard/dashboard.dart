import 'dart:developer';

import 'package:custodia/models/maintenance_item.dart';
import 'package:custodia/models/score.dart';
import 'package:custodia/screens/dashboard/widgets/dashboard-section.dart';
import 'package:custodia/screens/dashboard/widgets/overlay-request-noitem.dart';
import 'package:custodia/screens/dashboard/widgets/overlay-request.dart';
import 'package:custodia/screens/dashboard/widgets/score-bar.dart';
import 'package:custodia/screens/dashboard/widgets/steps.dart';
import 'package:custodia/screens/dashboard/widgets/top-3-checkpoints.dart';
import 'package:custodia/screens/widgets/progress-indicator.dart';
import 'package:custodia/services/api.dart';
import 'package:custodia/services/firebase-auth.dart';
import 'package:custodia/utils/globals.dart' as globals;
import 'package:custodia/utils/shared-prefs.dart';
import 'package:custodia/screens/widgets/drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:synchronized/synchronized.dart';
import '../../services/firebase_messaging.dart';
import '../../theme-provider.dart';
import 'package:intl/intl.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  FirebaseNotifications firebaseNotifications = FirebaseNotifications();
  Score score;
//  List<MaintenanceItem> outsideItems = [];
//  List<MaintenanceItem> insideItems = [];
//  List<MaintenanceItem> storiesItems = [];
//  List<MaintenanceItem> cleanItems = [];
//  List<MaintenanceItem> careItems = [];
//  List<MaintenanceItem> productsItems = [];
//  List<MaintenanceItem> relatedServicesItems = [];
//  List<MaintenanceItem> preventItems = [];

  List<MaintenanceItem> top3MaintenanceItems = [];


  List<Map<String, dynamic>> sectionData;

  DateTime now = DateTime.now();
  var formatter = DateFormat('MMMM dd');
  String homeDescription = "";
  String subtitle = "";
  bool stepsClosed;
  int totalItems = 0;
  int fetchedSectionsCount = 0;

  @override
  void initState() {
    getSharedPrefs();
    getCurrentUserId();

    sectionData = [
      {"id": 1, "title": "Outside This Month", "subtitle": "", "accentColor": Color.fromARGB(255, 99, 163, 15), "backgroundCardColor": Color.fromARGB(255, 255, 255, 255), "backgroundColor": Color.fromARGB(255, 255, 255, 255), "textCardColor": Color.fromARGB(255, 0, 0, 0), "items": [], "fetched": false},
      {"id": 2, "title": "Inside This Month", "subtitle": "", "accentColor": Color.fromARGB(255, 246, 145, 121), "backgroundCardColor": Color.fromARGB(255, 246, 145, 121), "backgroundColor": Color.fromARGB(1, 250, 250, 250), "textCardColor": Color.fromARGB(255, 0, 0, 0), "items": [], "fetched": false},
      {"id": 3, "title": "Clean This Month", "subtitle": "Suggested Cleaning For This Week", "accentColor": Color.fromARGB(255, 54, 166, 146), "items":  [], "backgroundCardColor": Color.fromARGB(255, 255, 255, 255), "backgroundColor": Color.fromARGB(1, 255, 255, 255), "textCardColor": Color.fromARGB(255, 0, 0, 0), "fetched": false},
      {"id": 4, "title": "Focus on Stories", "subtitle": "A few stories suggested for you. Slide the card to customize", "accentColor": ThemeProvider.blue4, "backgroundCardColor": Color.fromARGB(255, 255, 255, 255), "backgroundColor": Color.fromARGB(1, 255, 255, 255), "textCardColor": Color.fromARGB(255, 0, 0, 0), "items": [], "fetched": false},
      {"id": 1, "title": "Spotlight"},
      {"id": 5, "title": "A Focus on Care", "subtitle": "Ideas for activities, health, and wellness", "accentColor": Color.fromARGB(255, 219, 62, 78), "backgroundCardColor": Color.fromARGB(255, 250, 250, 250), "backgroundColor": Color.fromARGB(1, 250, 250, 250), "textCardColor": Color.fromARGB(255, 0, 0, 0), "items": [], "fetched": false},
      {"id": 6, "title": "Meaningful Producs", "subtitle": "Suggested products that make the home more enjoyable. Slide the card to customize", "accentColor": ThemeProvider.blue7, "backgroundColor": Color.fromARGB(1, 255, 255, 255), "textCardColor": Color.fromARGB(255, 0, 0, 0), "items": [], "fetched": false},
      {"id": 7, "title": "Related Services", "subtitle": "", "accentColor": Colors.red, "backgroundCardColor": Color.fromARGB(255, 255, 255, 255), "backgroundColor": Color.fromARGB(1, 255, 255, 255), "textCardColor": Color.fromARGB(255, 0, 0, 0), "items": [], "fetched": false},
      {"id": 8, "title": "Prevent This Month", "subtitle": "Prevent future issues with simple maintenance", "accentColor": Color.fromARGB(255, 0, 80, 197), "backgroundCardColor": Color.fromARGB(255, 0, 80, 197), "textCardColor": Color.fromARGB(255, 255, 255, 255), "backgroundColor": Color.fromARGB(1, 250, 250, 250), "items": [], "fetched": false},
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController _homeController = ScrollController();
    return Scaffold(
      endDrawer: Drawer(
        child: DrawerContent(homeController: _homeController)
      ),
      appBar: GradientAppBar(
        title: Row(children: <Widget>[
          new Image.asset(
            'assets/images/icon.png',
            width: 40.0,
            height: 40.0,
            
          ),
          Padding(padding: EdgeInsets.all(5),),
          Text(formatter.format(now), style: TextStyle(fontFamily: "NunitoBlack", fontSize: 28)),
        ]),
        centerTitle: false,
        gradient: ThemeProvider.blueGradientHorizontal,
        automaticallyImplyLeading: false,
      ),
      body: body(_homeController),
    );
  }

  Widget body(ScrollController _homeController) {

    return ListView(
        controller: _homeController,
        children: <Widget>[ buildItem() ]
    );
  }

  buildItem() {
    return Column(
      children: <Widget>[
        header(),
//        (stepsClosed == false) ? Steps() : Container(),
//        SizedBox(height: 30),
//        Padding(
//          padding: EdgeInsets.symmetric(
//            horizontal: ThemeProvider.screenPadding,
//          ),
//          child: Text(
//            "Hello ${globals.userName}, just a few things on for this week. Here is your current Home Score.",
//            style: TextStyle(
//                fontSize: 26,
//                fontFamily: "NunitoMedium"
//            ),
//          ),
//        ),
//        SizedBox(height: 30),
        Container(
          height: 5,
          decoration: BoxDecoration(
              gradient: ThemeProvider.greyGradientVertical
          ),
        ),
        StickyHeader(

          header: score != null ? scoreBlock() : Container(),
          content: Column(
            children: <Widget>[
              (top3MaintenanceItems != null && top3MaintenanceItems.isNotEmpty) ? Top3Checkpoints(items: top3MaintenanceItems, onUpdate: onSectionUpdate) : Container(),
              globals.userId != null ? Column(children: buildSections()) : Container(),
            ],
          ),
        ),
//        SizedBox(height: 20),
//        buildSpotlightSection(),
        SizedBox(height: 20),
        buildRequestSection(),
        SizedBox(height: 20),
      ],
    );
  }

  Widget buildRequestSection(){
    return Container(
      child: FlatButton.icon(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        onPressed: showAutomateOverlayDialog,
        color: ThemeProvider.blue4,
        icon: Image.asset("assets/images/request.png", width: 20,),
        label: Text("Make a Request", style: TextStyle(color: Colors.white),),
      )
    );
  }

  Widget buildSpotlightSection(){
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
      child: Container(
        color: ThemeProvider.lighterViolet,
        padding: EdgeInsets.only(
            top: 10,
            bottom: 30,
            left: 10,
            right: 10),
        child: InkWell(
          onTap: openMag,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Spotlight",
                style: TextStyle(
                    fontFamily: "NunitoBlack",
                    fontSize: 24,
                    color: ThemeProvider.violet),),
              Text(
                "Suggested content. Tap to open",
                textAlign: TextAlign.left,
                style: TextStyle(color: ThemeProvider.grey2),
              ),
              SizedBox(height: 10,),
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Column(
                  children: <Widget>[
                    Image.asset("assets/images/spotlight.jpg", fit: BoxFit.fitWidth),
                    Container(
                        color: ThemeProvider.violet,
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "Protect your seniors at home and don't let them fall prey to fraudsters and defective work. Get our magazine to learn more.",
                          style: TextStyle(color: Colors.white, fontSize: 22),
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  openMag() async {
    const url = 'https://mag.custodia.com';
    if (await canLaunch(url)) {
    await launch(url);
    } else {
    throw 'Could not launch $url';
    }
  }


  List<Widget> buildSections(){
    if (fetchedSectionsCount == sectionData.length && totalItems == 0) {
      return buildNoTasksLeft();
    } else {
      return sectionData.map((section) {
        if(section["title"] == "Spotlight") {
          return buildSpotlightSection();
        }
        if (section["items"].isNotEmpty) {
          return DashboardSection(
            title: section["title"],
            subtitle: section["subtitle"],
        accentColor: section["accentColor"],
        backgroundColor: section["backgroundColor"],
        backgroundCardColor: section["backgroundCardColor"],
        textCardColor: section["textCardColor"],
        items: section["items"],
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
  }

  var fetchScoreLock = Lock();
  var fetchSectionLock = Lock();
  var top3Lock = Lock();
  onSectionUpdate(){
    fetchScoreLock.synchronized(fetchScore);
    fetchSectionLock.synchronized(fetchSections);
    top3Lock.synchronized(getTop3MaintenanceItems);
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
                    fontSize: 32,
                    fontFamily: "NunitoMedium"
                  )
                ),
                SizedBox(height: 15),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: subtitle != null ? Text(
                          subtitle,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          )
                      ) : Container(),
                    ),
//                    Container(
//                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
//                        decoration: BoxDecoration(
//                            color: ThemeProvider.lime,
//                            borderRadius: BorderRadius.circular(20.0)
//                        ),
//                        child: score != null ? buildScore() : Container(width: 20, height: 20, child: CircularProgressIndicator(),)
//                    )
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
    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.only(top: ThemeProvider.screenPadding, bottom: ThemeProvider.screenPadding),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: ThemeProvider.screenPadding),
              child: Column(
                  children: <Widget>[
//                  Align(
//                    alignment: Alignment.centerRight,
//                    child: IconButton(
//                      padding: EdgeInsets.all(0),
//                      onPressed: (){},
//                      icon: Icon(Icons.info, color: ThemeProvider.blue1)
//                    ),
//                  ),
                    ScoreBar(score: score)
                  ]
              ),
            ),
          ],
        ),
      ),
    );
  }

  void fetchScore() async {
    APIService.fetchScore().then((value) {
      score = value;
      setState(() {});
    });
  }

  void fetchUserDetails() async {
    APIService.fetchUserDetails().then((value) {
      homeDescription = value.title;
      globals.userName = value.name;
      subtitle = value.subtitle;

      sectionData[0]["subtitle"] = value.outside;
      sectionData[1]["subtitle"] = value.inside;

      setState(() {});
    });

  }

  void fetchSections() async {
    sectionData.forEach((section) async {
      APIService.fetchMaintenanceItems(section["id"]).then((result) {
        section["items"] = result;
        section["fetched"] = true;
        totalItems = totalItems + section["items"].length;
        fetchedSectionsCount = fetchedSectionsCount + 1;
        if (this.mounted){
          setState((){});
        }

      });
    });
  }

  void getCurrentUserId() async {
    SharedPrefsService.getCurrentUserId().then((id) {
      globals.userId = id;
      getTop3MaintenanceItems();
      print("USER id: userId");
      fetchSections();
      fetchScore();
      fetchUserDetails();
      firebaseNotifications.setUpFirebase(id);
    });
  }

  void getTop3MaintenanceItems() async {
    top3MaintenanceItems = await APIService.fetchTop3Items();
    if (this.mounted){
      setState(() {});
    }

  }

  void getSharedPrefs() async {
    stepsClosed = await SharedPrefsService.getStepsState();
    setState(() {});
  }

  void showAutomateOverlayDialog() {
    Navigator.of(context).push(
        PageRouteBuilder(
            opaque: false,
            pageBuilder: (BuildContext context, _, __) => OverlayAutomateNoItem()
        )
    );
  }

  List<Widget> buildNoTasksLeft(){
    return [
      Container(
        padding: EdgeInsets.symmetric(
          vertical: 20,
          horizontal: ThemeProvider.screenPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              height: 220,
              decoration: BoxDecoration(
                color: Colors.lightBlue,
                borderRadius: BorderRadius.all(Radius.circular(8)),
                image: DecorationImage(
                  image: AssetImage("assets/images/no_tasks.png"),
                  fit: BoxFit.cover
                )
              ),
            ),
            SizedBox(height: 20,),
            Text(
              "Check back later to have more ways to help your seniors live a more enjoyable life at home",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton.icon(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  onPressed: (){},
                  color: ThemeProvider.blue4,
                  icon: Image.asset("assets/images/request.png", width: 20,),
                  label: Text("Make a Request", style: TextStyle(color: Colors.white),),
                ),
              ],
            ),
          ],
        ),
      )
    ];
  }

}