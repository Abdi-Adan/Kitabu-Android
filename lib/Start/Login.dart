import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kitabu_android/Screens/root.dart';
import 'package:kitabu_android/Start/register.dart';
import 'package:kitabu_android/models/access.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _idTx = new TextEditingController();
  TextEditingController _passTx = new TextEditingController();

  getToken(String idnumber, String password) async {
    var response = await http.post(
      'https://kledgerapi.herokuapp.com/get_token',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'idnumber': idnumber,
        'password': password,
      }),
    );
    Map<String, dynamic> map = json.decode(response.body);
    var accessToken = AccessToken.fromJson(map);
    String token = accessToken.access_token;
    return _saveAccessTokenToPrefs(token);
  }

  _saveAccessTokenToPrefs(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
  }

  @override
  Widget build(BuildContext context) {
    final idField = TextFormField(
      keyboardType: TextInputType.number,
      controller: _idTx,
      obscureText: false,
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFFf47f07),
                width: 1.5,
                style: BorderStyle.solid,
              ),
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFFf47f07),
                width: 1.5,
                style: BorderStyle.solid,
              ),
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          labelText: "ID Number",
          labelStyle: TextStyle(color: Colors.black)),
    );
    final passwordField = TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: _passTx,
      obscureText: true,
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFFf47f07),
                width: 1.5,
                style: BorderStyle.solid,
              ),
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFFf47f07),
                width: 1.5,
                style: BorderStyle.solid,
              ),
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          labelText: "Password",
          labelStyle: TextStyle(color: Colors.black)),
    );

    final loginButon = RaisedButton(
      elevation: 5.0,
      color: Color(0xFFf47f07),
      onPressed: () async {
        getToken(_idTx.text, _passTx.text).whenComplete(() {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (contex) => MyControlScreen()));
        });
      },
      child: Text(
        "Log In",
        style: TextStyle(color: Colors.white),
      ),
    );
    final toButon = RaisedButton(
      elevation: 5.0,
      color: Color(0xFFf47f07),
      onPressed: () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (contex) => RegisterPage()));
      },
      child: Text(
        "Don't have an account? Sign Up.",
        style: TextStyle(color: Colors.white),
      ),
    );

    return Scaffold(
      backgroundColor: Color(0xff2f00ff),
      body: Center(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 45.0),
                  SizedBox(height: 25.0),
                  idField,
                  SizedBox(height: 25.0),
                  SizedBox(height: 25.0),
                  passwordField,
                  SizedBox(
                    height: 35.0,
                  ),
                  loginButon,
                  toButon,
                  SizedBox(
                    height: 15.0,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
