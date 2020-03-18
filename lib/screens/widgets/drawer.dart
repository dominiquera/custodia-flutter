import 'package:custodia/screens/dashboard/widgets/overlay-request-noitem.dart';
import 'package:custodia/screens/login/select.dart';
import 'package:custodia/services/firebase-auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../theme-provider.dart';

class DrawerContent extends StatefulWidget {
  final ScrollController homeController;

  DrawerContent({
    this.homeController
  });

  @override
  _DrawerContentState createState() => _DrawerContentState();
}

class _DrawerContentState extends State<DrawerContent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        header(),
//        menuItem("Subscribe", (){}),
        menuItem("Your HMP", (){widget.homeController.animateTo(0, curve: Curves.easeOut, duration: const Duration(milliseconds: 300));}),
//        menuItem("Categories", (){}),


        menuItem("Make a request", (){showAutomateOverlayDialog();}),
//        menuItem("Profile", (){}),
        menuItemSecondary(Icons.help, "Contact Support", (){_launchURL();}),
        menuItemSecondary(Icons.people, "Help Seniors In Your Area", (){_launchURL();}),
//        menuItem("", (){_launchURL();}),
//        menuItemSecondary(Icons.settings, "Account Settings", (){}),
        menuItem("Log out", logOut),
      ],
    );
  }

  void showAutomateOverlayDialog() {
    Navigator.of(context).push(
        PageRouteBuilder(
            opaque: false,
            pageBuilder: (BuildContext context, _, __) => OverlayAutomateNoItem()
        )
    );
  }

  _launchURL() async {
    const url = 'mailto:service@custodia.com';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget menuItem(String title, Function action) {
    return ListTile(
      onTap: (){action();},
      title: Text(
        title,
        style: TextStyle(
          fontSize: 20,
        )
      ),
    );
  }

  menuItemSecondary(IconData icon, String title, Function action) {
    return ListTile(
      onTap: (){action();},
      leading: Icon(icon, color: ThemeProvider.blue1),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          color: ThemeProvider.blue7
        )
      ),
    );
  }

  Widget header() {
    return Container(
      padding: EdgeInsets.all(15),
      height: 150,
      color: ThemeProvider.blue7,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Image.asset("assets/images/custodia_colour_white_bg_and_fonts.png", width: 200,),
//        child: Text(
//          "Custodia",
//          style: TextStyle(
//            color: Colors.white,
//            fontSize: 28,
//            fontFamily: "NunitoBlack"
//          )
//        ),
      )
    );
  }

  logOut() async {
    FirebaseAuthService.signOut().then((value){
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => LoginSelectScreen()), (Route<dynamic> route) => false
      );
    });
  }
}