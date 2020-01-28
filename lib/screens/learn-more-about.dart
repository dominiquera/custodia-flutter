import 'package:custodia/models/learn_item.dart';
import 'package:custodia/models/maintenance_item.dart';
import 'package:custodia/screens/widgets/drawer.dart';
import 'package:custodia/screens/widgets/list-item.dart';
import 'package:custodia/screens/widgets/progress-indicator.dart';
import 'package:custodia/services/api.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:intl/intl.dart';

import '../theme-provider.dart';

import 'dashboard/widgets/block-footer.dart';
import 'dashboard/widgets/block-header.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class LearnMoreAboutPage extends StatefulWidget  {

  final MaintenanceItem item;
  LearnMoreAboutPage({this.item});

  @override
  _LearnMoreAboutPageState createState() => _LearnMoreAboutPageState();
}

class _LearnMoreAboutPageState extends State<LearnMoreAboutPage>  {

  Color accentColor = ThemeProvider.green4;
  Color accentColor2 = ThemeProvider.green3;
  LearnItem learnItem;

  DateTime now = DateTime.now();
  var formatter = DateFormat('dd MMMM');

  @override
  void initState() {
    fetchLearnMaintenanceItem();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Drawer(
        child: DrawerContent()
      ),
      appBar: GradientAppBar(
        title: Text(formatter.format(now), style: TextStyle(fontFamily: "NunitoBlack", fontSize: 28)),
        centerTitle: false,
        gradient: ThemeProvider.blueGradientHorizontal,
        automaticallyImplyLeading: true,
        leading: IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: navigateBack),
      ),
      body: learnItem != null ? body() : ProgressIndicatorWithPadding(),
    );
  }

  body() {
    return Container(
      padding: EdgeInsets.only(top: 10),
      color: Colors.white,
      child: ListView(
        children: <Widget>[
          HeaderItem(
            title: "Learn More About ${learnItem.title}",
            description: learnItem.summary,
            colorAccent: accentColor2
          ),
          SizedBox(height: 20),
          learnItem != null && learnItem.videoUrl != null ? video() : Container(),
          SizedBox(height: 20),
//          ListItem(
//            description: "Trim the hedges to keep them looking nice",
//            color: accentColor),
//          ListItem(
//            description: "Trim the hedges to keep them looking nice",
//            color: accentColor),
          details()
        ],
      ),
    );
  }

  video(){
    YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: learnItem.videoUrl.split("=")[1],
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );

    return YoutubePlayer(
      controller: _controller,
      showVideoProgressIndicator: false,
    );
  }

  detailsItem(String title, String description, Color circleColor) {
    return Padding(
      padding: EdgeInsets.only(left: ThemeProvider.screenPadding, right: ThemeProvider.screenPadding, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: circleColor,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 10),
              Text(
                title,
                style: TextStyle(
                  fontSize: 26,
                  fontFamily: "NunitoMedium",
                  color: ThemeProvider.darkGrey
                )
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            description,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 20
            )
          )
        ],
      ),
    );
  }

  Widget details() {
    return Container(
      color: ThemeProvider.lightGrey1,
      child: Column(
        children: <Widget>[
          Container(
            height: 10,
            decoration: BoxDecoration(
                gradient: ThemeProvider.greyGradientVertical2
            ),
          ),
          HeaderItem(
              title: "The Details",
              description: "Here are few key details you can use to do it on your own",
              colorAccent: accentColor2
          ),
          SizedBox(height: 20),
          //learnItem.interval != null ? detailsItem("Frequency", learnItem.interval, ThemeProvider.blue1) : Container(),
          learnItem.tools.isNotEmpty ? detailsItem("Tools", learnItem.tools.map((item) { return item.value; }).join(", "), ThemeProvider.green1) : Container(),
          learnItem.materials.isNotEmpty ? detailsItem("Materials", learnItem.materials.map((item) { return item.value; }).join(", "), ThemeProvider.blue5) : Container(),
          FooterItem(mainText: "BACK TO YOUR ", accentText: "HMP", accentColor: accentColor2, onTap: navigateBack)
        ],
      ),
    );
  }

  void navigateBack() {
    Navigator.pop(context);
  }

  void fetchLearnMaintenanceItem() async {
    learnItem = await APIService.fetchLearnMaintenanceItem(widget.item.id);
    setState(() {});
  }
}
