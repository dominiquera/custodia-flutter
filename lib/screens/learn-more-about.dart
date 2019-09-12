import 'package:custodia/widgets/drawer.dart';
import 'package:custodia/widgets/list-item.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

import '../theme-provider.dart';
import 'dashboard/widgets/block-header.dart';


import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class LearnMoreAbout extends StatefulWidget {
  @override
  _LearnMoreAboutState createState() => _LearnMoreAboutState();
}

class _LearnMoreAboutState extends State<LearnMoreAbout> {

  Color accentColor = ThemeProvider.green1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Drawer(
        child: DrawerContent()// Populate the Drawer in the next step.
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
      padding: const EdgeInsets.only(top: 10),
      color: ThemeProvider.lightGrey1,
      child: ListView(
        children: <Widget>[
          BlockHeader(
            title: "Learn More About Cutting The Grass",
            description: "Suggested for outsided the home. Slide the card to customize",
            colorAccent: accentColor
          ),
//          video(),
          SizedBox(height: 20),
          ListItem(
            title: "Hedge trimming",
            description: "Trim the hedges to keep them looking nice",
            color: accentColor),
          ListItem(
            title: "Hedge trimming",
            description: "Trim the hedges to keep them looking nice",
            color: accentColor),
        ],
      ),
    );
  }

  video() {
    Container(
      width: 200,
      height: 100,
      child: YoutubePlayer(
        context: context,
        videoId: "iLnmTe5Q2Qw",
        flags: YoutubePlayerFlags(
          autoPlay: true,
          showVideoProgressIndicator: true,
        ),
        videoProgressIndicatorColor: Colors.amber,
        progressColors: ProgressColors(
          playedColor: Colors.amber,
          handleColor: Colors.amberAccent,
        ),
//      onPlayerInitialized: (controller) {
//        _controller = controller;
//        _controller.addListener(listener);
//      },
      ),
    );

  }
}
