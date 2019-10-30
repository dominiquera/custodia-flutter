import 'package:custodia/screens/login/select.dart';
import 'package:custodia/services/firebase-auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../theme-provider.dart';

class DrawerContent extends StatefulWidget {
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
        menuItem("Subscribe", (){}),
        menuItem("Your HMP", (){}),
        menuItem("Categories", (){}),
        menuItem("Make a request", (){}),
        menuItem("Profile", (){}),
        menuItemSecondary(Icons.headset, "Contact Support", (){}),
        menuItemSecondary(Icons.settings, "Account Settings", (){}),
        menuItem("Log out", logOut),
      ],
    );
  }

  Widget menuItem(String title, Function action) {
    return ListTile(
      onTap: (){action();},
      title: Text(
        title,
        style: TextStyle(
          fontSize: 24,
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
        alignment: Alignment.bottomLeft,
        child: Text(
          "Custodia",
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontFamily: "RobotoBlack"
          )
        ),
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