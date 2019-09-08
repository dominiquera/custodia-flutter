import 'package:custodia/screens/dashboard/dashboard.dart';
import 'package:custodia/screens/questionnaire/step1.dart';
import 'package:custodia/theme-provider.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Custodia',
      debugShowCheckedModeBanner: false,
      theme: ThemeProvider.theme,
      home: DashboardScreen(),
    );
  }
}
