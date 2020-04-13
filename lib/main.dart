import 'package:flutter/material.dart';
import 'package:kitabu_android/Screens/root.dart';
import 'package:kitabu_android/Start/Login.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.getInstance().then((prefs) {
    var status = prefs.getString('token');
    runApp(MaterialApp(
      title: 'Kitabu',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: status == null ? Login() : MyControlScreen(),
      )
    );
  });
}