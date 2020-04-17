import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:kitabu_android/Screens/Ads/AdsPage.dart';
import 'package:kitabu_android/Screens/Debtors/Debtors.dart';
import 'package:kitabu_android/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';


class MyControlScreen extends StatefulWidget {
  @override
  _MyControlScreenState createState() => _MyControlScreenState();
}

class _MyControlScreenState extends State<MyControlScreen> {
  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();

  List<Widget> _screens = [Homepage(), AdsPage(),];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color(0xff2f00ff),
        elevation: 5.0,
        title: Text(
          "My Loan Book",
          style: TextStyle(color: Colors.white),
        ),
      ),
      drawer: MyDrawer(),
      body: _screens[_page],
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 0,
        height: 50.0,
        items: <Widget>[
          Icon(
            Icons.home,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.receipt,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.timeline,
            size: 30,
            color: Colors.white,
          ),
        ],
        color: Color(0xff2f00ff),
        buttonBackgroundColor: Color(0xFFf47f07),
        backgroundColor: Colors.transparent,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
      ),
    );
  }
}

class MyDrawer extends StatelessWidget {

  //static SharedPreferences prefs;
  //String name = prefs.get('name');
  //String phone = prefs.get('phone');
  //String idnumber = prefs.get('idnumber');

  Future<List<User>> fetchUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.get('token');
    //print(token);
    final response = await http.get(
      'https://kledgerapi.herokuapp.com/user/details',
      headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
    );
    //print(response.body);
    print(response.statusCode);

    if (response.statusCode == 202) {
      List jsonResponse = json.decode(response.body);
      //print(jsonResponse);
      //var creditor = jsonResponse.map((creditor) => new Creditor.fromJson(creditor)).toList();
      //print(creditor);
      return jsonResponse.map((creditor) => new User.fromJson(creditor)).toList();
    } else {
      throw Exception(
            'Something went wrong!',
            );
    }
  }

  static getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.get('token');
    return token;
  }

  fetchData() async{
    String access = getToken();
    final response = await http.get(
      'https://kledgerapi.herokuapp.com/user/details',
      headers: {HttpHeaders.authorizationHeader: "Bearer $access"},
    );
    if (response.statusCode == 202) {
      //var jsonResponse = json.decode(response.body);
      //return jsonResponse.toList();
      Map<String, dynamic> map = json.decode(response.body);
      var user = User.fromJson(map);
      String name = user.name;
      String phone = user.phone;
      String idnumber = user.idnumber;
      _saveToPrefs(name, phone, idnumber);
      return user;
    }else {
      throw Exception(
            'Something went wrong!',
            );
    }

  }

  _saveToPrefs(String name, String phone, String idnumber) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('name', name);
    prefs.setString('phone', phone);
    prefs.setString('idnumber', idnumber);
  }

  @override
  Widget build(BuildContext context){
    var user = fetchUser().then((value){
      return value;
    });
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFFf47f07),
              ),
              child: CircleAvatar(
                backgroundColor: Colors.orange,
                radius: 40,
                child: Text(
                  "K",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 80.0,
                  ),
                ),
              )),
          /*InkWell(
            splashColor: Colors.deepOrange,
            child: ListTile(
              title: Text("Name"),
              subtitle: Text('${user}'),
              trailing: Icon(Icons.perm_contact_calendar),
              onTap: () {},
            ),
          ),
          InkWell(
            splashColor: Colors.deepOrange,
            child: ListTile(
              title: Text("ID"),
              subtitle: Text("$idnumber"),
              trailing: Icon(Icons.calendar_view_day),
              onTap: () {},
            ),
          ),
          InkWell(
            splashColor: Colors.deepOrange,
            child: ListTile(
              title: Text("Phone Number"),
              subtitle: Text("$phone"),
              trailing: Icon(Icons.phone),
              onTap: () {},
            ),
          ),*/
          InkWell(
            splashColor: Colors.deepOrange,
            child: ListTile(
              title: Text("LogOut"),
              trailing: Icon(Icons.lock),
              onTap: () {
                //Navigator.pushReplacement(context, Login());
              },
            ),
          ),
        ],
      ),
    );
  }
}






