import 'package:flutter/material.dart';
import 'package:kitabu_android/StartScreens/splash.dart';




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
      // routes: <String, WidgetBuilder> {
      //   "/landingpage": (BuildContext context) => SplashPage(),
      //   "/loginPage": (BuildContext context) =>LoginPage(),
      //   "/HomePage": (BuildContext context) =>Homepage(),
      //   "/ControlScreen": (BuildContext context) =>MyControlScreen(),
      // },
    );
  }
}