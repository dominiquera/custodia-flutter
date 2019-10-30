import 'package:custodia/screens/dashboard/dashboard.dart';
import 'package:custodia/screens/questionnaire/step_home_types.dart';
import 'package:custodia/screens/splash.dart';
import 'package:custodia/theme-provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.black, // navigation bar color
  ));

//  FirebaseAuth.instance.signOut();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Custodia',
      debugShowCheckedModeBanner: false,
      theme: ThemeProvider.theme,
//      home: DashboardScreen()
    home: SplashScreen()
    );
  }


}