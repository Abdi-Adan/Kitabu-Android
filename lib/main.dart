import 'package:flutter/material.dart';



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
      home: SplashPage(),
      // routes: <String, WidgetBuilder> {
      //   "/landingpage": (BuildContext context) => SplashPage(),
      //   "/loginPage": (BuildContext context) =>LoginPage(),
      //   "/HomePage": (BuildContext context) =>Homepage(),
      //   "/ControlScreen": (BuildContext context) =>MyControlScreen(),
      // },
    );
  }
}