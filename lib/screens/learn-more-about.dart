import 'package:custodia/models/learn_item.dart';
import 'package:custodia/models/maintenance_item.dart';
import 'package:custodia/screens/widgets/drawer.dart';
import 'package:custodia/screens/widgets/list-item.dart';
import 'package:custodia/screens/widgets/progress-indicator.dart';
import 'package:custodia/services/api.dart';
import 'package:custodia/utils/globals.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:intl/intl.dart';

import '../theme-provider.dart';

import 'dashboard/widgets/block-footer.dart';
import 'dashboard/widgets/block-header.dart';
import 'package:youtube_parser/youtube_parser.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'dashboard/widgets/overlay-request.dart';
import 'dashboard/widgets/overlay-done.dart';
import 'dashboard/widgets/overlay-ignore.dart';

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
            title: learnItem.title,
            description: learnItem.description,
            colorAccent: accentColor2
          ),
          SizedBox(height: 20),
          Container(
            height: 220,
            decoration: BoxDecoration(

              image: DecorationImage(image: new NetworkImage(buildImage()),fit: BoxFit.cover)
            ),
          ),
          SizedBox(height: 20),
          buildButtonsRow(),
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

  String buildImage(){
    Image image;
    if (widget.item.imageUrl != null && widget.item.imageUrl != "") {
      return custodiaURL + widget.item.imageUrl;
    } else {
      return "";
    }
  }

  video(){

    String ID = getIdFromUrl(learnItem.videoUrl);
    print(ID);
    YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: ID,
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );

    return Padding(
      padding: EdgeInsets.only(
        left: ThemeProvider.screenPadding,
        right: ThemeProvider.screenPadding,
        bottom: 20
      ),
      child: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: false,
      ),
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
              title: "Learn More",
              description: learnItem.summary,
              colorAccent: accentColor2
          ),
          SizedBox(height: 20),
          learnItem != null && learnItem.videoUrl != null ? video() : Container(),

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
    if (this.mounted){
      setState(() {});
    }
  }

  buildButtonsRow() {
    return Padding(
      padding: EdgeInsets.only(left: ThemeProvider.screenPadding, right: ThemeProvider.screenPadding, bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          FlatButton.icon(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            onPressed: showCloseOverlayDialog,
            color: ThemeProvider.red,
            icon: Icon(Icons.block, color: Colors.white,),
            label: Text("Close", style: TextStyle(color: Colors.white),),
          ),
          FlatButton.icon(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            onPressed: showAutomateOverlayDialog,
            color: ThemeProvider.blue4,
            icon: Image.asset("assets/images/request.png", width: 20,),
            label: Text("Request", style: TextStyle(color: Colors.white),),
          ),
          FlatButton.icon(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            onPressed: markAsDone,
            color: ThemeProvider.green3,
            icon: Icon(Icons.done, color: Colors.white,),
            label: Text("Done",
              style: TextStyle(
                color: Colors.white
              )
            ),
          )
        ],
      ),
    );
  }

  void showCloseOverlayDialog() {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) => OverlayIgnore(
          item: widget.item,
          onIgnore: (int id){}
        )
      )
    );
  }

  markAsDone(){
    APIService.markDoneMaintenanceItem(widget.item.id, onMarkDoneSuccess, onMarkDoneFailure);
  }

  void onMarkDoneSuccess(String body){
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) => DoneOverlayDialog(item: widget.item)
      )
    );
  }

  void onMarkDoneFailure() {
    print(">>>onMarkDoneFailure");
  }

  void showAutomateOverlayDialog() {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) => OverlayAutomate(item: widget.item, onAutomate: (){})
      )
    );
  }
}
