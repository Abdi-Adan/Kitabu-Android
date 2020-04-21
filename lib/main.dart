import 'package:flutter/material.dart';
import 'package:kitabu_android/Screens/Debtors/Debtors.dart';
import 'package:kitabu_android/Screens/root.dart';
import 'package:kitabu_android/Start/Login.dart';
import 'package:kitabu_android/Start/splash.dart';




void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kitabu',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: Splash(),
      routes: <String, WidgetBuilder> {
        "/landingpage": (BuildContext context) => Splash(),
        "/loginPage": (BuildContext context) =>Login(),
        "/HomePage": (BuildContext context) =>Homepage(),
        "/ControlScreen": (BuildContext context) =>MyControlScreen(),
      },
    );
  }
}