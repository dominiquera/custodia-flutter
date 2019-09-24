import 'package:custodia/screens/splash.dart';
import 'package:custodia/theme-provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.black, // navigation bar color
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Custodia',
      debugShowCheckedModeBanner: false,
      theme: ThemeProvider.theme,
      home: SplashScreen(),
    );
  }


}