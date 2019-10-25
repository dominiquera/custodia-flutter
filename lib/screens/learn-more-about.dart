import 'package:custodia/widgets/drawer.dart';
import 'package:custodia/widgets/list-item.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

import '../theme-provider.dart';
import 'package:flutube/flutube.dart';

import 'dashboard/widgets/block-footer.dart';
import 'dashboard/widgets/block-header.dart';

class LearnMoreAbout extends StatefulWidget  {
  @override
  _LearnMoreAboutState createState() => _LearnMoreAboutState();
}

class _LearnMoreAboutState extends State<LearnMoreAbout>  {

  Color accentColor = ThemeProvider.green4;
  Color accentColor2 = ThemeProvider.green3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Drawer(
        child: DrawerContent()
      ),
      appBar: GradientAppBar(
        title: Text('July 3', style: TextStyle(fontFamily: "RobotoBlack", fontSize: 28)),
        centerTitle: false,
        gradient: ThemeProvider.blueGradientHorizontal,
        automaticallyImplyLeading: false,
      ),
      body: body(),
    );
  }

  body() {
    return Container(
      padding: EdgeInsets.only(top: 10),
      color: Colors.white,
      child: ListView(
        children: <Widget>[
          HeaderItem(
            title: "Learn More About Cutting The Grass",
            description: "Suggested for outsided the home. Slide the card to customize",
            colorAccent: accentColor2
          ),
          video(),
          SizedBox(height: 20),
          ListItem(
            description: "Trim the hedges to keep them looking nice",
            color: accentColor),
          ListItem(
            description: "Trim the hedges to keep them looking nice",
            color: accentColor),
          details()

        ],
      ),
    );
  }

  video(){
    return FluTube(
      'https://www.youtube.com/watch?v=fq4N0hgOWzU',
      aspectRatio: 16 / 9,
      autoPlay: true,
      looping: true,
      onVideoStart: () {},
      onVideoEnd: () {},
    );
  }

  detailsItem(String title, String description, Color circleColor) {
    return Padding(
      padding: EdgeInsets.only(left: ThemeProvider.screenPadding, right: ThemeProvider.screenPadding, bottom: 20),
      child: Column(
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
                  fontFamily: "RobotoMedium",
                  color: ThemeProvider.darkGrey
                )
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            description,
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
          detailsItem("Frequency", "Weekly in the Spring and early Summer, Bi-weekly late sumeer and fall", ThemeProvider.blue1),
          detailsItem("Tools", "Weekly in the Spring and early Summer, Bi-weekly late sumeer and fall", ThemeProvider.green1),
          detailsItem("Materials", "Weekly in the Spring and early Summer, Bi-weekly late sumeer and fall", ThemeProvider.blue5),
          FooterItem(mainText: "BACK TO YOUR ", accentText: "HMP", accentColor: accentColor2)
        ],
      ),
    );
  }

}
